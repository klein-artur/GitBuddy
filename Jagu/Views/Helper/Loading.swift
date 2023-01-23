//
//  Loading.swift
//  Jagu
//
//  Created by Artur Hellmann on 03.01.23.
//

import SwiftUI

struct LoadingModifier: ViewModifier {
    @Binding var loadingCount: Int
    
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: Binding(get: {
                loadingCount > 0
            }, set: { _, _ in
                
            })) {
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

extension View {
    func loading(loadingCount: Binding<Int>) -> some View {
        modifier(LoadingModifier(loadingCount: loadingCount))
    }
}
