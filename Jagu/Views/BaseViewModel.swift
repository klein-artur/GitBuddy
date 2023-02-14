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
import SwiftDose

@MainActor
class BaseViewModel: ObservableObject {
    
    @Published var notARepo: Bool = false
    @Published var alertItem: AlertItem? = nil
    @Published var isLoading: Bool = false
    
    @Dose(\.loadingIndicatorService) var loadingIndicatorService
    
    var lifetimeCancellables: [AnyCancellable] = []
    
    init() {
        loadingIndicatorService.$isLoading
            .receive(on: RunLoop.main)
            .sink { [weak self] isLoading in
                self?.isLoading = isLoading
            }
            .store(in: &lifetimeCancellables)
    }
    
    open func load() {
        
    }
    
    func setLoading() {
        loadingIndicatorService.setLoading()
    }
    
    func stopLoading() {
        loadingIndicatorService.stopLoading()
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
    
    @Dose(\.repository) var repository: any Repository
    
    @Published var gitError: String?
    
    @Published var gitLogBranch: Branch?
    
    override init() {
        super.init()
        
        (repository as? GitRepo)?.objectWillChange
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
