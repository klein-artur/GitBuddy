//
//  HandleDecissionView.swift
//  Jagu
//
//  Created by Artur Hellmann on 23.01.23.
//

import SwiftUI

struct HandleDecissionView<Content, T>: View where Content: View, T: Identifiable {
    @Environment(\.dismiss) private var dismiss
    var item: T?
    let title: String
    let message: String?
    let action: () -> Void
    let itemAction: (T) -> Void
    let content: Content
    
    
    init(
        title: String,
        message: String?,
        item: T?,
        action: @escaping () -> Void,
        itemAction: @escaping (T) -> Void,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title.localized
        self.message = message?.localized
        self.action = action
        self.item = item
        self.itemAction = itemAction
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.title)
            if let message = message {
                Text(message)
            }
            content
            HStack {
                Spacer()
                Button("cancel") {
                    dismiss()
                }
                Button("ok") {
                    if let item = item {
                        itemAction(item)
                    } else {
                        action()
                    }
                    dismiss()
                }
                .keyboardShortcut(.defaultAction)
            }
        }
        .padding()
        .frame(minWidth: 300)
    }
}

struct HandleDecissionView_Previews: PreviewProvider {
    static var previews: some View {
        HandleDecissionView(
            title: "Some Title",
            message: "Some Message",
            item: "",
            action: { },
            itemAction: { _ in }
        ) {
            Text("some test")
        }
    }
}

extension View {
    func decision<Content: View>(
        showDecision: Binding<Bool>,
        title: String,
        message: String? = nil,
        action: @escaping () -> Void,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        self.sheet(isPresented: showDecision) {
            HandleDecissionView<Content, String>(
                title: title,
                message: message,
                item: nil,
                action: action,
                itemAction: { _ in },
                content: content)
        }
    }
    
    func decision<Content, T>(
        item: Binding<T?>,
        title: String,
        message: String? = nil,
        action: @escaping (T) -> Void,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View where Content: View, T: Identifiable {
        self.sheet(item: item) { item in
            HandleDecissionView<Content, T>(
                title: title,
                message: message,
                item: item,
                action: { },
                itemAction: action,
                content: content)
        }
    }
}
