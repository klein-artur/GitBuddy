//
//  DiffView.swift
//  Jagu
//
//  Created by Artur Hellmann on 20.01.23.
//

import SwiftUI
import GitCaller

struct DiffView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel: DiffViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack {
                if let diff = viewModel.diff, !diff.diffs.isEmpty {
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
        .gitErrorAlert(gitError: $viewModel.gitError)
        .onAppear {
            viewModel.dismiss = _dismiss.wrappedValue
        }
    }
    
    @ViewBuilder
    private func diffView(diff: Diff, isStaged: Bool?) -> some View {
        LazyVStack {
            GroupBox {
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
                    }
                    if let isStaged = viewModel.staged {
                        Button(isStaged ? "unstage" : "stage") {
                            viewModel.stage()
                        }
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
        GroupBox {
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
                    ForEach(hunk.viewHunkLines) { line in
                        lineView(line: line)
                    }
                }
                .padding()
                .background(Color(nsColor: NSColor(red: 0.11, green: 0.11, blue: 0.11, alpha: 1.00)))
                .cornerRadius(8)
            }
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
    }
    
    private func lineView(line: ViewHunkLine) -> some View {
        let color: Color
        switch line.line.type {
        case .both:
            color = .clear
        case .left:
            color = Color(nsColor: NSColor.systemRed.withAlphaComponent(0.3))
        case .right:
            color = Color(nsColor: NSColor.systemGreen.withAlphaComponent(0.3))
        }
        return HStack(alignment: .firstTextBaseline) {
            Text(line.leftLine ?? "")
                .font(Font.system(size: 10).monospaced())
                .frame(width: 25, alignment: .leading)
                .padding(.trailing, 4)
                .foregroundColor(.secondary)
            Text(line.rightLine ?? "")
                .font(Font.system(size: 10).monospaced())
                .frame(width: 25, alignment: .leading)
                .padding(.trailing, 8)
                .foregroundColor(.secondary)
            Text(line.line.content.prefix(1))
                .font(Font.system(size: 12).monospaced())
                .foregroundColor(.secondary)
            Text(line.line.cleanedContent)
                .font(Font.system(size: 12).monospaced())
                .background(color)
                .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
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
