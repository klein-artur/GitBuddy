//
//  ParsingExtensions.swift
//  GitBuddy
//
//  Created by Artur Hellmann on 03.01.23.
//

import Foundation
import GitCaller
import GitParser

extension CommandStatus: Parsable {
    
    public typealias Success = GitStatus
    
    public var parser: StatusParser {
        return StatusParser()
    }
}

extension CommandClone: Parsable {
    
    public typealias Success = CloneResult
    
    public var parser: CloneResultParser {
        return CloneResultParser()
    }
}
