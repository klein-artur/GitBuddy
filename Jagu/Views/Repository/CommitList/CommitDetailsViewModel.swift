//
//  CommitDetailsViewModel.swift
//  Jagu
//
//  Created by Artur Hellmann on 12.02.23.
//

import Foundation
import GitCaller

class CommitDetailsViewModel: BaseRepositoryViewModel {
    let commit: Commit
    
    init(commit: Commit) {
        self.commit = commit
        super.init()
    }
    
    var authorInfo: String {
        "\(self.commit.author.name) <\(self.commit.author.email)>"
    }
    
    var committerInfo: String {
        "\(self.commit.committer.name) <\(self.commit.committer.email)>"
    }
    
    var authorDate: String {
        self.commit.authorDate.localized
    }
    
    var committerDate: String {
        self.commit.committerDate.localized
    }
}
