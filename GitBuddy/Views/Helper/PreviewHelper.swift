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
        return try BranchResultParser().parse(result: """
        * (HEAD detached at fadce24)
          Savebranch                             8667982e1 fixed issue
          main                                   8667982e1 [ahead 2] fixed issue
          other                                  8667982e1 [behind 2] fixed issue
          test/nested                            8667982e1 [ahead 3, behind 2] fixed issue
          remotes/origin/HEAD -> origin/main
          remotes/origin/main
        """).get()
    }
    
    func checkout(branch: GitCaller.Branch) async throws -> GitCaller.CheckoutResult {
        fatalError("not implemented")
    }
    
    func delete(branch: GitCaller.Branch, force: Bool) async throws -> GitCaller.BranchResult {
        fatalError("not implemented")
    }
    
    func stage(file path: String?) async throws {
        fatalError("not implemented")
    }
    
    func unstage(file path: String) async throws -> RestoreResult {
        fatalError("not implemented")
    }
    
    func revert(unstagedFile path: String) async throws -> RestoreResult {
        fatalError("not implemented")
    }
    
    func commit(message: String) async throws {
        fatalError("not implemented")
    }
    
    func fetch() async throws {
        fatalError("not implemented")
    }
    
    func pull(force: Bool) async throws -> PullResult {
        fatalError("not implemented")
    }
    
    public func push(force: Bool, createUpstream: Bool = false, remoteName: String? = nil, newName: String? = nil) async throws -> PushResult {
        fatalError("not implemented")
    }
    
    func newBranchAndCheckout(name: String) async throws -> CheckoutResult {
        fatalError("not implemented")
    }
    
    func diff(path: String?, staged: Bool = false, rightPath: String? = nil) async throws -> DiffResult {
        try DiffResultParser().parse(result: Self.simpleOneFileDiff).get()
    }
    
    static let simpleTwoFileDiff: String = """
    diff --git a/some/file/diffFile b/some/file/diffFile2
    index 2959c86..1f2aa9f 100644
    --- a/some/file/diffFile
    +++ b/some/file/diffFile2
    @@ -1,5 +1,5 @@
     asdf
     
    -asdf
    +asdfasdf
     
     asdf
    diff --git a/some/file/diffFile2 b/some/file/diffFile2
    index 2959c86..91b7927 100644
    --- a/some/file/diffFile2
    +++ b/some/file/diffFile2
    @@ -3 +3 @@ asdf
     
     asdf
     
    -
    +asdf
     
     @@ -1,5 +1,5 @@
     asdf
    @@ -33,7 +33,7 @@ asdf
     
     
     
    -asdf
    +asdffdsa
     
     
     
    """
    
    static let simpleOneFileDiff: String = """
    diff --git a/some/file/diffFile2 b/some/file/diffFile2
    index 2959c86..91b7927 100644
    --- a/some/file/diffFile2
    +++ b/some/file/diffFile2
    @@ -3 +3 @@ asdf
     
     asdf
     
    -
    +asdf
     
     @@ -1,5 +1,5 @@
     asdf
    @@ -33,7 +33,7 @@ asdf
     
     
     
    -asdf
    +asdffdsa
     
     
     
    """
}

