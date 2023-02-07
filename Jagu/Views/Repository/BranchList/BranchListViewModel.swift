//
//  BranchListViewModel.swift
//  Jagu
//
//  Created by Artur Hellmann on 08.01.23.
//

import Foundation
import GitCaller

@MainActor
class BranchListViewModel: BaseViewModel {
    
    let keyValueRepo: KeyValueRepository
    
    @Published var searchString = ""
    
    @Published var status: StatusResult? = nil
    
    @Published var branchResult: BranchResult? = nil
    
    @Published var toDeleteBranch: Branch? = nil
    @Published var shouldForce: Bool = false
    
    var branchTree: [BranchTreeItem] {
        return branchResult?.tree?.flatten.filter({ item in
            isVisible(for: item)
        }) ?? []
    }
    
    init(
        repository: some Repository,
        keyValueRepo: KeyValueRepository
    ) {
        self.keyValueRepo = keyValueRepo
        super.init(repository: repository)
        self.load()
    }
    
    override func load() {
        defaultTask { [weak self] in
            self?.branchResult = try await self?.repository.getBranches()
            self?.status = try await self?.repository.getStatus()
        }
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
        defaultTask { [weak self] in
            _ = try await self?.repository.checkout(branch: item)
        }
    }
    
    func deleteBranch(for item: Branch) {
        defaultTask { [weak self] in
            _ = try await self?.repository.delete(branch: item, force: self?.shouldForce ?? false)
        }
    }
    
    func mergeBranch(for item: Branch, noFF: Bool) {
        self.defaultTask { [weak self] in
            try await self?.repository.merge(branch: item.name, noFF: noFF)
        }
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
