//
//  ContentView.swift
//  GitBuddy
//
//  Created by Artur Hellmann on 29.12.22.
//

import SwiftUI
import Combine

struct RepoView: View {
    @ObservedObject var viewModel: RepoViewModel
    
    @State var showCloneAlert = false
    
    var body: some View {
        VStack {
            if viewModel.notAGitRepo {
                notARepoView
            } else if let status = viewModel.gitStatus {
                Text("Repo is on branch: \(status.branch.name)")
                Text("upstream is: \(status.branch.upstream?.name ?? "NO")")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RepoView(viewModel: RepoViewModel(repoPath: "", appDelegate: AppDelegate()))
    }
}
