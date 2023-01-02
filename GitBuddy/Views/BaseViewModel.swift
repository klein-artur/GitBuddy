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

class BaseViewModel: ObservableObject {
    @Published var notARepo: Bool = false
    
    var lifetimeCancellables: [AnyCancellable] = []
    
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
