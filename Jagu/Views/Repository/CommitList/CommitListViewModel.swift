//
//  CommitListViewModel.swift
//  Jagu
//
//  Created by Artur Hellmann on 05.01.23.
//

import Foundation
import GitCaller

@MainActor
class CommitListViewModel: BaseRepositoryViewModel {
    
    var branch: Branch?
    @Published var commitList: CommitList?
    
    @Published var tagCreationCommit: Commit? = nil
    @Published var tagName: String = ""
    @Published var hasTagMessage: Bool = false
    @Published var tagMessage: String = ""
    
    init(
        branch: Branch?
    ) {
        self.branch = branch
        
        super.init()
        
        load()
    }
    
    override func load() {
        defaultTask { [weak self] in
            if var branch = self?.branch {
                
                if let foundBranch = try await self?.repository.getBranches().branches?.first(where: { b in
                    b.name == branch.name
                }) {
                    self?.branch = foundBranch
                    branch = foundBranch
                }
                
                var branchNames: [String] = [branch.name]
                if let upstream = branch.upstream {
                    branchNames.append(upstream.name)
                }
                self?.commitList = try await self?.repository.getLog(branchNames: branchNames).commitPathTree
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
    
    func creeateTag(commit: Commit) {
        defaultTask { [weak self] in
            guard let name = self?.tagName else {
                return
            }
            
            try await self?.repository.createTag(
                name: name,
                on: commit.objectHash,
                message: self?.hasTagMessage == true ? self?.tagMessage : nil
            )
            
            self?.tagCreationCommit = nil
            self?.tagName = ""
            self?.tagMessage = ""
            self?.hasTagMessage = false
        }
    }
    
}
