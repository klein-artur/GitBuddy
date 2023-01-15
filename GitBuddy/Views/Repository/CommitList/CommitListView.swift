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
                    .frame(maxWidth: .infinity)
                    if !commitListViewModel.branch.isCurrent {
                        Button("Checkout") {
                            commitListViewModel.checkoutBranch()
                        }
                    }
                }
                .padding([.trailing, .vertical], 16)
                Divider()
                ScrollView {
                    LazyVStack {
                        ForEach(commitList.indices, id: \.self) { index in
                            CommitItemView(commitInfo: commitList[index])
                                .padding(0)
                                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                        }
                    }
                    .padding([.trailing, .vertical], 16)
                }
            }
        } else {
            ProgressView()
                .progressViewStyle(.circular)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
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
