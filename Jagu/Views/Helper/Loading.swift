//
//  Loading.swift
//  Jagu
//
//  Created by Artur Hellmann on 03.01.23.
//

import SwiftUI
import SwiftDose

class LoadingViewModel: BaseViewModel { }

struct LoadingModifier: ViewModifier {
    
    @ObservedObject var loadingViewModel = LoadingViewModel()
    
    func body(content: Content) -> some View {
        content.overlay {
            if loadingViewModel.isLoading {
                VStack(alignment: .center) {
                    HStack(alignment: .center) {
                        ProgressView()
                            .padding(32)
                    }
                    .background(.thickMaterial, in: RoundedRectangle(cornerRadius: 8))
                    Text(loadingViewModel.loadingIndicatorService.currentTexts.joined(separator: "\n"))
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
    func showLoadingIndicator() -> some View {
        modifier(LoadingModifier())
    }
}
