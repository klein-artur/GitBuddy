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
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 30 * CGFloat(item.depth) + 16)
                                .padding(.trailing, 16)
                                .padding(.top, 8)
                            Divider()
                        }
                        .if(selected == item.fullPath) { view in
                            view.background(Color(nsColor: NSColor.black.withAlphaComponent(0.2)))
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            switch item.type {
                            case let .branch(branch):
                                selected = branch.name
                            case .directory(_):
                                viewModel.changeOpenState(for: item)
                            }
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func listItem(item: BranchTreeItem) -> some View {
        VStack(alignment: .leading) {
            switch item.type {
            case let .directory(name):
                folderItem(name: name)
                    .padding(.trailing, 16)
            case let .branch(branch):
                branchItem(branch: branch)
                    .padding(.trailing, 16)
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
