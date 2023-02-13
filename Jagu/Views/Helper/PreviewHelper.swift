//
//  PreviewHelper.swift
//  Jagu
//
//  Created by Artur Hellmann on 15.01.23.
//

import Foundation
import GitCaller

class PreviewRepo: Repository {
    func rebase(onto branch: String) async throws {
        fatalError("Preview and Test Repo implementation used in productive code!")
    }
    
    func abortRebase() async throws {
        fatalError("Preview and Test Repo implementation used in productive code!")
    }
    
    func continueRebase() async throws {
        fatalError("Preview and Test Repo implementation used in productive code!")
    }
    
    func getRebaseCommitMessage() async throws -> String {
        fatalError("Preview and Test Repo implementation used in productive code!")
    }
    
    func pushTags() async throws {
        fatalError("Preview and Test Repo implementation used in productive code!")
    }
    
    func deleteTag(name: String) async throws {
        fatalError("Preview and Test Repo implementation used in productive code!")
    }
    
    func getConfig(scope: GitCaller.ConfigScope, key: GitCaller.ConfigKey) async throws -> String {
        fatalError("Preview and Test Repo implementation used in productive code!")
    }
    
    func setConfig(scope: GitCaller.ConfigScope, key: GitCaller.ConfigKey, value: String) async throws {
        fatalError("Preview and Test Repo implementation used in productive code!")
    }
    
    func unsetConfig(scope: GitCaller.ConfigScope, key: GitCaller.ConfigKey) async throws {
        fatalError("Preview and Test Repo implementation used in productive code!")
    }
    
    func continueMerge() async throws {
        fatalError("Preview and Test Repo implementation used in productive code!")
    }
    
    func clone(url: String) async throws -> GitCaller.CloneResult {
        fatalError("Preview and Test Repo implementation used in productive code!")
    }
    
    static let previewCommits = [
        Commit(
            objectHash: "OneSomeHash",
            shortHash: "OneSome",
            subject: "Some Message",
            message: "Some Message\nBut now with more text.",
            author: Person(name: "John Doe", email: "john@doe.com"),
            authorDateString: "Sun Feb 12 00:03:05 2023 +0100",
            committer: Person(name: "John Doe", email: "john@doe.com"),
            committerDateString: "Sun Feb 12 00:03:05 2023 +0100",
            branches: ["main", "origin/main"],
            tags: ["onetag", "seocndTag"],
            parents: ["FourSomeHashFour", "TwoSomeHashTwo"],
            diff: ""
        ),
        Commit(
            objectHash: "TwoSomeHashTwo",
            shortHash: "OneSome",
            subject: "Some Message",
            message: "Some Message",
            author: Person(name: "John Doe", email: "john@doe.com"),
            authorDateString: "Sun Feb 12 00:03:05 2023 +0100",
            committer: Person(name: "John Doe", email: "john@doe.com"),
            committerDateString: "Sun Feb 12 00:03:05 2023 +0100",
            branches: ["main", "origin/main"],
            tags: ["onetag", "seocndTag"],
            parents: ["ThreeSomeHashThree"],
            diff: ""
        ),
        Commit(
            objectHash: "ThreeSomeHashThree",
            shortHash: "OneSome",
            subject: "Some Message",
            message: "Some Message",
            author: Person(name: "John Doe", email: "john@doe.com"),
            authorDateString: "Sun Feb 12 00:03:05 2023 +0100",
            committer: Person(name: "John Doe", email: "john@doe.com"),
            committerDateString: "Sun Feb 12 00:03:05 2023 +0100",
            branches: ["main", "origin/main"],
            tags: ["onetag", "seocndTag"],
            parents: ["FourSomeHashFour"],
            diff: ""
        ),
        Commit(
            objectHash: "FourSomeHashFour",
            shortHash: "OneSome",
            subject: "Some Message",
            message: "Some Message",
            author: Person(name: "John Doe", email: "john@doe.com"),
            authorDateString: "Sun Feb 12 00:03:05 2023 +0100",
            committer: Person(name: "John Doe", email: "john@doe.com"),
            committerDateString: "Sun Feb 12 00:03:05 2023 +0100",
            branches: ["main", "origin/main"],
            tags: ["onetag", "seocndTag"],
            parents: ["FiveSomeHashFive"],
            diff: ""
        ),
        Commit(
            objectHash: "FiveSomeHashFive",
            shortHash: "OneSome",
            subject: "Some Message",
            message: "Some Message",
            author: Person(name: "John Doe", email: "john@doe.com"),
            authorDateString: "Sun Feb 12 00:03:05 2023 +0100",
            committer: Person(name: "John Doe", email: "john@doe.com"),
            committerDateString: "Sun Feb 12 00:03:05 2023 +0100",
            branches: ["main", "origin/main"],
            tags: ["onetag", "seocndTag"],
            parents: [],
            diff: ""
        )
    ]
    
