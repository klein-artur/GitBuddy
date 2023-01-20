//
//  DiffViewModel.swift
//  GitBuddy
//
//  Created by Artur Hellmann on 20.01.23.
//

import Foundation
import GitCaller

@MainActor
class DiffViewModel: BaseViewModel {
    let leftFile: String?
    let rightFile: String?
    let staged: Bool?
    
    @Published var diff: DiffResult? = nil
    
    init(repository: some Repository, leftFile: String?, rightFile: String? = nil, staged: Bool? = nil) {
        self.leftFile = leftFile
        self.rightFile = rightFile
        self.staged = staged
        super.init(repository: repository)
        
    }
    
    override func load() {
        self.defaultTask { [weak self] in
            guard let self = self else {
                return
            }
            self.diff = try await self.repository.diff(path: self.leftFile, staged: self.staged ?? false, rightPath: self.rightFile)
        }
    }
    
    func stage(_ hunkIndex: Int? = nil) {
        defaultTask { [weak self] in
            if let leftFile = self?.leftFile, self?.staged == true {
                _ = try await self?.repository.unstage(file: leftFile, hunk: hunkIndex)
            } else {
                _ = try await self?.repository.stage(file: self?.leftFile, hunk: hunkIndex)
            }
        }
    }
}
