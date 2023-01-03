//
//  Loading.swift
//  GitBuddy
//
//  Created by Artur Hellmann on 03.01.23.
//

import SwiftUI

struct LoadingModifier: ViewModifier {
    @Binding var loadingCount: Int
    
    func body(content: Content) -> some View {
        content
            .overlay {
                if loadingCount > 0 {
                    VStack(alignment: .center) {
                        HStack(alignment: .center) {
                            ProgressView()
                                .padding(32)
                        }
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8))
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                    .allowsHitTesting(true)
                }
            }
    }
}

extension View {
    func loading(loadingCount: Binding<Int>) -> some View {
        modifier(LoadingModifier(loadingCount: loadingCount))
    }
}
