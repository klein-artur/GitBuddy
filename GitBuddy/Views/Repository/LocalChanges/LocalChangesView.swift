//
//  LocalChangesView.swift
//  GitBuddy
//
//  Created by Artur Hellmann on 14.01.23.
//

import SwiftUI
import GitCaller

struct LocalChangesView: View {
    @ObservedObject var viewModel: LocalChangesViewModel
    
    var body: some View {
        Text("Test")
    }
}

struct LocalChangesView_Previews: PreviewProvider {
    static var previews: some View {
        LocalChangesView(
            viewModel: LocalChangesViewModel(
                repository: PreviewRepo(),
                status: StatusResult.getTestStatus()
            )
        )
    }
}
