//
//  GeneralAlert.swift
//  Jagu
//
//  Created by Artur Hellmann on 10.01.23.
//

import SwiftUI

protocol AlertAction {
    var title: String { get }
}

struct AlertButton: AlertAction {
    let title: String
    var role: ButtonRole? = .none
    let action: (() -> Void)
}

struct AlertTextField: AlertAction, Hashable {
    static func == (lhs: AlertTextField, rhs: AlertTextField) -> Bool {
        lhs.title == rhs.title
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
    
    let title: String
    var text: Binding<String>
}

struct AlertItem {
    let title: String
    let message: String
    let actions: [any AlertAction]
}

struct GeneralAlert: ViewModifier {
    @Binding var alertItem: AlertItem?
    
    @FocusState private var firstFieldResponder: AlertTextField?
    
    func body(content: Content) -> some View {
        content
            .alert(
                alertItem?.title.localized ?? "",
                isPresented: Binding(
                    get: {
                        alertItem != nil
                    }, set: {
                        if !$0 {
                            alertItem = nil
                        }
                    }),
                presenting: alertItem) { item in
                    ForEach(item.actions, id: \.title) { action in
                        if let action = action as? AlertButton {
                            Button(role: action.role) {
                                action.action()
                            } label: {
                                Text(action.title.localized)
                            }
                        } else if let action = action as? AlertTextField {
                            TextField(action.title.localized, text: action.text)
                                .focused($firstFieldResponder, equals: action)
                                .disableAutocorrection(true)
                        }
                    }
                    .onAppear {
                        firstFieldResponder = alertItem?.actions.first(where: { $0 is AlertTextField }) as? AlertTextField
                    }
                } message: { item in
                    Text(item.message.localized)
                }
    }
}

extension View {
    func generalAlert(item: Binding<AlertItem?>) -> some View {
        modifier(GeneralAlert(alertItem: item))
    }
}
