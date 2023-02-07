//
//  CommandInputView.swift
//  Jagu
//
//  Created by Artur Hellmann on 21.01.23.
//

import SwiftUI

struct CommandInputView: View {
    @StateObject var viewModel: CommandInputViewModel
    
    @FocusState var focus: String?
    
    var body: some View {
        VStack {
            HStack {
                Form {
                    TextField("git", text: $viewModel.commandInput)
                        .focused($focus, equals: "field")
                        .disabled(viewModel.loadingCount > 0)
                        .popover(item: $viewModel.autocompletionList, arrowEdge: .bottom) { list in
                            ScrollView {
                                LazyVStack(alignment: .leading) {
                                    ForEach(list) { element in
                                        VStack(alignment: .leading) {
                                            Text(element)
                                                .padding(2)
                                            Divider()
                                        }
                                        .frame(maxWidth: .infinity)
                                        .onTapGesture {
                                            viewModel.autocompletionSelected(value: element)
                                        }
                                    }
                                }
                            }
                            .padding()
                            .frame(minWidth: 300, minHeight: 200, alignment: .topLeading)
                        }
                }
                .defaultFocus($focus, "field")
                Button("Run") {
                    viewModel.run()
                }
                    .disabled(viewModel.loadingCount > 0)
                    .keyboardShortcut(.defaultAction)
            }
            GroupBox {
                ScrollView {
                    Text(viewModel.commandOutput)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        .textSelection(.enabled)
                }
            }
        }
        .padding()
        .onAppear {
            viewModel.load()
        }
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

extension Array: Identifiable where Element == String {
    public var id: String {
        self.joined()
    }
}
