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
    
    var currentTexts: [String] {
        Array(loadingIndicators.values).filter { !$0.isEmpty }
    }
    
    var timerCancellable: Cancellable? = nil
    
    var loadingIndicators: [UUID: String] = [:]
    
    func setLoading(text: String) -> UUID {
        if loadingIndicators.isEmpty {
            timerCancellable = Timer.publish(every: 0.5, on: .main, in: .default)
                .autoconnect()
                .first()
                .sink(receiveValue: { tick in
                    self.updateLoading()
                })
        }
        let newUUID = UUID()
        loadingIndicators[newUUID] = text
        return newUUID
    }
    
    func stopLoading(uuid: UUID) {
        loadingIndicators.removeValue(forKey: uuid)
        updateLoading()
        if loadingIndicators.isEmpty {
            timerCancellable?.cancel()
            timerCancellable = nil
        }
    }
    
    private func updateLoading() {
        isLoading = !loadingIndicators.isEmpty
    }
}
