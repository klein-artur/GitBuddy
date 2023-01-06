//
//  CommitListView.swift
//  GitBuddy
//
//  Created by Artur Hellmann on 05.01.23.
//

import SwiftUI
import GitParser

struct CommitListView: View {
    @ObservedObject var commitListViewModel: CommitListViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(commitListViewModel.commitList.indices, id: \.self) { index in
                    CommitItemView(commitInfo: commitListViewModel.commitList[index])
                        .padding(0)
                        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
            }
        }
    }
}

struct CommitListView_Previews: PreviewProvider {
    static var previews: some View {
        CommitListView(
            commitListViewModel: CommitListViewModel(
                gitLog: LogResult(
                    originalOutput: "",
                    commits: [
                        Commit(
                            objectHash: "OneSomeHash",
                            shortHash: "OneSome",
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
            )
        )
    }
}
