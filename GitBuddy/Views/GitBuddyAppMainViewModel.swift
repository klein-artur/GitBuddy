//
//  GitBuddyAppMainViewModel.swift
//  GitBuddy
//
//  Created by Artur Hellmann on 30.12.22.
//

import Foundation
import SwiftUI
import Combine
import GitCaller

@MainActor
class GitBuddyAppMainViewModel: BaseViewModel {
    
    @Published var status: StatusResult?
    
    var repoPathPublisher: (any Publisher<String?, Never>)? {
        didSet {
            guard let repoPathPublisher = repoPathPublisher else { return }
            repoPathPublisher
                .sink { [weak self] in
                    self?.repoName = $0?.lastPathComponent
                    self?.repoPath = $0
                }
                .store(in: &self.lifetimeCancellables)
        }
    }
    
    private func load() {
        defaultTask { [weak self] in
            self?.status = try await self?.repository.getStatus()
        }
    }
    
    override func updateSent() {
        load()
    }
    
    @Published var repoName: String?
    @Published var repoPath: String?
    
    @MainActor
    func pull(force: Bool) {
        if force {
            self.alertItem = AlertItem(
                title: "Force Pull",
                message: "Force Pull Message",
                actions: [
                    AlertAction(title: "yes", role: .destructive, action: { [weak self] in
                        self?.defaultTask {
                            _ = try await self?.repository.pull(force: force)
                        }
                    })
                ]
            )
        } else {
            defaultTask { [weak self] in
                _ = try await self?.repository.pull(force: force)
            }
        }
    }
    
    @MainActor
    func push(force: Bool) {
        if force {
            self.alertItem = AlertItem(
                title: "Force Push",
                message: "Force Push Message",
                actions: [
                    AlertAction(title: "yes", role: .destructive, action: { [weak self] in
                        self?.defaultTask {
                            _ = try await self?.repository.push(force: force)
                        }
                    })
                ]
            )
        } else {
            defaultTask { [weak self] in
                _ = try await self?.repository.push(force: force)
            }
        }
    }
    
    override func shouldHandleError(parseError: ParseError) -> Bool {
        if parseError.type == .notARepository {
            return false
        } else {
            return super.shouldHandleError(parseError: parseError)
        }
    }
}
