//
//  DiffViewModel.swift
//  Jagu
//
//  Created by Artur Hellmann on 20.01.23.
//

import Foundation
import GitCaller
import SwiftUI

@MainActor
class DiffViewModel: BaseRepositoryViewModel {
    let leftFile: String?
    let rightFile: String?
    let staged: Bool?
    
    @Published var diff: DiffResult? = nil
    @Published var selectedHunkLines: [Int: [Int]] = [:]
    
    var dismiss: DismissAction? = nil
    
    init(repository: some Repository, leftFile: String?, rightFile: String? = nil, staged: Bool? = nil) {
        self.leftFile = leftFile
        self.rightFile = rightFile
        self.staged = staged
        super.init(repository: repository)
        self.load()
    }
    
    override func load() {
        self.defaultTask { [weak self] in
            guard let self = self else {
                return
            }
            self.diff = try await self.repository.diff(path: self.leftFile, staged: self.staged ?? false, rightPath: self.rightFile)
            
            if self.diff == nil || self.diff?.diffs.isEmpty == true {
                self.dismiss?()
            }
        }
    }
    
    override func shouldHandleError(parseError: ParseError) -> Bool {
        print("")
        return true
    }
    
    func stage(_ hunkIndex: Int? = nil, lines: [Int]? = nil) {
        defaultTask { [weak self] in
            if let leftFile = self?.leftFile, self?.staged == true {
                _ = try await self?.repository.unstage(file: leftFile, hunk: hunkIndex, lines: lines)
            } else {
                _ = try await self?.repository.stage(file: self?.leftFile, hunk: hunkIndex, lines: lines)
            }
        }
    }
    
    func isSelected(in index: Int, line: Int) -> Bool {
        selectedHunkLines[index]?.contains(line) ?? false
    }
    
    func selectLine(in index: Int, line: Int, selected: Bool) {
        var currentList = selectedHunkLines[index] ?? []
        if selected {
            currentList.append(line)
        } else {
            currentList = currentList.filter { $0 != line }
        }
        if currentList.isEmpty {
            selectedHunkLines.removeValue(forKey: index)
        } else {
            selectedHunkLines[index] = currentList
        }
    }
}

struct ViewHunkLine: Identifiable {
    var id: String {
        "\(leftLine ?? "nil") <-> \(rightLine ?? "nil"): \(line.content)"
    }
    
    let leftLine: String?
    let rightLine: String?
    let line: HunkLine
    
    var isDiff: Bool {
        !line.content.hasPrefix(" ")
    }
}

extension Hunk {
    var viewHunkLines: [ViewHunkLine] {
        var leftCounter = self.leftFileRange.position
        var rightCounter = self.rightFileRange.position
        var result = [ViewHunkLine]()
        
        for line in lines {
            switch line.type {
            case .both:
                result.append(ViewHunkLine(leftLine: "\(leftCounter)", rightLine: "\(rightCounter)", line: line))
                leftCounter += 1
                rightCounter += 1
            case .left:
                result.append(ViewHunkLine(leftLine: "\(leftCounter)", rightLine: nil, line: line))
                leftCounter += 1
            case .right:
                result.append(ViewHunkLine(leftLine: nil, rightLine: "\(rightCounter)", line: line))
                rightCounter += 1
            }
        }
        
        return result
    }
}
