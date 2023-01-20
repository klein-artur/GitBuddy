//
//  LocalChangesView.swift
//  GitBuddy
//
//  Created by Artur Hellmann on 14.01.23.
//

import SwiftUI
import GitCaller

struct LocalChangesView: View {
    @StateObject var viewModel: LocalChangesViewModel
    
    var body: some View {
        VStack {
            ScrollView {
                if let status = viewModel.status {
                    VStack {
                        group(for: status.combinedUnstagedChanges, staged: false)
                        group(for: status.stagedChanges, staged: true)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                }
            }
            if let status = viewModel.status, !status.stagedChanges.isEmpty {
                HStack{
                    TextEditor(text: $viewModel.commitMessage)
                        .frame(height: 50)
                    Button("commit") {
                        viewModel.commit()
                    }
                }
            }
        }
        .onAppear {
            viewModel.load()
        }
        .gitErrorAlert(gitError: $viewModel.gitError)
        .generalAlert(item: $viewModel.alertItem)
    }
    
    @ViewBuilder
    private func group(for changeList: [Change], staged: Bool) -> some View {
        let changes = changeList.sorted { left, right in
            left.path < right.path
        }
        if !changes.isEmpty {
            GroupBox(staged ? "staged changes" : "unstaged changes") {
                LazyVStack (alignment: .leading) {
                    ForEach(changeList, id: \.path) { change in
                        LocalChangeItem(viewModel: viewModel, change: change, staged: staged)
                    }
                }
            }
        }
    }
}

struct LocalChangeItem: View {
    let viewModel: LocalChangesViewModel
    let change: Change
    let staged: Bool
    @State var showButton: Bool = false
    
    @State var localChangesFilePath: String?
    
    var body: some View {
        HStack {
            Text(change.kind.infoString)
                .foregroundColor(change.kind.infoColor)
            VStack(alignment: .leading) {
                Text(change.path.lastPathComponent ?? "")
                    .lineLimit(1)
                    .fontWeight(.bold)
                Text(change.path.replacingOccurrences(of: "/\(change.path.lastPathComponent ?? "")", with: ""))
                    .lineLimit(1)
                    .font(.caption)
            }
            if showButton {
                Spacer()
                Button("Details") {
                    localChangesFilePath = change.path
                }
                if change.state != .staged && change.kind != .newFile && change.kind != .bothAdded {
                    Button("revert") {
                        viewModel.revert(change: change)
                    }
                }
            }
        }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 2)
            .onHover { isHovering in
                showButton = isHovering
            }
            .onTapGesture(count: 2) {
                if staged {
                    viewModel.unstage(change: change)
                } else {
                    viewModel.stage(change: change)
                }
            }
            .sheet(item: $localChangesFilePath) { path in
                DiffView(viewModel: DiffViewModel(repository: viewModel.repository, leftFile: path, staged: staged))
            }
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
