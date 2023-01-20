//
//  DiffView.swift
//  GitBuddy
//
//  Created by Artur Hellmann on 20.01.23.
//

import SwiftUI
import GitCaller

struct DiffView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: DiffViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack {
                if let diff = viewModel.diff {
                    ForEach(diff.diffs, id: \.original) { diff in
                        diffView(diff: diff, isStaged: viewModel.staged)
                    }
                    .padding()
                } else {
                    EmptyView()
                }
            }
        }
        .frame(minWidth: 800, minHeight: 600, alignment: .topLeading)
        .loading(loadingCount: $viewModel.loadingCount)
        .onAppear {
            viewModel.load()
        }
        .gitErrorAlert(gitError: $viewModel.gitError)
    }
    
    @ViewBuilder
    private func diffView(diff: Diff, isStaged: Bool?) -> some View {
        LazyVStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(diff.leftName.lastPathComponent ?? "")
                        .lineLimit(1)
                        .fontWeight(.bold)
                    Text(diff.leftName.replacingOccurrences(of: "/\(diff.leftName.lastPathComponent ?? "")", with: ""))
                        .lineLimit(1)
                        .font(.caption)
                }
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding(8)
                .background(in: RoundedRectangle(cornerRadius: 6))
                if viewModel.rightFile != nil {
                    VStack(alignment: .leading) {
                        Text(diff.rightName.lastPathComponent ?? "")
                            .lineLimit(1)
                            .fontWeight(.bold)
                        Text(diff.rightName.replacingOccurrences(of: "/\(diff.rightName.lastPathComponent ?? "")", with: ""))
                            .lineLimit(1)
                            .font(.caption)
                    }
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding(8)
                    .background(in: RoundedRectangle(cornerRadius: 6))
                }
                if let isStaged = viewModel.staged {
                    Button(isStaged ? "unstage" : "stage") {
                        viewModel.stage()
                        dismiss()
                    }
                }
            }
            ForEach(Array(diff.hunks.enumerated()), id: \.element.original) { hunk in
                hunkView(hunk: hunk.element, index: hunk.offset, isStaged: isStaged)
            }
        }
    }
    
    @ViewBuilder
    private func hunkView(hunk: Hunk, index: Int, isStaged: Bool?) -> some View {
        LazyVStack(alignment: .leading) {
            Text("Hunk Nr. \(index + 1)")
                .frame(maxWidth: .infinity)
                .overlay(alignment: .topTrailing) {
                    if let isStaged = viewModel.staged {
                        Button(isStaged ? "unstage" : "stage") {
                            viewModel.stage(index)
                        }
                    }
                }
            LazyVStack {
                ForEach(Array(hunk.lines.enumerated()), id: \.offset) { line in
                    lineView(line: line.element, index: line.offset)
                }
            }
            .padding()
            .background(in: RoundedRectangle(cornerRadius: 6))
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .padding(8)
    }
    
    private func lineView(line: HunkLine, index: Int) -> some View {
        let color: Color
        switch line.type {
        case .both:
            color = .clear
        case .left:
            color = Color(nsColor: NSColor.systemRed.withAlphaComponent(0.4))
        case .right:
            color = Color(nsColor: NSColor.systemGreen.withAlphaComponent(0.4))
        }
        return HStack(alignment: .top) {
            Text("\(index + 1)")
                .font(Font.system(size: 14).monospaced())
                .frame(width: 30, alignment: .leading)
                .padding(.trailing, 8)
            Text(line.content.prefix(1))
                .font(Font.system(size: 14).monospaced())
            Text(line.cleanedContent)
                .font(Font.system(size: 14).monospaced())
                .background(color)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(1)
        .background(color)
    }
}

struct DiffView_Previews: PreviewProvider {
    static var previews: some View {
        DiffView(
            viewModel: DiffViewModel(
                repository: PreviewRepo(),
                leftFile: nil,
                rightFile: nil,
                staged: false
            )
        )
    }
}
