//
//  CommandInputView.swift
//  GitBuddy
//
//  Created by Artur Hellmann on 21.01.23.
//

import SwiftUI

struct CommandInputView: View {
    @StateObject var viewModel: CommandInputViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("git")
                TextField("Command", text: $viewModel.commandInput)
                    .disabled(viewModel.loadingCount > 0)
                Button("Run") {
                    viewModel.run()
                }
                    .disabled(viewModel.loadingCount > 0)
                    .keyboardShortcut(.defaultAction)
            }
            GroupBox {
                Text(viewModel.commandOutput)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
        }
        .padding()
        .frame(width: 500, height: 400, alignment: .topLeading)
    }
}

struct CommandInputView_Previews: PreviewProvider {
    static var previews: some View {
        CommandInputView(
            viewModel: CommandInputViewModel(repository: PreviewRepo())
        )
    }
}
