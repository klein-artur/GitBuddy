//
//  LoadingIndicatorService.swift
//  Jagu
//
//  Created by Artur Hellmann on 14.02.23.
//

import Foundation
import Combine

class LoadingIndicatorService {
    @Published var isLoading: Bool = false
    
    var loadingCount: Int = 0
    
    func setLoading() {
        loadingCount += 1
        updateLoading()
    }
    
    func stopLoading() {
        loadingCount -= 1
        if loadingCount < 0 {
            loadingCount = 0
        }
        updateLoading()
    }
    
    private func updateLoading() {
        isLoading = loadingCount > 0
    }
}
