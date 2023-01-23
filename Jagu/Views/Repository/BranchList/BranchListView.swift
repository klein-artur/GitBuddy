//
//  BranchListView.swift
//  Jagu
//
//  Created by Artur Hellmann on 08.01.23.
//

import SwiftUI
import GitCaller

struct BranchListView: View {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var viewModel: BranchListViewModel
    
    @State var selected: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Search", text: $viewModel.searchString)
                .showClearButton($viewModel.searchString)
                .padding(.horizontal, 16)
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 0) {
                    ForEach(viewModel.branchTree) { item in
                        VStack {
                            listItem(item: item)
                            Divider()
                        }
                        .if(selected == item.fullPath) { view in
                            view.background(Color(nsColor: NSColor.black.withAlphaComponent(0.2)))
                        }
                        .onTapGesture(count: 2) {
                            switch item.type {
                            case let .branch(branch):
                                viewModel.checkoutBranch(for: branch)
                            case .directory(_):
                                viewModel.changeOpenState(for: item)
                            }
                        }
                    }
                }
            }
        }
        .generalAlert(item: $viewModel.alertItem)
        .gitErrorAlert(gitError: $viewModel.gitError)
        .commitSheet(for: $viewModel.gitLogBranch)
        .loading(loadingCount: $viewModel.loadingCount)
    }
    
    @ViewBuilder
    func listItem(item: BranchTreeItem) -> some View {
        VStack(alignment: .leading) {
            switch item.type {
            case let .directory(name):
                folderItem(name: name)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 30 * CGFloat(item.depth) + 16)
                    .padding(.trailing, 32)
                    .contentShape(Rectangle())
                    .ifElse(item.type.isRemoteDir) {
                        $0.padding(.top, 36)
                    } else: {
                        $0.padding(.top, 8)
                    }
            case let .branch(branch):
                BranchItemView(
                    branch: branch,
                    item: item,
                    viewModel: viewModel
                )
            }
        }
    }
    
    @ViewBuilder
    func folderItem(name: String) -> some View {
        HStack {
            Image("folder-solid")
                .renderingMode(.template)
            Text(name)
                .lineLimit(1)
        }
    }
}

struct BranchItemView: View {
    let branch: Branch
    let item: BranchTreeItem
    @StateObject var viewModel: BranchListViewModel
    
    @State var buttonsVisible: Bool = false
    
    var body: some View {
        branchItem(branch: branch)
            .frame(maxWidth: .infinity, idealHeight: 20, alignment: .leading)
            .padding(.leading, 30 * CGFloat(item.depth) + 16)
            .padding(.trailing, 32)
            .padding(.top, 8)
            .contentShape(Rectangle())
            .if(!branch.isCurrent) { v in
                v.contextMenu {
                    Button {
                        viewModel.checkoutBranch(for: branch)
                    } label: {
                        Text(branch.isLocal ? "Checkout Local Branch" : "Checkout Remote Branch")
                    }
                    if branch.isLocal {
                        Button {
                            viewModel.deleteBranch(for: branch)
                        } label: {
                            Text("Delete Branch")
                        }
                        if let status = viewModel.status {
                            Button {
                                viewModel.mergeBranch(for: branch)
                            } label: {
                                Text("merge into ".localized.formatted(status.branch.name))
                            }
                        }
                    }
                }
            }
            .onHover { isHover in
                buttonsVisible = isHover
            }
    }
    
    @ViewBuilder
    func branchItem(branch: Branch) -> some View {
        HStack {
            Image(branch.detached ? "code-branch-head-solid" : "code-branch-solid")
                .renderingMode(.template)
                .if(branch.isCurrent) { v in
                    v.foregroundColor(Color(nsColor: NSColor.systemGreen))
                }
            Text(branch.cleanName)
                .lineLimit(1)
                .if(branch.isCurrent) { text in
                    text.fontWeight(.heavy)
                }
                .if(branch.isCurrent) { v in
                    v.foregroundColor(Color(nsColor: NSColor.systemGreen))
                }
            OutdatedPillView(branch: branch)
            if buttonsVisible {
                Spacer()
                Button("Commits") {
                    viewModel.showLog(for: branch)
                }
            }
        }
    }
}

extension BranchTreeItem: Identifiable {
    public var id: String {
        switch self.type {
        case let .branch(branch):
            return branch.name
        case .directory(_):
            return self.fullPath
        }
    }
}

struct BranchListView_Previews: PreviewProvider {
    static var previews: some View {
        BranchListView(
            viewModel: BranchListViewModel(
                repository: PreviewRepo(),
                keyValueRepo: PreviewKeyValueRepo()
            )
        )
    }
}

private class PreviewKeyValueRepo: KeyValueRepository {
    func value<T>(for key: KeyValueKey<T>) -> T {
        return key.value
    }
    
    func set<T>(key: KeyValueKey<T>) {
        // do nothing
    }
    
    
}
