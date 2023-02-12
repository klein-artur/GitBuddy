//
//  CommitDetailsView.swift
//  Jagu
//
//  Created by Artur Hellmann on 12.02.23.
//

import SwiftUI
import GitCaller

struct CommitDetailsView: View {
    @ObservedObject var viewModel: CommitDetailsViewModel
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                Text(viewModel.commit.subject)
                    .multilineTextAlignment(.leading)
                    .font(.title)
                Text(viewModel.commit.body)
                    .padding(.bottom, 16)
                    .multilineTextAlignment(.leading)
                Divider()
                HStack {
                    Grid(alignment: .leading) {
                        infoLine(caption: "Author".localized, value: viewModel.authorInfo)
                        infoLine(caption: "", value: viewModel.authorDate)
                            .padding(.bottom, 8)
                        infoLine(caption: "Committer".localized, value: viewModel.committerInfo)
                        infoLine(caption: "", value: viewModel.authorDate)
                    }
                    Spacer()
                }
                TagCloudView(tags: viewModel.commit.tags.map {
                    TagElement(icon: Image("tag-solid"), text: $0) }, backgroundColor: Color(red: 0.87, green: 0.97, blue: 0.89), foregroundColor: .black)
                TagCloudView(tags: viewModel.commit.branches.map {
                    TagElement(icon: Image("code-branch-solid"), text: $0)
                }, backgroundColor: Color(red: 0.60, green: 0.86, blue: 0.60), foregroundColor: .black)
                Divider()
            }
            .padding(16)
            .frame(maxWidth: .infinity)
        }
    }
    
    func infoLine(caption: String, value: String) -> some View{
        GridRow {
            Text(caption)
            Text(value)
        }
    }
}

struct CommitDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CommitDetailsView(
            viewModel: CommitDetailsViewModel(commit: PreviewRepo.previewCommits[0])
        )
    }
}

extension Commit {
    var body: String {
        self.message.trimmingPrefix(self.subject).trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
