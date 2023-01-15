//
//  BaseViewModel.swift
//  GitBuddy
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
    
    @Published var gitError: String = ""
    
    @Published var loadingCount: Int = 0
    
    @Published var gitLogBranch: Branch?
    
    var isLoading: Bool {
        loadingCount > 0
    }
    
    var lifetimeCancellables: [AnyCancellable] = []
    
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
    
    func defaultErrorHandling(_ code: @escaping (() async throws -> Void)) {
        Task {
            do {
                try await code()
            } catch {
                if let parseError = error as? ParseError {
                    self.gitError = parseError.rawOutput
                } else {
                    print(error)
                }
            }
        }
    }
    
    func showLog(for branch: Branch) {
        gitLogBranch = branch
    }
}
