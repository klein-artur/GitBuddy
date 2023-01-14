//
//  ConditionalModifier.swift
//  GitBuddy
//
//  Created by Artur Hellmann on 09.01.23.
//

import SwiftUI

extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    ///   - else: The transform to apply if the else case happens.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func ifElse<Content: View>(_ condition: Bool, transform: (Self) -> Content, else elseTransform: ((Self) -> Content)) -> some View {
        if condition {
            transform(self)
        } else {
            elseTransform(self)
        }
    }
}