    func getLog(branchNames: [String]) async throws -> GitCaller.LogResult {
        try LogResultParser().parse(result: "").get()
    }
    
    func getLog(commitHash: String) async throws -> GitCaller.LogResult {
        fatalError("Preview and Test Repo implementation used in productive code!")
    }
    
    func getLog() async throws -> GitCaller.LogResult {
        fatalError("Preview and Test Repo implementation used in productive code!")
    }
    
    func getStatus() async throws -> GitCaller.StatusResult {
        let input = """
        interactive rebase in progress; onto cce8677
        Last command done (1 command done):
           pick 785d8c2 test
        No commands remaining.
        You are currently rebasing branch 'this-is-a-test' on 'cce8677'.
          (fix conflicts and then run "git rebase --continue")
          (use "git rebase --skip" to skip this patch)
          (use "git rebase --abort" to check out the original branch)

        Unmerged paths:
          (use "git restore --staged <file>..." to unstage)
          (use "git add <file>..." to mark resolution)
            both modified:   testfile

        no changes added to commit (use "git add" and/or "git commit -a")
        """
        return try! StatusParser().parse(result: input).get()
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
        fatalError("Preview and Test Repo implementation used in productive code!")
    }
    
    func delete(branch: GitCaller.Branch, force: Bool) async throws -> GitCaller.BranchResult {
        fatalError("Preview and Test Repo implementation used in productive code!")
    }
    
    func stage(file path: String?) async throws {
        fatalError("Preview and Test Repo implementation used in productive code!")
    }
    
    func unstage(file path: String) async throws -> RestoreResult {
        fatalError("Preview and Test Repo implementation used in productive code!")
    }
    
    func revert(unstagedFile path: String) async throws -> RestoreResult {
        fatalError("Preview and Test Repo implementation used in productive code!")
    }
    
    func revertDeleted(unstagedFile path: String) async throws {
        fatalError("Preview and Test Repo implementation used in productive code!")
    }
    
    func commit(message: String) async throws {
        fatalError("Preview and Test Repo implementation used in productive code!")
    }
    
    func fetch() async throws {
        fatalError("Preview and Test Repo implementation used in productive code!")
    }
    
    func pull(force: Bool) async throws -> PullResult {
        fatalError("Preview and Test Repo implementation used in productive code!")
    }
    
    public func push(force: Bool, createUpstream: Bool = false, remoteName: String? = nil, newName: String? = nil) async throws -> PushResult {
        fatalError("Preview and Test Repo implementation used in productive code!")
    }
    
    func newBranchAndCheckout(name: String) async throws -> CheckoutResult {
        fatalError("Preview and Test Repo implementation used in productive code!")
    }
    
    func diff(path: String?, staged: Bool = false, rightPath: String? = nil) async throws -> DiffResult {
        try DiffResultParser().parse(result: Self.simpleOneFileDiff).get()
    }
    
    func needsUpdate() {
        fatalError("Preview and Test Repo implementation used in productive code!")
    }
    
    func merge(branch: String) async throws {
        fatalError("Preview and Test Repo implementation used in productive code!")
    }
    
    func abortMerge() async throws {
        fatalError("Preview and Test Repo implementation used in productive code!")
    }
    
    func mergetool(file: String, tool: String) async throws {
        fatalError("Preview and Test Repo implementation used in productive code!")
    }
    
    func useOurs(path: String) async throws {
        fatalError("Preview and Test Repo implementation used in productive code!")
    }
    
    func useTheirs(path: String) async throws {
        fatalError("Preview and Test Repo implementation used in productive code!")
    }
    
    func getMergeCommitMessage() async throws -> String {
        return "asdf"
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
    +asdf this is some very very long line that should be scrollable to the right if possible. So no elliptizes, no shortinging. Just scrolling to the right should be possible whenever the user wants to scroll.
     
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
    +asdf this is some very very long line that should be scrollable to the right if possible. So no elliptizes, no shortinging. Just scrolling to the right should be possible whenever the user wants to scroll.
     
     @@ -1,5 +1,5 @@
     asdf
    @@ -33,7 +33,7 @@ asdf
     
     
     
    -asdf
    +asdffdsa
     
     
     
    """
}

