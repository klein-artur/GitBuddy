//
//  LocalChangesViewModel.swift
//  GitBuddy
//
//  Created by Artur Hellmann on 14.01.23.
//

import SwiftUI
import GitCaller

class LocalChangesViewModel: BaseViewModel {
    let status: StatusResult
    
    init(repository: Repository, status: StatusResult) {
        self.status = status
        super.init(repository: repository)
    }
    
    
}
