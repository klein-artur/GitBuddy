//
//  BaseViewModel.swift
//  Jagu
//
//  Created by Artur Hellmann on 30.12.22.
//

import Foundation
import SwiftUI
import Combine
import GitCaller

@MainActor
class BaseViewModel: ObservableObject {
    
    let repository: any Repository
    
    @Published var notARepo: Bool = false
    
    @Published var alertItem: AlertItem? = nil
    
    @Published var gitError: String?
    
    @MainActor @Published var loadingCount: Int = 0
    
    @Published var gitLogBranch: Branch?
    
    var isLoading: Bool {
        loadingCount > 0
    }
    
    var lifetimeCancellables: [AnyCancellable] = []
    
    init(repository: some Repository) {
        self.repository = repository
        
        repository.objectWillChange
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] _ in
                    self?.objectWillChange.send()
                    self?.updateSent()
                })
            .store(in: &lifetimeCancellables)

    }
    
    open func load() {
        
    }
    
    func setLoading() {
        loadingCount += 1
    }
    
    func stopLoading() {
        loadingCount -= 1
        if loadingCount < 0 {
            loadingCount = 0
        }
    }
    
    func handleError(_ error: Error) {
        if let parseError = error as? ParseError {
            switch parseError.type {
            case .notARepository:
                notARepo = true
            default: break
            }
        }
    }
    
    func defaultTask(_ code: @escaping (() async throws -> Void)) {
        setLoading()
        Task {
            do {
                try await code()
            } catch {
                if let parseError = error as? ParseError {
                    if shouldHandleError(parseError: parseError) {
                        self.gitError = parseError.rawOutput
                    }
                } else {
                    print(error)
                }
            }
            await MainActor.run {
                stopLoading()
            }
        }
    }
    
    func showLog(for branch: Branch) {
        gitLogBranch = branch
    }
    
    open func shouldHandleError(parseError: ParseError) -> Bool {
        return true
    }
    
    open func updateSent() {
        self.load()
    }
}
