//
//  LocalChangesViewModel.swift
//  Jagu
//
//  Created by Artur Hellmann on 14.01.23.
//

import SwiftUI
import GitCaller

@MainActor
class LocalChangesViewModel: BaseViewModel {

    @Published var status: StatusResult?
    @Published var commitMessage: String = ""
    
    init(repository: some Repository, status: StatusResult) {
        self.status = status
        super.init(repository: repository)
    }
    
    override func load() {
        defaultTask { [weak self] in
            self?.status = try await self?.repository.getStatus()
            
            if self?.status?.status == .merging && self?.commitMessage.isEmpty == true {
                self?.commitMessage = try await self?.repository.getMergeCommitMessage() ?? ""
            }
        }
    }
    
    func stage(change: Change) {
        defaultTask { [weak self] in
            _ = try await self?.repository.stage(file: change.path)
        }
    }
    
    func unstage(change: Change) {
        defaultTask { [weak self] in
            _ = try await self?.repository.unstage(file: change.path)
        }
    }
    
    func commit() {
        defaultTask { [weak self] in
            _ = try await self?.repository.commit(message: self?.commitMessage ?? "")
            self?.commitMessage = ""
        }
    }
    
    func abort() {
        defaultTask { [weak self] in
            try await self?.repository.abortMerge()
        }
    }
    
    func startMerging(change: Change) {
        defaultTask { [weak self] in
            try await self?.repository.mergetool(file: change.path)
        }
    }
    
    func revert(change: Change) {
        alertItem = AlertItem(
            title: "revert alert title",
            message: "revert alert message",
            actions: [
                AlertButton(
                    title: "revert",
                    role: .destructive,
                    action: { [weak self] in
                        self?.defaultTask {
                            _ = try await self?.repository.revert(unstagedFile: change.path)
                            self?.load()
                        }
                    }
                )
            ]
        )
    }
    
    func delete(change: Change) {
        alertItem = AlertItem(
            title: "delete file",
            message: "delete file message",
            actions: [
                AlertButton(
                    title: "delete file",
                    role: .destructive,
                    action: { [weak self] in
                        self?.defaultTask {
                            try FileService().delete(file: change.path)
                        }
                    }
                )
            ]
        )
    }
}
