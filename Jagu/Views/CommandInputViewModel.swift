//
//  CommandInputViewModel.swift
//  Jagu
//
//  Created by Artur Hellmann on 21.01.23.
//

import Foundation
import GitCaller

@MainActor
class CommandInputViewModel: BaseRepositoryViewModel {
    @Published var commandInput: String = "" {
        didSet {
            updateAutocompletion()
        }
    }
    @Published var commandOutput: String = ""
    
    @Published var autocompletionList: [String]? = nil
    
    @Published var branches: BranchResult?
    
    override func load() {
        defaultTask { [weak self] in
            self?.branches = try await self?.repository.getBranches()
        }
    }
    
    func run() {
        setLoading()
        let pipe = Pipe()
        Git.raw(self.commandInput).run(inputPipe: pipe)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] completion in
                print("command input: Done!")
                if self?.commandOutput.isEmpty == true {
                    self?.commandOutput = "done"
                }
                self?.repository.needsUpdate()
            }, receiveValue: { [weak self] output in
                print("command input: Update!")
                self?.commandOutput = output
            })
            .store(in: &self.lifetimeCancellables)
    }
    
    private func updateAutocompletion() {
        guard loadingCount <= 0 else {
            autocompletionList = nil
            return
        }
        guard commandInput.words.count > 1 else {
            autocompletionList = nil
            return
        }
        
        guard let branches = branches?.branches else {
            autocompletionList = nil
            return
        }
        
        let searchString = commandInput.words[commandInput.words.endIndex - 1]
        
        let results = branches
            .filter({ branch in
                branch.name.hasPrefix(searchString)
                && branch.name != searchString
            })
            .map({ branch in
                branch.name
            })
        
        guard !results.isEmpty else {
            autocompletionList = nil
            return
        }
        
        autocompletionList = results
    }
    
    func autocompletionSelected(value: String) {
        self.autocompletionList = nil
        var words = self.commandInput.words
        words[words.endIndex - 1] = value
        self.commandInput = words.joined(separator: " ")
    }
}
