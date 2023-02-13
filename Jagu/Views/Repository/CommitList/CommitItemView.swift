//
//  CommitItemView.swift
//  Jagu
//
//  Created by Artur Hellmann on 05.01.23.
//

import SwiftUI
import GitCaller

struct CommitItemView: View {
    let commitInfo: CommitListInformation
    
    var body: some View {
        HStack {
            CommitTreeElementView(commitTreeItem: commitInfo.treeItem)
            VStack(alignment: .leading) {
                Text(commitInfo.commit.subject)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(Font.system(Font.TextStyle.body, design: Font.Design.monospaced))
                    .lineLimit(1)
                    .padding(.bottom, 3)
                    .padding(.top, 8)
                    .textSelection(.enabled)
                TagCloudView(tags: commitInfo.commit.tags.map {
                    TagElement(icon: Image("tag-solid"), text: $0) }, backgroundColor: Color(red: 0.87, green: 0.97, blue: 0.89), foregroundColor: .black)
                TagCloudView(tags: commitInfo.commit.branches.map {
                    TagElement(icon: Image("code-branch-solid"), text: $0)
                }, backgroundColor: Color(red: 0.60, green: 0.86, blue: 0.60), foregroundColor: .black)
                HStack {
                    Text(commitInfo.commit.shortHash)
                        .font(Font.system(Font.TextStyle.body, design: Font.Design.monospaced))
                        .textSelection(.enabled)
                    Spacer()
                    Text(commitInfo.commit.author.name)
                        .font(Font.system(Font.TextStyle.body, design: Font.Design.monospaced))
                        .lineLimit(1)
                    Text(commitInfo.commit.authorDate
                        .localized)
                        .font(Font.system(Font.TextStyle.body, design: Font.Design.monospaced))
                }
                Divider()
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.trailing, 16)
    }
}

struct CommitItemView_Previews: PreviewProvider {
    static var previews: some View {
        CommitItemView(
            commitInfo: CommitListInformation(
                commit: Commit(
                    objectHash: "SomeHash",
                    shortHash: "Some",
                    subject: "Some Message",
                    message: "Some Message",
                    author: Person(name: "John Doe", email: "john@doe.com"),
                    authorDateString: "Sun Feb 12 00:03:05 2023 +0100",
                    committer: Person(name: "John Doe", email: "john@doe.com"),
                    committerDateString: "Sun Feb 12 00:03:05 2023 +0100",
                    branches: ["main", "origin/main"],
                    tags: ["onetag", "seocndTag"],
                    parents: []
                ),
                treeItem:
                    CommitTreeItem(
                        branches: [
                            CommitTreeBranch(
                                incoming: [
                                    Line(
                                        begins: 0, ends: 0, isShift: false
                                    )
                                ],
                                outgoing: [
                                    Line(
                                        begins: 0, ends: 0, isShift: false
                                    )
                                ],
                                hasBubble: true,
                                trace: 0
                            ),
                            CommitTreeBranch(
                                incoming: [
                                    Line(
                                        begins: 0, ends: 1, isShift: true
                                    )
                                ],
                                outgoing: [
                                    Line(
                                        begins: 1, ends: 1, isShift: false
                                    )
                                ],
                                hasBubble: false,
                                trace: 0
                            )
                        ],
                        commit: Commit(
                            objectHash: "SomeHash",
                            shortHash: "ShortH",
                            subject: "Some Message",
                            message: "Some Message",
                            author: Person(name: "John Doe", email: "john@doe.com"),
                            authorDateString: "Sun Feb 12 00:03:05 2023 +0100",
                            committer: Person(name: "John Doe", email: "john@doe.com"),
                            committerDateString: "Sun Feb 12 00:03:05 2023 +0100",
                            branches: ["main", "origin/main"],
                            tags: ["onetag", "seocndTag"],
                            parents: []
                        )
                    )
            )
        )
    }
}
