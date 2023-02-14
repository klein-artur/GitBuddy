//
//  BranchElementView.swift
//  Jagu
//
//  Created by Artur Hellmann on 15.01.23.
//

import SwiftUI
import GitCaller
import SwiftDose

struct BranchElementView: View {
    
    @ObservedObject var viewModel: BranchElementViewModel
    
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
                    Text(viewModel.branch.name)
                        .font(.title)
                        .lineLimit(1)
                    if let upstream = viewModel.branch.upstream {
                        Text(upstream.name)
                            .font(.caption)
                    }
                }
            }
            OutdatedPillView(branch: viewModel.branch)
            if let status = viewModel.status {
                localChangesPill(status: status)
            }
            Spacer()
            
            if let shouldForce = viewModel.branch.shouldForcePull {
                Button(shouldForce ? "Force Pull" : "Pull") {
                    viewModel.pull(force: shouldForce)
                }
            }
            if let shouldForce = viewModel.branch.shouldForcePush {
                Button(shouldForce ? "Force Push" : "Push") {
                    viewModel.push(force: shouldForce)
                }
            }
            if viewModel.showLogButton {
                Button("Commits".localized) {
                    self.showLogBranch = viewModel.branch
                }
            }
        }
        .generalAlert(item: $viewModel.alertItem)
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
            viewModel: BranchElementViewModel(
                branch: StatusResult.getTestStatus().branch,
                status: StatusResult.getTestStatus(),
                showLogButton: true
            )
        )
        .onAppear {
            DoseValues[RepositoryProvider.self] = PreviewRepo()
        }
    }
}
