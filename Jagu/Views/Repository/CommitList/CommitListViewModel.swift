//
//  CommitListViewModel.swift
//  Jagu
//
//  Created by Artur Hellmann on 05.01.23.
//

import Foundation
import GitCaller

@MainActor
class CommitListViewModel: BaseViewModel {
    
    let branch: Branch?
    @Published var commitList: CommitList?
    
    init(
        repository: some Repository,
        branch: Branch?
    ) {
        self.branch = branch
        
        super.init(repository: repository)
        
        load()
    
    }
    
    override func load() {
        defaultTask { [weak self] in
            if let branch = self?.branch {
                var branchName: String = ""
                if let upstream = branch.upstream {
                    branchName = "\(branch.name) \(upstream.name)"
                } else {
                    branchName = branch.name
                }
                self?.commitList = try await self?.repository.getLog(branchName: branchName).commitPathTree
            } else {
                self?.commitList = try await self?.repository.getLog().commitPathTree
            }
        }
    }
    
    func checkoutBranch() {
        defaultTask { [weak self] in
            guard let self = self, let branch = self.branch else {
                return
            }
            let result = try await self.repository.checkout(branch: branch)
            if result.didChange {
                AppDelegate.shared?.reload()
            }
        }
    }
    
}
