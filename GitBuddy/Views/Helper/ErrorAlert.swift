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
            .alert(
                "Failed",
                isPresented: Binding(get: {
                    !gitError.isEmpty
                }, set: { value in
                    if !value {
                        gitError = ""
                    }
                }),
                actions: {}, message: {
                    Text(gitError)
                })
    }
}

extension View {
    func gitErrorAlert(gitError: Binding<String>) -> some View {
        modifier(GitErrorAlert(gitError: gitError))
    }
}
