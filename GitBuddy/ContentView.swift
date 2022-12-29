//
//  ContentView.swift
//  GitBuddy
//
//  Created by Artur Hellmann on 29.12.22.
//

import SwiftUI
import GitCaller

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Test") {
                print(Git().status.run())
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
