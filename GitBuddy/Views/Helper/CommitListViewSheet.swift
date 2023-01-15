//
//  CommitListViewSheet.swift
//  GitBuddy
//
//  Created by Artur Hellmann on 15.01.23.
//

import SwiftUI
import GitCaller

struct CommitListViewSheet: ViewModifier {
    
    @Binding var branch: Branch?
    
    func body(content: Content) -> some View {
        content.popover(item: $branch) { branch in
            CommitListView(
                commitListViewModel: CommitListViewModel(
                    repository: GitRepo.standard,
                    branch: branch
                )
            )
                .frame(minWidth: 800, minHeight: 600)
        }
    }
}

extension View {
    func commitSheet(for branch: Binding<Branch?>) -> some View {
        modifier(CommitListViewSheet(branch: branch))
    }
}

extension Branch: Identifiable {
    public var id: String {
        self.name
    }
}
