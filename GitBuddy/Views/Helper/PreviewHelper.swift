//
//  PreviewHelper.swift
//  GitBuddy
//
//  Created by Artur Hellmann on 15.01.23.
//

import Foundation
import GitCaller

class PreviewRepo: Repository {
    func clone(url: String) async throws -> GitCaller.CloneResult {
        fatalError("not implemented")
    }
    
    func getLog(branchName: String) async throws -> GitCaller.LogResult {
        LogResult(
            originalOutput: "",
            commits: [
                Commit(
                    objectHash: "OneSomeHash",
                    shortHash: "OneSome",
                    subject: "Some Message",
                    message: "Some Message",
                    author: Person(name: "John Doe", email: "john@doe.com"),
                    authorDate: .now,
                    committer: Person(name: "John Doe", email: "john@doe.com"),
                    committerDate: .now,
                    branches: ["main", "origin/main"],
                    tags: ["onetag", "seocndTag"],
                    parents: ["FourSomeHashFour", "TwoSomeHashTwo"]
                ),
                Commit(
                    objectHash: "TwoSomeHashTwo",
                    shortHash: "OneSome",
                    subject: "Some Message",
                    message: "Some Message",
                    author: Person(name: "John Doe", email: "john@doe.com"),
                    authorDate: .now,
                    committer: Person(name: "John Doe", email: "john@doe.com"),
                    committerDate: .now,
                    branches: ["main", "origin/main"],
                    tags: ["onetag", "seocndTag"],
                    parents: ["ThreeSomeHashThree"]
                ),
                Commit(
                    objectHash: "ThreeSomeHashThree",
                    shortHash: "OneSome",
                    subject: "Some Message",
                    message: "Some Message",
                    author: Person(name: "John Doe", email: "john@doe.com"),
                    authorDate: .now,
                    committer: Person(name: "John Doe", email: "john@doe.com"),
                    committerDate: .now,
                    branches: ["main", "origin/main"],
                    tags: ["onetag", "seocndTag"],
                    parents: ["FourSomeHashFour"]
                ),
                Commit(
                    objectHash: "FourSomeHashFour",
                    shortHash: "OneSome",
                    subject: "Some Message",
                    message: "Some Message",
                    author: Person(name: "John Doe", email: "john@doe.com"),
                    authorDate: .now,
                    committer: Person(name: "John Doe", email: "john@doe.com"),
                    committerDate: .now,
                    branches: ["main", "origin/main"],
                    tags: ["onetag", "seocndTag"],
                    parents: ["FiveSomeHashFive"]
                ),
                Commit(
                    objectHash: "FiveSomeHashFive",
                    shortHash: "OneSome",
                    subject: "Some Message",
                    message: "Some Message",
                    author: Person(name: "John Doe", email: "john@doe.com"),
                    authorDate: .now,
                    committer: Person(name: "John Doe", email: "john@doe.com"),
                    committerDate: .now,
                    branches: ["main", "origin/main"],
                    tags: ["onetag", "seocndTag"],
                    parents: []
                )
            ]
        )
    }
    
    func getLog(commitHash: String) async throws -> GitCaller.LogResult {
        fatalError("not implemented")
    }
    
    func getLog() async throws -> GitCaller.LogResult {
        fatalError("not implemented")
    }
    
    func getStatus() async throws -> GitCaller.StatusResult {
        return StatusResult.getTestStatus()
    }
    
    func getBranches() async throws -> GitCaller.BranchResult {
        fatalError("not implemented")
    }
    
    func checkout(branch: GitCaller.Branch) async throws -> GitCaller.CheckoutResult {
        fatalError("not implemented")
    }
    
    func delete(branch: GitCaller.Branch, force: Bool) async throws -> GitCaller.BranchResult {
        fatalError("not implemented")
    }
    
    func stage(file path: String?) async throws -> AddResult {
        fatalError("not implemented")
    }
    
    func unstage(file path: String) async throws -> RestoreResult {
        fatalError("not implemented")
    }
    
    func commit(message: String) async throws -> CommitResult {
        fatalError("not implemented")
    }
}

