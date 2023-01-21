//
//  ErrorAlert.swift
//  Jagu
//
//  Created by Artur Hellmann on 03.01.23.
//

import SwiftUI

struct GitErrorAlert: ViewModifier {
    @Binding var gitError: String?
    
    func body(content: Content) -> some View {
        content
            .sheet(item: $gitError) { error in
                VStack(alignment: .trailing) {
                    Text(error)
                        .lineLimit(nil)
                        .frame(width: 500, height: 400, alignment: .topLeading)
                    Button("Ok") {
                        gitError = nil
                    }.keyboardShortcut(.defaultAction)
                }
                .padding()
            }
//            .alert(
//                "",
//                isPresented: Binding(get: {
//                    gitError != nil
//                }, set: { value in
//                    if !value {
//                        gitError = nil
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
    func gitErrorAlert(gitError: Binding<String?>) -> some View {
        modifier(GitErrorAlert(gitError: gitError))
    }
}

extension String: Identifiable {
    public var id: String {
        self
    }
}
