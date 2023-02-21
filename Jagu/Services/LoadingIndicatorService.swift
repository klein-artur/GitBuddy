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
        print("loading: set loading")
        if loadingIndicators.isEmpty {
            timerCancellable = Timer.publish(every: 1, on: .main, in: .default)
                .autoconnect()
                .first()
                .sink(receiveValue: { tick in
                    self.updateLoading(to: true)
                })
        }
        let newUUID = UUID()
        loadingIndicators[newUUID] = text
        return newUUID
    }
    
    func stopLoading(uuid: UUID) {
        print("loading: stop loading")
        loadingIndicators.removeValue(forKey: uuid)
        updateLoading(to: false)
        if loadingIndicators.isEmpty {
            print("loading: cancelling timer")
            timerCancellable?.cancel()
            timerCancellable = nil
        }
    }
    
    private func updateLoading(to loading: Bool) {
        let newValue = !loadingIndicators.isEmpty
        
        if isLoading != newValue && newValue == loading {
            print("loading: will update loading to \(newValue)")
            isLoading = newValue
        }
    }
}
