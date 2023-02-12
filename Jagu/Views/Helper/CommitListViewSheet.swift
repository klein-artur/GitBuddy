//
//  CommitListViewSheet.swift
//  Jagu
//
//  Created by Artur Hellmann on 15.01.23.
//

import SwiftUI
import GitCaller

struct CommitListViewSheet: ViewModifier {
    
    @Binding var branch: Branch?
    @Binding var shown: Bool
    
    func body(content: Content) -> some View {
        content.sheet(item: $branch) { branch in
            CommitListView(
                commitListViewModel: CommitListViewModel(
                    branch: branch
                )
            )
        }.sheet(isPresented: $shown) {
            CommitListView(
                commitListViewModel: CommitListViewModel(
                    branch: nil
                )
            )
        }
    }
}

extension View {
    func commitSheet(for branch: Binding<Branch?>) -> some View {
        modifier(CommitListViewSheet(branch: branch, shown: .constant(false)))
    }
    func commitSheet(presented: Binding<Bool>) -> some View {
        modifier(CommitListViewSheet(branch: .constant(nil), shown: presented))
    }
}

extension Branch: Identifiable {
    public var id: String {
        self.name
    }
}
