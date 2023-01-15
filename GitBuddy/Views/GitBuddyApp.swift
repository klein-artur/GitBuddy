//
//  GitBuddyApp.swift
//  GitBuddy
//
//  Created by Artur Hellmann on 29.12.22.
//

import SwiftUI
import GitCaller

@main
struct GitBuddyApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject var mainViewModel: GitBuddyAppMainViewModel = GitBuddyAppMainViewModel(repository: GitRepo.standard)
    
    var body: some Scene {
        WindowGroup {
            VStack {
                if let repoPath = mainViewModel.repoPath {
                    RepoView(viewModel: RepoViewModel(repository: GitRepo.standard, repoPath: repoPath, appDelegate: appDelegate))
                } else {
                    NoPathSelectedView()
                        .frame(width: 500, height: 400)
                }
            }
            .navigationTitle(mainViewModel.repoName ?? "Git Buddy")
            .onAppear {
                self.mainViewModel.repoPathPublisher = appDelegate.$currentRepoDir
            }
        }
        .commands {
            CommandGroup(replacing: .newItem) {
                Button {
                    AppDelegate.shared?.openFile()
                } label: {
                    Text("Open")
                }
                .keyboardShortcut("o", modifiers: .command)
                Button {
                    AppDelegate.shared?.reload()
                } label: {
                    Text("Reload")
                }
                .keyboardShortcut("r", modifiers: .command)
            }
            CommandGroup(replacing: .saveItem) {}
            CommandGroup(replacing: .undoRedo) {}
            CommandGroup(replacing: .textFormatting) {}
        }
    }
}
