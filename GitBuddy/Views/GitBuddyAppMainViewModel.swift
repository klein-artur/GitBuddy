//
//  GitBuddyAppMainViewModel.swift
//  GitBuddy
//
//  Created by Artur Hellmann on 30.12.22.
//

import Foundation
import SwiftUI
import Combine

class GitBuddyAppMainViewModel: BaseViewModel {
    
    var repoPathPublisher: (any Publisher<String?, Never>)? {
        didSet {
            guard let repoPathPublisher = repoPathPublisher else { return }
            repoPathPublisher
                .sink { [weak self] in
                    self?.repoName = $0?.lastPathComponent
                    self?.repoPath = $0
                }
                .store(in: &self.lifetimeCancellables)
        }
    }
    
    @Published var repoName: String?
    @Published var repoPath: String?
    
    
}
