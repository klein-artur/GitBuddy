//
//  LocalChangesViewModel.swift
//  Jagu
//
//  Created by Artur Hellmann on 14.01.23.
//

import SwiftUI
import GitCaller

struct ChangeItem {
    let change: Change
    let otherKind: Change.Kind?
    var changeKind: Change.Kind {
        otherKind ?? change.kind
    }
}

struct ChangeLine {
    let leftItem: ChangeItem
    let rightItem: ChangeItem?
}

@MainActor
class LocalChangesViewModel: BaseViewModel {

    @Published var status: StatusResult? {
        didSet {
            if let status = self.status {
                self.unstagedChanges = status.combinedUnstagedChanges.map({ change in
                    switch change.kind {
                    case .modified, .renamed, .newFile, .deleted:
                        return ChangeLine(
                            leftItem: ChangeItem(change: change, otherKind: nil),
                            rightItem: nil
                        )
                    case .bothModified:
                        return ChangeLine(
                            leftItem: ChangeItem(change: change, otherKind: .modified),
                            rightItem: ChangeItem(change: change, otherKind: .modified)
                        )
                    case .bothAdded:
                        return ChangeLine(
                            leftItem: ChangeItem(change: change, otherKind: .newFile),
                            rightItem: ChangeItem(change: change, otherKind: .newFile)
                        )
                    case .deletedByUs:
                        return ChangeLine(
                            leftItem: ChangeItem(change: change, otherKind: .deleted),
                            rightItem: ChangeItem(change: change, otherKind: .modified)
                        )
                    case .deletedByThem:
                        return ChangeLine(
                            leftItem: ChangeItem(change: change, otherKind: .modified),
                            rightItem: ChangeItem(change: change, otherKind: .deleted)
                        )
                    }
                })
                self.stagedChanges = status.stagedChanges.map({ change in
                    ChangeLine(
                        leftItem: ChangeItem(change: change, otherKind: nil),
                        rightItem: nil
                    )
                })
            }
        }
    }
    @Published var unstagedChanges: [ChangeLine] = []
    @Published var stagedChanges: [ChangeLine] = []
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
    
    func use(item: ChangeItem, in change: ChangeLine, left: Bool) {
        if change.rightItem != nil {
            alertItem = AlertItem(
                title: left ? "Using our" : "Using their",
                message: left ? "Using our message" : "Using their message",
                actions: [
                    AlertButton(title: "ok", action: { [weak self] in
                        
                        self?.defaultTask {
                            switch item.change.kind {
                            case .bothAdded, .bothModified:
                                if left {
                                    _ = try await self?.repository.useOurs(path: item.change.path)
                                } else {
                                    _ = try await self?.repository.useTheirs(path: item.change.path)
                                }
                            case .deletedByUs:
                                if left {
                                    try FileService().delete(file: item.change.path)
                                }
                                _ = try await self?.repository.stage(file: item.change.path)
                            case .deletedByThem: 
                                if !left {
                                    try FileService().delete(file: item.change.path)
                                }
                                _ = try await self?.repository.stage(file: item.change.path)
                            default: break
                            }
                        }
                        
                    }),
                    AlertButton(title: "cancel", action: { })
                ]
            )
        }
    }
    
    func doubleClicked(change: ChangeLine, staged: Bool) {
        if !change.leftItem.change.kind.conflict {
            if staged {
                self.unstage(change: change.leftItem.change)
            } else {
                self.stage(change: change.leftItem.change)
            }
        }
    }
    
    var canContinue: Bool {
        self.status?.canContinue ?? false
    }
}

extension StatusResult {
    var canContinue: Bool {
        isMerging && combinedUnstagedChanges.isEmpty && stagedChanges.isEmpty
    }
}
