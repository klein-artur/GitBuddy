//
//  HandleDecissionView.swift
//  Jagu
//
//  Created by Artur Hellmann on 23.01.23.
//

import SwiftUI

struct HandleDecissionView<Content>: View where Content: View {
    @Environment(\.dismiss) private var dismiss
    let title: String
    let message: String
    let action: () -> Void
    let content: Content
    
    init(
        title: String,
        message: String,
        action: @escaping () -> Void,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.message = message
        self.action = action
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.title)
            Text(message)
            content
            HStack {
                Spacer()
                Button("cancel") {
                    dismiss()
                }
                Button("ok") {
                    action()
                    dismiss()
                }
                .keyboardShortcut(.defaultAction)
            }
        }
        .padding()
    }
}

struct HandleDecissionView_Previews: PreviewProvider {
    static var previews: some View {
        HandleDecissionView(
            title: "Some Title",
            message: "Some Message",
            action: {
            
            }) {
                Text("some test")
            }
    }
}

extension View {
    func decision<Content: View>(
        showDecision: Binding<Bool>,
        title: String,
        message: String,
        action: @escaping () -> Void,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        self.sheet(isPresented: showDecision) {
            HandleDecissionView<Content>(
                title: title,
                message: message,
                action: action,
                content: content)
        }
    }
}
