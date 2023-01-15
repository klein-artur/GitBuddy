//
//  CommitListView.swift
//  GitBuddy
//
//  Created by Artur Hellmann on 05.01.23.
//

import SwiftUI
import GitCaller

struct CommitListView: View {
    @ObservedObject var commitListViewModel: CommitListViewModel
    
    var body: some View {
        if let commitList = commitListViewModel.commitList {
            VStack {
                HStack {
                    BranchElementView(
                        branch: commitListViewModel.branch,
                        showLogButton: false,
                        status: nil
                    )
                    Spacer()
                    if !commitListViewModel.branch.isCurrent {
                        Button("Checkout") {
                            commitListViewModel.checkoutBranch()
                        }
                    }
                }
                .padding([.horizontal, .top], 16)
                Divider()
                    .padding(.horizontal, 16)
                ScrollView {
                    LazyVStack {
                        ForEach(commitList.indices, id: \.self) { index in
                            CommitItemView(commitInfo: commitList[index])
                                .padding(0)
                                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                        }
                    }
                    .padding(16)
                }
            }
            .gitErrorAlert(gitError: $commitListViewModel.gitError)
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
                repository: PreviewRepo(),
                branch: StatusResult.getTestStatus().branch
            )
        )
    }
}
