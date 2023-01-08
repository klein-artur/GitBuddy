//
//  BranchListView.swift
//  GitBuddy
//
//  Created by Artur Hellmann on 08.01.23.
//

import SwiftUI
import GitCaller

struct BranchListView: View {
    @ObservedObject var viewModel: BranchListViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Search", text: $viewModel.searchString)
                .showClearButton($viewModel.searchString)
                .padding(.horizontal, 16)
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(viewModel.branchTree) { item in
                        if viewModel.isVisible(for: item ) {
                            listItem(item: item)
                                .padding(.leading, 30 * CGFloat(item.depth))
                                .padding(.top, 8)
                                .padding(.bottom, 8)
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }
    
    @ViewBuilder
    func listItem(item: BranchTreeItem) -> some View {
        switch item.type {
        case let .directory(name):
            folderItem(name: name)
                .onTapGesture(count: 2) {
                    viewModel.changeOpenState(for: item)
                }
        case let .branch(branch):
            branchItem(branch: branch)
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
    
    @ViewBuilder
    func branchItem(branch: Branch) -> some View {
        HStack {
            Image(branch.detached ? "code-branch-head-solid" : "code-branch-solid")
                .renderingMode(.template)
            Text(branch.cleanName)
                .lineLimit(1)
            OutdatedPillView(branch: branch)
        }
    }
}

extension BranchTreeItem: Identifiable {
    public var id: String {
        switch self.type {
        case let .branch(branch):
            return branch.name
        case let .directory(_):
            return self.fullPath
        }
    }
}

struct BranchListView_Previews: PreviewProvider {
    static var previews: some View {
        BranchListView(
            viewModel: BranchListViewModel(
                branchResult: try! BranchResultParser().parse(result: """
                    * (HEAD detached at fadce24)
                      Savebranch                             8667982e1 fixed issue
                      main                                   8667982e1 [ahead 2] fixed issue
                      other                                  8667982e1 [behind 2] fixed issue
                      test/nested                            8667982e1 [ahead 3, behind 2] fixed issue
                      remotes/origin/HEAD -> origin/main
                      remotes/origin/main
                    """).get(),
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
