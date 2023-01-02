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
    
    var body: some View {
        VStack {
            if viewModel.notAGitRepo {
                notARepoView
            } else if let status = viewModel.gitStatus {
                Text("Repo is on branch: \(status.branch.name)")
                Text("upstream is: \(status.branch.upstream?.name ?? "NO")")
            }
        }
        .padding()
    }
    
    @ViewBuilder
    private var notARepoView: some View {
        Text("not a repo info")
        Button("create Repo") {
            viewModel.createRepo()
        }
        Button("clone repo") {
            // viewModel.cloneRepo()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RepoView(viewModel: RepoViewModel(repoPath: ""))
    }
}
