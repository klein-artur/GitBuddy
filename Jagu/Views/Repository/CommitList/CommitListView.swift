//
//  CommitListView.swift
//  Jagu
//
//  Created by Artur Hellmann on 05.01.23.
//

import SwiftUI
import GitCaller
import SwiftDose

struct CommitListView: View {
    @StateObject var commitListViewModel: CommitListViewModel
    
    var body: some View {
        if let commitList = commitListViewModel.commitList {
            VStack {
                if let branch = commitListViewModel.branch {
                    HStack {
                        BranchElementView(
                            viewModel: BranchElementViewModel(
                                branch: branch,
                                status: nil,
                                showLogButton: false
                            )
                        )
                        Spacer()
                        if !branch.isCurrent {
                            Button("Checkout") {
                                commitListViewModel.checkoutBranch()
                            }
                        }
                    }
                    .padding([.horizontal, .top], 16)
                    Divider()
                        .padding(.horizontal, 16)
                }
                ScrollView {
                    LazyVStack {
                        ForEach(commitList, id: \.commit.objectHash) { commitInfo in
                            CommitItemView(commitInfo: commitInfo)
                                .padding(0)
                                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                                .contentShape(Rectangle())  
                                .contextMenu {
                                    Button("create tag title") {
                                        commitListViewModel.tagCreationCommit = commitInfo.commit
                                    }
                                }
                        }
                    }
                    .padding(16)
                }
            }
            .gitErrorAlert(gitError: $commitListViewModel.gitError)
            .decision(
                item: $commitListViewModel.tagCreationCommit,
                title: "create tag title"
            ) { commit in
                commitListViewModel.creeateTag(commit: commit)
            } content: {
                Form {
                    TextField("name", text: $commitListViewModel.tagName)
                        .onChange(of: commitListViewModel.tagName) { newValue in
                            commitListViewModel.tagName = newValue.filter(\.isWhitespace.negated)
                        }
                    Toggle(isOn: $commitListViewModel.hasTagMessage) {
                        Text("create tag with message")
                    }
                    TextField("message", text: $commitListViewModel.tagMessage)
                        .opacity(commitListViewModel.hasTagMessage ? 1.0 : 0.0)
                }
            }

        } else {
            ProgressView()
                .progressViewStyle(.circular)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .gitErrorAlert(gitError: $commitListViewModel.gitError)
        }
    }
}

struct CommitListView_Previews: PreviewProvider {
    static var previews: some View {
        CommitListView(
            commitListViewModel: CommitListViewModel(
                branch: StatusResult.getTestStatus().branch
            )
        )
        .onAppear {
            DoseValues[RepositoryProvider.self] = PreviewRepo()
        }
    }
}

extension Commit: Identifiable {
    public var id: String {
        objectHash
    }
}

extension Bool {
    var negated: Bool { !self }
}
