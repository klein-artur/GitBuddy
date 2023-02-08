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
    
    @Published var notARepo: Bool = false
    
    @Published var alertItem: AlertItem? = nil
    
    @MainActor @Published var loadingCount: Int = 0
    
    var isLoading: Bool {
        loadingCount > 0
    }
    
    var lifetimeCancellables: [AnyCancellable] = []
    
    open func load() {
        
    }
    
    func handleError(_ error: Error) {
        if let localized = error as? LocalizedError {
            alertItem = AlertItem(
                title: "error",
                message: localized.localizedDescription,
                actions: []
            )
        }
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
    
    func defaultTask(_ code: @escaping (() async throws -> Void)) {
        setLoading()
        Task {
            do {
                try await code()
            } catch {
                handleError(error)
            }
            await MainActor.run {
                stopLoading()
            }
        }
    }
    
    open func updateSent() {
        self.load()
    }
}

class BaseRepositoryViewModel: BaseViewModel {
    
    let repository: any Repository
    
    @Published var gitError: String?
    
    @Published var gitLogBranch: Branch?
    
    init(repository: some Repository) {
        self.repository = repository
        
        super.init()
        
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
    
    override func handleError(_ error: Error) {
        if let parseError = error as? ParseError {
            switch parseError.type {
            case .notARepository:
                notARepo = true
            default:
                if shouldHandleError(parseError: parseError) {
                    self.gitError = parseError.rawOutput
                }
            }
        } else {
            super.handleError(error)
        }
    }
    
    open func shouldHandleError(parseError: ParseError) -> Bool {
        return true
    }
    
    func showLog(for branch: Branch) {
        gitLogBranch = branch
    }
}
