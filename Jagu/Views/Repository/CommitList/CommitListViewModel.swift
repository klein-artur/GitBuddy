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
    
    let branch: Branch
    @Published var commitList: CommitList?
    
    init(
        repository: some Repository,
        branch: Branch
    ) {
        self.branch = branch
        
        super.init(repository: repository)
    
        defaultTask { [weak self] in
            self?.commitList = try await repository.getLog(branchName: branch.name).commitPathTree
        }
    }
    
    func checkoutBranch() {
        defaultTask { [weak self] in
            guard let self = self else {
                return
            }
            let result = try await self.repository.checkout(branch: self.branch)
            if result.didChange {
                AppDelegate.shared?.reload()
            }
        }
    }
    
}
