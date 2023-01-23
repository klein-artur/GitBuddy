//
//  LocalChangesView.swift
//  Jagu
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
                        if viewModel.status?.status == .merging {
                            HStack {
                                Text("in middle of merge")
                                if viewModel.canContinue {
                                    Text("No Mergeissues")
                                }
                                Spacer()
                                Button {
                                    viewModel.abort()
                                } label: {
                                    Text("abort merge")
                                }
                            }
                        }
                        group(for: viewModel.unstagedChanges, staged: false)
                        group(for: viewModel.stagedChanges, staged: true)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                }
            }
            if let status = viewModel.status, !status.stagedChanges.isEmpty || status.canContinue {
                HStack{
                    TextEditor(text: $viewModel.commitMessage)
                        .frame(height: 50)
                    Button {
                        viewModel.commit()
                    } label: {
                        Text(status.status == .merging ? "continue" : "commit")
                    }
                }
                .padding()
            }
        }
        .onAppear {
            viewModel.load()
        }
        .gitErrorAlert(gitError: $viewModel.gitError)
        .generalAlert(item: $viewModel.alertItem)
        .tabItem {
            Text(viewModel.status?.status == .unclean ? "Local Changes" : "Merging")
        }
        .loading(loadingCount: $viewModel.loadingCount)
    }
    
    @ViewBuilder
    private func group(for changeList: [ChangeLine], staged: Bool) -> some View {
        let changes = changeList.sorted { left, right in
            left.leftItem.change.path < right.leftItem.change.path
        }
        if !changes.isEmpty {
            GroupBox(staged ? "staged changes" : "unstaged changes") {
                LazyVStack (alignment: .leading) {
                    ForEach(changeList, id: \.leftItem.change.path) { change in
                        LocalChangeItem(viewModel: viewModel, change: change, staged: staged)
                    }
                }
            }
        }
    }
}

struct LocalChangeItem: View {
    let viewModel: LocalChangesViewModel
    let change: ChangeLine
    let staged: Bool
    @State var showButton: Bool = false
    
    @State var localChangesFilePath: String?
    
    var body: some View {
        HStack {
            itemView(for: change.leftItem, isLeft: true, change: change)
                .frame(maxWidth: .infinity, alignment: .leading)
            if let rightItem = change.rightItem {
                itemView(for: rightItem, isLeft: false, change: change)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 8)
            }
            if showButton && change.rightItem == nil {
                if change.leftItem.change.kind.canShowDetails {
                    Spacer()
                    Button("Details") {
                        localChangesFilePath = change.leftItem.change.path
                    }
                }
                if change.leftItem.change.state != .staged && change.leftItem.changeKind != .newFile && change.leftItem.changeKind != .bothAdded {
                    if change.leftItem.changeKind == .modified {
                        if !change.leftItem.change.kind.canShowDetails {
                            Spacer()
                        }
                        Button("revert") {
                            viewModel.revert(change: change.leftItem.change)
                        }
                    }
                }
            }
        }
            .padding(.vertical, 2)
            .contentShape(Rectangle())  
            .onTapGesture(count: 2) {
                viewModel.doubleClicked(change: change, staged: staged)
            }
            .onHover { isHovering in
                showButton = isHovering
            }
            .contextMenu {
                if (change.leftItem.changeKind.conflict) {
                    Button("mark as solved") {
                        viewModel.stage(change: change.leftItem.change)
                    }
                }
                if (change.leftItem.changeKind.deletable) {
                    Button("delete file") {
                        viewModel.delete(change: change.leftItem.change)
                    }
                }
            }
            .popover(item: $localChangesFilePath) { path in
                DiffView(viewModel: DiffViewModel(repository: viewModel.repository, leftFile: path, staged: staged))
            }
    }
    
    @ViewBuilder
    func itemView(for item: ChangeItem, isLeft: Bool, change: ChangeLine) -> some View {
        HStack {
            Text(item.changeKind.infoString)
                .font(Font.system(size: 12).monospaced())
                .foregroundColor(item.changeKind.infoColor)
            VStack(alignment: .leading) {
                Text(item.change.path.lastPathComponent ?? "")
                    .lineLimit(1)
                    .fontWeight(.bold)
                Text(item.change.path.replacingOccurrences(of: "/\(item.change.path.lastPathComponent ?? "")", with: ""))
                    .lineLimit(1)
                    .font(.caption)
            }
            if item.change.kind.leftRight {
                Spacer()
                
                Button("select") {
                    Task {
                        await MainActor.run(body: {
                            self.viewModel.use(item: item, in: change, left: isLeft)
                        })
                    }
                    
                }
                if isLeft {
                    if item.change.kind.mergable {
                        Button("merge") {
                            Task {
                                await MainActor.run(body: {
                                    viewModel.startMerging(change: item.change)
                                })
                            }
                        }
                    }
                }
            }
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
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
