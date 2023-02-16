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

class ChangeLine: ObservableObject {
    let leftItem: ChangeItem
    let rightItem: ChangeItem?
    let onSelected: () -> Void
    
    init(leftItem: ChangeItem, rightItem: ChangeItem?, onSelected: @escaping () -> Void) {
        self.leftItem = leftItem
        self.rightItem = rightItem
        self.onSelected = onSelected
    }
    
    @Published var selected: Bool = false {
        didSet {
            self.onSelected()
        }
    }
}

class LocalChangesViewModel: BaseRepositoryViewModel {

    @Published var status: StatusResult? {
        didSet {
            if let status = self.status {
                let changed = { self.objectWillChange.send() }
                self.unstagedChanges = status.combinedUnstagedChanges.map({ change in
                    switch change.kind {
                    case .modified, .renamed, .newFile, .deleted:
                        return ChangeLine(
                            leftItem: ChangeItem(change: change, otherKind: nil),
                            rightItem: nil,
                            onSelected: changed
                        )
                    case .bothModified:
                        return ChangeLine(
                            leftItem: ChangeItem(change: change, otherKind: .modified),
                            rightItem: ChangeItem(change: change, otherKind: .modified),
                            onSelected: changed
                        )
                    case .bothAdded:
                        return ChangeLine(
                            leftItem: ChangeItem(change: change, otherKind: .newFile),
                            rightItem: ChangeItem(change: change, otherKind: .newFile),
                            onSelected: changed
                        )
                    case .deletedByUs:
                        return ChangeLine(
                            leftItem: ChangeItem(change: change, otherKind: .deleted),
                            rightItem: ChangeItem(change: change, otherKind: .modified),
                            onSelected: changed
                        )
                    case .deletedByThem:
                        return ChangeLine(
                            leftItem: ChangeItem(change: change, otherKind: .modified),
                            rightItem: ChangeItem(change: change, otherKind: .deleted),
                            onSelected: changed
                        )
                    }
                })
                self.stagedChanges = status.stagedChanges.map({ change in
                    ChangeLine(
                        leftItem: ChangeItem(change: change, otherKind: nil),
                        rightItem: nil,
                        onSelected: changed
                    )
                })
            }
        }
    }
    @Published var unstagedChanges: [ChangeLine] = []
    @Published var stagedChanges: [ChangeLine] = []
    @Published var commitMessage: String = ""
    
    var selectedUnstagedChanges: [ChangeLine] {
        self.unstagedChanges.filter { $0.selected }
    }
    var selectedStagedChanges: [ChangeLine] {
        self.stagedChanges.filter { $0.selected }
    }
    
    init(status: StatusResult) {
        self.status = status
        super.init()
    }
    
    override func load() {
        defaultTask { [weak self] in
            self?.status = try await self?.repository.getStatus()
            
            if (self?.status?.status == .merging || self?.status?.status == .rebasing) && self?.commitMessage.isEmpty == true {
                let mergeCommitMessage = try await self?.repository.getMergeCommitMessage()
                let rebaseCommitMessage = try await self?.repository.getRebaseCommitMessage()
                self?.commitMessage = mergeCommitMessage ?? rebaseCommitMessage ?? ""
            }
        }
    }
    
    func stage(change: Change?) {
        defaultTask { [weak self] in
            guard let self = self else {
                return
            }
            if let change = change {
                _ = try await self.repository.stage(file: change.path)
            } else if !self.selectedUnstagedChanges.isEmpty {
                try await self.repository.stage(files: self.selectedUnstagedChanges.map { $0.leftItem.change.path })
            } else {
                _ = try await self.repository.stage(file: nil)
            }
            self.stagedChanges.forEach { line in
                line.selected = false
            }
            self.unstagedChanges.forEach { line in
                line.selected = false
            }
        }
    }
    
    func unstage(change: Change?) {
        defaultTask { [weak self] in
            guard let self = self else {
                return
            }
            if let change = change {
                _ = try await self.repository.unstage(file: change.path)
            } else if !self.selectedStagedChanges.isEmpty {
                try await self.repository.unstage(files: self.selectedStagedChanges.map { $0.leftItem.change.path })
            } else {
                _ = try await self.repository.unstage(file: nil)
            }
            self.stagedChanges.forEach { line in
                line.selected = false
            }
            self.unstagedChanges.forEach { line in
                line.selected = false
            }
        }
    }
    
    func commit() {
        defaultTask { [weak self] in
            _ = try await self?.repository.commit(message: self?.commitMessage ?? "")
            self?.commitMessage = ""
            if self?.status?.status == .rebasing {
                try await self?.repository.continueRebase()
            }
        }
    }
    
    func abort() {
        defaultTask { [weak self] in
            if self?.status?.status == .merging {
                try await self?.repository.abortMerge()
            } else {
                try await self?.repository.abortRebase()
            }
        }
    }
    
