//
//  CommitTreeElementView.swift
//  GitBuddy
//
//  Created by Artur Hellmann on 05.01.23.
//

import SwiftUI
import GitCaller

struct CommitTreeElementView: View {
    var commitTreeItem: CommitTreeItem
    
    var body: some View {
        ZStack {
            ForEach(commitTreeItem.branches.indices, id: \.self) { branchIndex in
                PathShape(item: commitTreeItem.branches[branchIndex], position: branchIndex)
                    .fill(CommitTreeItem.color(for: commitTreeItem.branches[branchIndex].trace))
            }
            ForEach(commitTreeItem.branches.indices, id: \.self) { branchIndex in
                BubbleShape(item: commitTreeItem.branches[branchIndex], position: branchIndex)
                    .fill(CommitTreeItem.color(for: commitTreeItem.branches[branchIndex].trace))
            }
        }
        .frame(width: commitTreeItem.calculatedWidth)
    }
}

struct PathShape: Shape {
    let item: CommitTreeBranch
    let position: Int
    
    func path(in rect: CGRect) -> Path {
        item.drawPath(for: position, in: rect)
    }
}

struct BubbleShape: Shape {
    let item: CommitTreeBranch
    let position: Int
    
    func path(in rect: CGRect) -> Path {
        item.drawBubble(for: position, in: rect)
    }
}

struct CommitTreeElementView_Previews: PreviewProvider {
    static var previews: some View {
        CommitTreeElementView(
            commitTreeItem: CommitTreeItem(
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
                        incoming: [],
                        outgoing: [
                            Line(
                                begins: 0, ends: 1, isShift: false
                            )
                        ],
                        hasBubble: false,
                        trace: 0
                    ),
                    CommitTreeBranch(
                        incoming: [
                            Line(
                                begins: 1, ends: 2, isShift: true
                            )
                        ],
                        outgoing: [
                            Line(
                                begins: 2, ends: 2, isShift: false
                            )
                        ],
                        hasBubble: false,
                        trace: 0
                    ),
                    CommitTreeBranch(
                        incoming: [
                            Line(
                                begins: 3, ends: 3, isShift: false
                            )
                        ],
                        outgoing: [
                            Line(
                                begins: 3, ends: 4, isShift: true
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
                    authorDate: .now,
                    committer: Person(name: "John Doe", email: "john@doe.com"),
                    committerDate: .now,
                    branches: ["main", "origin/main"],
                    tags: ["onetag", "seocndTag"],
                    parents: []
                )
            )
        )
        .frame(height: 80)
    }
}
