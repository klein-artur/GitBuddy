//
//  LocalChangesViewModel.swift
//  GitBuddy
//
//  Created by Artur Hellmann on 14.01.23.
//

import SwiftUI
import GitCaller

@MainActor
class LocalChangesViewModel: BaseViewModel {

    @Published var status: StatusResult?
    @Published var commitMessage: String = ""
    
    init(repository: Repository, status: StatusResult) {
        self.status = status
        super.init(repository: repository)
    }
    
    func load() {
        defaultErrorHandling { [weak self] in
            self?.status = try await self?.repository.getStatus()
        }
    }
    
    func stage(change: Change) {
        defaultErrorHandling { [weak self] in
            _ = try await self?.repository.stage(file: change.path)
            self?.load()
        }
    }
    
    func unstage(change: Change) {
        defaultErrorHandling { [weak self] in
            _ = try await self?.repository.unstage(file: change.path)
            self?.load()
        }
    }
    
    func commit() {
        defaultErrorHandling { [weak self] in
            _ = try await self?.repository.commit(message: self?.commitMessage ?? "")
            self?.commitMessage = ""
            self?.load()
        }
    }
}
