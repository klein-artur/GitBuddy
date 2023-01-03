//
//  BaseViewModel.swift
//  GitBuddy
//
//  Created by Artur Hellmann on 30.12.22.
//

import Foundation
import SwiftUI
import Combine
import GitCaller
import GitParser

class BaseViewModel: ObservableObject {
    @Published var notARepo: Bool = false
    
    @Published var gitError: String = ""
    
    @Published var loadingCount: Int = 0
    
    var isLoading: Bool {
        loadingCount > 0
    }
    
    var lifetimeCancellables: [AnyCancellable] = []
    
    func setLoading() {
        loadingCount += 1
    }
    
    func stopLoading() {
        loadingCount -= 1
        if loadingCount < 0 {
            loadingCount = 0
        }
    }
    
    func handleError(_ error: Error) {
        if let parseError = error as? ParseError {
            switch parseError {
            case .notARepository:
                notARepo = true
            default: break
            }
        }
    }
}
