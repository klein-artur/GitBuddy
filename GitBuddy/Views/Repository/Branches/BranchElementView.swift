//
//  BranchElementView.swift
//  GitBuddy
//
//  Created by Artur Hellmann on 15.01.23.
//

import SwiftUI
import GitCaller

struct BranchElementView: View {
    
    let branch: Branch
    let showLogButton: Bool
    let status: StatusResult?
    
    @State var showLogBranch: Branch?
    
    var body: some View {
        currentBranchView
            .commitSheet(for: $showLogBranch)
    }
    
    @ViewBuilder
    private var currentBranchView: some View {
        HStack(alignment: .center) {
            HStack(alignment: .top) {
                Image("code-branch-solid")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 20)
                    .padding(.top, 7)
                VStack(alignment: .leading) {
                    Text(branch.name)
                        .font(.title)
                        .lineLimit(1)
                    if let upstream = branch.upstream {
                        Text(upstream.name)
                            .font(.caption)
                    }
                }
                OutdatedPillView(branch: branch)
                    .padding(.top, 5)
                if let status = status {
                    localChangesPill(status: status)
                        .padding(.top, 5)
                }
            }
            if showLogButton {
                Spacer()
                Button("Commits".localized) {
                    self.showLogBranch = branch
                }
            }
        }
    }
    
    @ViewBuilder
    private func localChangesPill(status: StatusResult) -> some View {
        if status.numberOfChanges > 0 {
            VStack {
                Text("local changes".localized.formatted(status.numberOfChanges))
                    .font(.caption)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 6)
            }
            .background(Color(NSColor.systemOrange), in: RoundedRectangle(cornerRadius: 15))
        }
    }
}

struct BranchElementView_Previews: PreviewProvider {
    static var previews: some View {
        BranchElementView(
            branch: StatusResult.getTestStatus().branch,
            showLogButton: true,
            status: StatusResult.getTestStatus()
        )
    }
}