    func startMerging(change: Change) {
        defaultTask { [weak self] in
            try await self?.repository.mergetool(file: change.path)
        }
    }
    
    func revert(change: Change) {
        if change.kind == .modified {
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
                            }
                        }
                    )
                ]
            )
        } else {
            defaultTask { [weak self] in
                try await self?.repository.revertDeleted(unstagedFile: change.path)
            }
        }
    }
    
    func revertSelectedCanges() {
        alertItem = AlertItem(
            title: "revert alert title",
            message: "revert alert message",
            actions: [
                AlertButton(
                    title: "revert",
                    role: .destructive,
                    action: { [weak self] in
                        guard let self = self else {
                            return
                        }
                        self.defaultTask {
                            try await self.repository.revert(unstagedFiles: self.selectedUnstagedChanges.map { $0.leftItem.change.path })
                            self.stagedChanges.forEach { line in
                                line.selected = false
                            }
                            self.unstagedChanges.forEach { line in
                                line.selected = false
                            }
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
                            try FileService(fileManager: FileManager.default, repository: GitRepo.standard).delete(file: change.path)
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
                                    try FileService(fileManager: FileManager.default, repository: GitRepo.standard).delete(file: item.change.path)
                                }
                                _ = try await self?.repository.stage(file: item.change.path)
                            case .deletedByThem: 
                                if !left {
                                    try FileService(fileManager: FileManager.default, repository: GitRepo.standard).delete(file: item.change.path)
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
    
    var viewTitle: String {
        guard let status = self.status else {
            return ""
        }
        
        switch status.status {
        case .merging, .rebasing:
            return "continue".localized
        case .unclean:
            return "commit".localized
        default:
            return ""
        }
    }
    
    func stageButtonText(staged: Bool) -> String {
        if staged {
            return (selectedStagedChanges.isEmpty ? "unstage all" : "unstage selected").localized
        } else {
            return (selectedUnstagedChanges.isEmpty ? "stage all" : "stage selected").localized
        }
    }
    
    func revertButtonText() -> String {
        (selectedUnstagedChanges.isEmpty ? "revert all" : "revert selected").localized
    }
    
    func getChangeFor(item: ChangeLine, staged: Bool, offset: Int) -> DiffChange? {
        guard item.rightItem == nil && item.leftItem.change.kind.canShowDetails else {
            return nil
        }
        if offset == 0 {
            return DiffChange(change: item, staged: staged)
        } else {
            if staged {
                guard let index = self.stagedChanges.firstIndex(where: { $0.leftItem.change.path == item.leftItem.change.path}) else {
                    return nil
                }
                if offset < 0 {
                    guard index > 0 else {
                        return nil
                    }
                    for searchIndex in (0...(index - 1)).reversed() {
                        if let checkItem = getChangeFor(item: self.stagedChanges[searchIndex], staged: staged, offset: 0) {
                            return checkItem
                        }
                    }
                } else {
                    guard index < stagedChanges.count - 1 else {
                        return nil
                    }
                    for searchIndex in (index + 1)..<unstagedChanges.endIndex {
                        if let checkItem = getChangeFor(item: self.stagedChanges[searchIndex], staged: staged, offset: 0) {
                            return checkItem
                        }
                    }
                }
                return nil
            } else {
                guard let index = self.unstagedChanges.firstIndex(where: { $0.leftItem.change.path == item.leftItem.change.path}) else {
                    return nil
                }
                if offset < 0 {
                    guard index > 0 else {
                        return nil
                    }
                    for searchIndex in (0...(index - 1)).reversed() {
                        if let checkItem = getChangeFor(item: self.unstagedChanges[searchIndex], staged: staged, offset: 0) {
                            return checkItem
                        }
                    }
                } else {
                    guard index < unstagedChanges.count - 1 else {
                        return nil
                    }
                    for searchIndex in (index + 1)..<unstagedChanges.endIndex {
                        if let checkItem = getChangeFor(item: self.unstagedChanges[searchIndex], staged: staged, offset: 0) {
                            return checkItem
                        }
                    }
                }
                return nil
            }
        }
    }
    
    var mergeOrRebaseInfo: String {
        guard let status = self.status else {
            return ""
        }
        switch status.status {
        case .merging:
            return "in middle of merge".localized
        case .rebasing:
            return "in middle of rebase".localized.formatted(status.rebasingStepsDone, status.rebasingStepsRemaining)
        default:
            return ""
        }
    }
}

extension StatusResult {
    var canContinue: Bool {
        (isMerging || isRebasing) && combinedUnstagedChanges.isEmpty && stagedChanges.isEmpty
    }
}

extension Change: Equatable {
    public static func == (lhs: Change, rhs: Change) -> Bool {
        lhs.path == rhs.path
    }
}
