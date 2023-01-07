//
//  GitService.swift
//  GitBuddy
//
//  Created by Artur Hellmann on 07.01.23.
//

import Foundation
import GitParser
import GitCaller

class GitService {
    
    func getGitLog(branch name: String) async throws -> LogResult {
        try await Git().log.branchName(name).pretty(.format(LogResultParser.prettyFormat)).finalResult()
    }
    
}
