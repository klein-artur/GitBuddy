//
//  BaseViewModel.swift
//  GitBuddy
//
//  Created by Artur Hellmann on 30.12.22.
//

import Foundation
import SwiftUI
import Combine

class BaseViewModel: ObservableObject {
    var lifetimeCancellables: [AnyCancellable] = []
}
