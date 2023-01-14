//
//  BranchListViewModel.swift
//  GitBuddy
//
//  Created by Artur Hellmann on 08.01.23.
//

import Foundation
import GitCaller

@MainActor
class BranchListViewModel: BaseViewModel {
    
    let branchResult: BranchResult
    let keyValueRepo: KeyValueRepository
    
    @Published var searchString = ""
    
    var branchTree: [BranchTreeItem] {
        return branchResult.tree?.flatten.filter({ item in
            isVisible(for: item)
        }) ?? []
    }
    
    init(branchResult: BranchResult, keyValueRepo: KeyValueRepository) {
        self.branchResult = branchResult
        self.keyValueRepo = keyValueRepo
        super.init()
    }
    
    func isVisible(for item: BranchTreeItem) -> Bool {
        if let conforms = item.conforms(to: searchString), conforms {
            return true
        } else if !searchString.isEmpty {
            return false
        }
        guard let parent = item.parent else {
            return true
        }
        return inheritedOpenState(for: parent)
    }
    
    private func inheritedOpenState(for item: BranchTreeItem) -> Bool {
        if !openState(for: item) {
            return false
        } else {
            guard let parent = item.parent else {
                return true
            }
            return inheritedOpenState(for: parent)
        }
    }
    
    private func openState(for item: BranchTreeItem) -> Bool {
        keyValueRepo.value(for: .branchPathOpen(item.fullPath, true))
    }
    
    func changeOpenState(for item: BranchTreeItem) {
        keyValueRepo.set(key: .branchPathOpen(item.fullPath, !openState(for: item)))
        objectWillChange.send()
    }
    
    func checkoutBranch(for item: Branch) {
        defaultErrorHandling {
            let result = try await GitRepo.standard.checkout(branch: item)
            if result.didChange {
                AppDelegate.shared?.reload()
            }
        }
    }
    
    func deleteBranch(for item: Branch) {
        self.alertItem = AlertItem(
            title: "Delete Branch",
            message: "delete local branch message",
            actions: [
                AlertAction(
                    title: "Delete Branch",
                    role: .destructive,
                    action: { [weak self] in
                        self?.defaultErrorHandling {
                            let result = try await GitRepo.standard.delete(branch: item)
                            if result.deletionSuccessfull {
                                AppDelegate.shared?.reload()
                            }
                        }
                    }
                )
            ]
        )
    }
    
}

extension BranchTreeItem {
    func conforms(to searchString: String) -> Bool? {
        guard !searchString.isEmpty else {
            return nil
        }
        if self.fullPath.contains(searchString) {
            return true
        } else {
            return self.children.map { child in
                child.conforms(to: searchString) ?? false
            }
            .first { $0 } ?? false
        }
    }
}
