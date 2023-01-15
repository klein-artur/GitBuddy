//
//  ContentView.swift
//  GitBuddy
//
//  Created by Artur Hellmann on 29.12.22.
//

import SwiftUI
import Combine
import GitCaller

struct RepoView: View {
    @ObservedObject var viewModel: RepoViewModel
    
    @State var showCloneAlert = false
    @State var tabSelection = "loalChanges"
    
    var body: some View {
        VStack {
            if viewModel.notAGitRepo {
                notARepoView
            } else if let status = viewModel.gitStatus {
                isARepoView(status: status)
                    .frame(minWidth: 500, maxWidth: .infinity, minHeight: 400, maxHeight: .infinity)
            }
        }
        .frame(minWidth: 500, maxWidth: .infinity, minHeight: 400, maxHeight: .infinity)
        .loading(loadingCount: $viewModel.loadingCount)
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
                branch: status.branch,
                showLogButton: true,
                status: status
            )
            Divider()
            TabView(selection: $tabSelection) {
                branchListView
                    .tabItem {
                        Text("Branches")
                    }
                    .tag("branches")
                if let status = viewModel.gitStatus, status.status == .unclean {
                    LocalChangesView(
                        viewModel: LocalChangesViewModel(
                            repository: GitRepo.standard,
                            status: status
                        )
                    )
                        .tabItem {
                            Text("Local Changes")
                        }
                        .tag("loalChanges")
                }
            }
        }
        .commitSheet(for: $viewModel.gitLogBranch)
    }
    
    @ViewBuilder
    private var branchListView: some View {
        if let branchResult = viewModel.branchResult {
            BranchListView(
                viewModel: BranchListViewModel(
                    repository: GitRepo.standard,
                    branchResult: branchResult,
                    keyValueRepo: LocalKeyValueRepository()
                )
            )
        } else {
            ProgressView()
                .progressViewStyle(.circular)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
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
                    repository: GitRepo.standard,
                    repoPath: "",
                    appDelegate: AppDelegate()
                )
            )
            .previewDisplayName("No Repo")
            
            RepoView(
                viewModel: RepoViewModel(
                    repository: GitRepo.standard,
                    repoPath: "",
                    appDelegate: AppDelegate(),
                    gitStatus: StatusResult.getTestStatus()
                )
            )
            .previewDisplayName("Default State")
        }
    }
}
	
