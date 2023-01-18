//
//  Status+Presentation.swift
//  GitBuddy
//
//  Created by Artur Hellmann on 18.01.23.
//

import Foundation
import GitCaller

extension Branch {
    var shouldForcePush: Bool? {
        if self.isCurrent && self.ahead > 0 {
            return self.behind > 0
        }
        return nil
    }
    
    var shouldForcePull: Bool? {
        if self.isCurrent && self.behind > 0 {
            return self.ahead > 0 ? nil : false
        }
        return nil
    }
}
