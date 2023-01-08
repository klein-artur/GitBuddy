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
            currentBranchView(status: status)
            Divider()
            TabView {
                branchListView
                    .tabItem {
                        Text("Branches")
                    }
                commitListViewCurrentRepo
                    .tabItem {
                        Text("Commits")
                    }
            }
        }
    }
    
    @ViewBuilder
    private var commitListViewCurrentRepo: some View {
        if let log = viewModel.gitLog {
            CommitListView(commitListViewModel: CommitListViewModel(gitLog: log))
        } else {
            ProgressView()
                .progressViewStyle(.circular)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    @ViewBuilder
    private var branchListView: some View {
        if let branchResult = viewModel.branchResult {
            BranchListView(
                viewModel: BranchListViewModel(
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
    
    @ViewBuilder
    private func currentBranchView(status: StatusResult) -> some View {
        HStack(alignment: .top) {
            Image("code-branch-solid")
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(height: 20)
                .padding(.top, 7)
            VStack(alignment: .leading) {
                Text(status.branch.name)
                    .font(.title)
                    .lineLimit(1)
                if let upstream = status.branch.upstream {
                    Text(upstream.name)
                        .font(.caption)
                }
            }
            OutdatedPillView(branch: status.branch)
                .padding(.top, 5)
            localChangesPill(status: status)
                .padding(.top, 5)
        }
    }
    
    @ViewBuilder
    private func localChangesPill(status: StatusResult) -> some View {
        if status.numberOfChanges > 0 {
            VStack {
                Text("local changes".localized.formatted(status.numberOfChanges))
                    .font(.caption)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 6)
            }
            .background(Color(NSColor.systemOrange), in: RoundedRectangle(cornerRadius: 15))
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
                    repoPath: "",
                    appDelegate: AppDelegate()
                )
            )
            .previewDisplayName("No Repo")
            
            RepoView(
                viewModel: RepoViewModel(
                    repoPath: "",
                    appDelegate: AppDelegate(),
                    gitStatus: StatusResult.getTestStatus()
                )
            )
            .previewDisplayName("Default State")
        }
    }
}
	
