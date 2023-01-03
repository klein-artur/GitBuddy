//
//  GitBuddyApp.swift
//  GitBuddy
//
//  Created by Artur Hellmann on 29.12.22.
//

import SwiftUI

@main
struct GitBuddyApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject var mainViewModel: GitBuddyAppMainViewModel = GitBuddyAppMainViewModel()
    
    var body: some Scene {
        WindowGroup {
            VStack {
                if let repoPath = mainViewModel.repoPath {
                    RepoView(viewModel: RepoViewModel(repoPath: repoPath, appDelegate: appDelegate))
                        .frame(width: 500, height: 400)
                } else {
                    NoPathSelectedView()
                }
            }
            .frame(width: 500, height: 400)
            .navigationTitle(mainViewModel.repoName ?? "Git Buddy")
            .onAppear {
                self.mainViewModel.repoPathPublisher = appDelegate.$currentRepoDir
            }
        }
        .commands {
            CommandGroup(replacing: .newItem) {
                Button {
                    appDelegate.openFile()
                } label: {
                    Text("Open")
                }
                .keyboardShortcut("o", modifiers: .command)
            }
            CommandGroup(replacing: .saveItem) {}
            CommandGroup(replacing: .undoRedo) {}
            CommandGroup(replacing: .textFormatting) {}
        }
    }
}
