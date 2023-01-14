//
//  GeneralAlert.swift
//  GitBuddy
//
//  Created by Artur Hellmann on 10.01.23.
//

import SwiftUI

struct AlertAction {
    let title: String
    var role: ButtonRole? = .none
    let action: (() -> Void)
}

struct AlertItem {
    let title: String
    let message: String
    let actions: [AlertAction]
}

struct GeneralAlert: ViewModifier {
    @Binding var alertItem: AlertItem?
    
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
                        Button(role: action.role) {
                            action.action()
                        } label: {
                            Text(action.title.localized)
                        }
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
