//
//  ContentView.swift
//  Jagu
//
//  Created by Artur Hellmann on 29.12.22.
//

import SwiftUI
import Combine
import GitCaller

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
                viewModel: BranchElementViewModel(
                    repository: GitRepo.standard,
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
                            repository: GitRepo.standard,
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
                repository: GitRepo.standard,
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
	
