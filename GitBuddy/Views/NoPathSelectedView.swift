//
//  NoGitRepoView.swift
//  GitBuddy
//
//  Created by Artur Hellmann on 30.12.22.
//

import SwiftUI

struct NoPathSelectedView: View {
    var body: some View {
        Text("path not selected info")
    }
}

struct NoGitRepoView_Previews: PreviewProvider {
    static var previews: some View {
        NoPathSelectedView()
    }
}
