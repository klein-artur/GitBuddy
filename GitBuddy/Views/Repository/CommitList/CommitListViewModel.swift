//
//  CommitListViewModel.swift
//  GitBuddy
//
//  Created by Artur Hellmann on 05.01.23.
//

import Foundation
import GitCaller

@MainActor
class CommitListViewModel: BaseViewModel {
    
    let repository: Repository
    
    let branch: Branch
    @Published var commitList: CommitList?
    
    init(
        repository: Repository,
        branch: Branch
    ) {
        self.branch = branch
        self.repository = repository
        
        super.init()
    
        Task {
            do {
                commitList = try await repository.getLog(branchName: branch.name).commitPathTree
            } catch {
                commitList = nil
            }
        }
    }
    
}
