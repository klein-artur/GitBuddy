//
//  ErrorAlert.swift
//  GitBuddy
//
//  Created by Artur Hellmann on 03.01.23.
//

import SwiftUI

struct GitErrorAlert: ViewModifier {
    @Binding var gitError: String
    
    func body(content: Content) -> some View {
        content
            .sheet(
                item: Binding(get: {
                    gitError.isEmpty ? nil : gitError
                }, set: { value in
                    gitError = value ?? ""
                })) { error in
                VStack(alignment: .trailing) {
                    Text(gitError)
                        .lineLimit(nil)
                        .frame(width: 500, height: 400, alignment: .topLeading)
                    Button("Ok") {
                        gitError = ""
                    }.keyboardShortcut(.defaultAction)
                }
                .padding()
            }
//            .alert(
//                "",
//                isPresented: Binding(get: {
//                    !gitError.isEmpty
//                }, set: { value in
//                    if !value {
//                        gitError = ""
//                    }
//                }),
//                actions: {
//                    Button {
//                        AppDelegate.shared?.reload()
//                    } label: {
//                        Text("OK")
//                    }
//                }, message: {
//                    Text(gitError)
//                })
    }
}

extension View {
    func gitErrorAlert(gitError: Binding<String>) -> some View {
        modifier(GitErrorAlert(gitError: gitError))
    }
}

extension String: Identifiable {
    public var id: String {
        self
    }
}
