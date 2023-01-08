//
//  CommitListViewModel.swift
//  GitBuddy
//
//  Created by Artur Hellmann on 05.01.23.
//

import Foundation
import GitCaller

class CommitListViewModel: BaseViewModel {
    
    let gitLog: LogResult
    
    lazy var commitList: CommitList? = {
        gitLog.commitPathTree
    }()
    
    init(gitLog: LogResult) {
        self.gitLog = gitLog
        super.init()
    }
    
}
