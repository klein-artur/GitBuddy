//
//  RepoViewModel.swift
//  Jagu
//
//  Created by Artur Hellmann on 30.12.22.
//

import Foundation
import GitCaller

@MainActor
class RepoViewModel: BaseViewModel {
    
    let repoPath: String
    let appDelegate: AppDelegate
    
    @Published var gitStatus: StatusResult? = nil
    @Published var notAGitRepo: Bool = false
    
    @Published var cloneRepoUrl = ""
    
    init(repository: some Repository, repoPath: String, appDelegate: AppDelegate, gitStatus: StatusResult? = nil) {
        self.repoPath = repoPath
        self.appDelegate = appDelegate
        super.init(repository: repository)
        if let gitStatus = gitStatus {
            self.gitStatus = gitStatus
        } else {
            self.load()
        }
    }
    
    override func load() {
        Task {
            do {
                self.gitStatus = try await repository.getStatus()
                self.notAGitRepo = false
            } catch {
                guard let error = error as? ParseError else { return }
                switch error.type {
                case .notARepository:
                    self.gitStatus = nil
                    self.notAGitRepo = true
                default: break
                }
            }
        }
    }
    
    func createRepo() {
        Task {
            _ = try! await Git().initialize.runAsync()
            load()
        }
    }
    
    func cloneRepository() {
        setLoading()
        Task {
            let result = try! await repository.clone(url: self.cloneRepoUrl)
            stopLoading()
            if let name = result.outputDir {
                appDelegate.changePath(into: name)
            } else {
                self.gitError = result.originalOutput
            }
        }
    }
    
}
