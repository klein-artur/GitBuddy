//
//  CommandInputViewModel.swift
//  GitBuddy
//
//  Created by Artur Hellmann on 21.01.23.
//

import Foundation
import GitCaller

@MainActor
class CommandInputViewModel: BaseViewModel {
    @Published var commandInput: String = ""
    @Published var commandOutput: String = ""
    
    func run() {
        setLoading()
        Git(raw: commandInput).run()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] completion in
                if self?.commandOutput.isEmpty == true {
                    self?.commandOutput = "done"
                }
                self?.repository.needsUpdate()
            }, receiveValue: { [weak self] output in
                self?.commandOutput = output
            })
            .store(in: &self.lifetimeCancellables)
    }
}
