//
//  CommitDetailsViewModel.swift
//  Jagu
//
//  Created by Artur Hellmann on 12.02.23.
//

import Foundation
import GitCaller

class CommitDetailsViewModel: BaseRepositoryViewModel {
    @Published var commit: Commit? = nil
    
    private let commitHash: String
    
    init(commitHash: String) {
        self.commitHash = commitHash
        super.init()
        self.load()
    }
    
    override func load() {
        defaultTask(showLoader: false) { [weak self] in
            guard let self = self else {
                return
            }
            self.commit = try await self.repository
                .show(commitHash: self.commitHash)
                .commits?
                .first
        }
    }
    
    var authorInfo: String {
        guard let commit = self.commit else {
            return ""
        }
        return "\(commit.author.name) <\(commit.author.email)>"
    }
    
    var committerInfo: String {
        guard let commit = self.commit else {
            return ""
        }
        return "\(commit.committer.name) <\(commit.committer.email)>"
    }
    
    var authorDate: String {
        guard let commit = self.commit else {
            return ""
        }
        return commit.authorDate.localized
    }
    
    var committerDate: String {
        guard let commit = self.commit else {
            return ""
        }
        return commit.committerDate.localized
    }
    
    var parents: String {
        guard let commit = self.commit else {
            return ""
        }
        return commit.parents.joined(separator: ", ")
    }
}
