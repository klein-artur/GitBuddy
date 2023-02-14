//
//  ContentView.swift
//  Jagu
//
//  Created by Artur Hellmann on 29.12.22.
//

import SwiftUI
import Combine
import GitCaller
import SwiftDose

struct RepoView: View {
    @StateObject var viewModel: RepoViewModel
    
    @State var showCloneAlert = false
    @State var tabSelection = "loalChanges"
    
    var body: some View {
        VStack {
            if viewModel.notAGitRepo {
                notARepoView
            } else if let status = viewModel.gitStatus {
                isARepoView(status: status)
                    .frame(minWidth: 600, maxWidth: .infinity, minHeight: 450, maxHeight: .infinity)
            }
        }
        .frame(minWidth: 600, maxWidth: .infinity, minHeight: 450, maxHeight: .infinity)
        .alert("clone repo alert title", isPresented: $showCloneAlert, actions: {
            TextField("clone url placeholder", text: $viewModel.cloneRepoUrl)
                .frame(width: 800)
            Button("ok") {
                viewModel.cloneRepository()
            }
            Button("cancel") {
                showCloneAlert = false
            }
        })
        .gitErrorAlert(gitError: $viewModel.gitError)
        .padding()
    }
    
    @ViewBuilder
    private var notARepoView: some View {
        Text("not a repo info")
        Button("create Repo") {
            viewModel.createRepo()
        }
        Button("clone repo") {
            showCloneAlert = true
        }
    }
    
    @ViewBuilder
    private func isARepoView(status: StatusResult) -> some View {
        VStack(alignment: .leading) {
            BranchElementView(
                viewModel: BranchElementViewModel(
                    branch: status.branch,
                    status: status,
                    showLogButton: true
                )
            )
            Divider()
            TabView(selection: $tabSelection) {
                branchListView
                    .tabItem {
                        Text("Branches")
                    }
                    .tag("branches")
                if let status = viewModel.gitStatus, status.status != .clean || status.isMerging {
                    LocalChangesView(
                        viewModel: LocalChangesViewModel(
                            status: status
                        )
                    )
                        .tag("loalChanges")
                }
            }
        }
        .commitSheet(for: $viewModel.gitLogBranch)
    }
    
    @ViewBuilder
    private var branchListView: some View {
        BranchListView(
            viewModel: BranchListViewModel(
                keyValueRepo: LocalKeyValueRepository()
            )
        )
    }
    
}

extension StatusResult {
    var numberOfChanges: Int {
        stagedChanges.count + unstagedChanges.count + untrackedChanges.count + unmergedChanges.count
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RepoView(
                viewModel: RepoViewModel(
                    repoPath: "",
                    appDelegate: AppDelegate()
                )
            )
            .onAppear {
                DoseValues[RepositoryProvider.self] = PreviewRepo()
            }
            .previewDisplayName("No Repo")
            
            RepoView(
                viewModel: RepoViewModel(
                    repoPath: "",
                    appDelegate: AppDelegate(),
                    gitStatus: StatusResult.getTestStatus()
                )
            )
            .onAppear {
                DoseValues[RepositoryProvider.self] = PreviewRepo()
            }
            .previewDisplayName("Default State")
        }
    }
}
	
