//
//  Loading.swift
//  Jagu
//
//  Created by Artur Hellmann on 03.01.23.
//

import SwiftUI

struct LoadingModifier: ViewModifier {
    @Binding var isLoading: Bool
    
    func body(content: Content) -> some View {
        content
            .overlay {
                if isLoading {
                    VStack(alignment: .center) {
                        HStack(alignment: .center) {
                            ProgressView()
                                .padding(32)
                        }
                        .background(.thickMaterial, in: RoundedRectangle(cornerRadius: 8))
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                    .allowsHitTesting(true)
                    .contentShape(Rectangle())
                    .background(.ultraThinMaterial)
                }
            }
    }
}

extension View {
    func loading(isLoading: Binding<Bool>) -> some View {
        modifier(LoadingModifier(isLoading: isLoading))
    }
}
