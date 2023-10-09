//
//  BranchListView.swift
//  Jagu
//
//  Created by Artur Hellmann on 08.01.23.
//

import SwiftUI
import GitCaller
import SwiftDose

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
    
    @State var mergeDecissionShown: Bool = false
    @State var rebaseDecissionShown: Bool = false
    @State var noFastForwardMerge: Bool = false
    
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
                            viewModel.toDeleteBranch = branch
                        } label: {
                            Text("Delete Branch")
                        }
                        if let status = viewModel.status {
                            Button {
                                mergeDecissionShown = true
                            } label: {
                                Text("merge into ".localized.formatted(status.branch.name))
                            }
                        }
                        Button {
                            rebaseDecissionShown = true
                        } label: {
                            Text("rebase onto ".localized.formatted(branch.name))
                        }
                    }
                }
            }
            .onHover { isHover in
                buttonsVisible = isHover
            }
            .ifLet(viewModel.status) { view, status in
                view.decision(
                    showDecision: $mergeDecissionShown,
                    title: "merge into ".localized.formatted(status.branch.name),
                    message: "merging this into that".localized.formatted(branch.name, status.branch.name)
                ) {
                    viewModel.mergeBranch(for: branch, noFF: noFastForwardMerge)
                } content: {
                    Toggle("no fast forward merge", isOn: $noFastForwardMerge)
                }
                .decision(
                    showDecision: $rebaseDecissionShown,
                    title: "rebase onto ".localized.formatted(branch.name),
                    message: "rebase this onto that".localized.formatted(status.branch.name, branch.name)
                ) {
                    viewModel.rebase(onto: branch)
                } content: { }
            }
            .decision(
                item: $viewModel.toDeleteBranch,
              title: "Delete Branch",
                message: "delete local branch message") { branch  in
                    viewModel.deleteBranch(for: branch)
                } content: {
                    Toggle(isOn: $viewModel.shouldForce) {
                        Text("force delete")
                    }
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
                keyValueRepo: PreviewKeyValueRepo()
            )
        )
        .onAppear {
            DoseBindings[\.repository] = SingletonProvider(PreviewRepo())
        }
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
