//
//  CommitListViewModel.swift
//  GitBuddy
//
//  Created by Artur Hellmann on 05.01.23.
//

import Foundation
import GitCaller

class CommitListViewModel: BaseViewModel {
    
    let gitLog: LogResult
    
    lazy var commitList: CommitList = {
        CommitList(base: gitLog)
    }()
    
    init(gitLog: LogResult) {
        self.gitLog = gitLog
        super.init()
    }
    
}

class CommitTreeItem {
    let commit: Commit
    let branches: [CommitTreeBranch]
    
    init(branches: [CommitTreeBranch], commit: Commit) {
        self.branches = branches
        self.commit = commit
    }
}

class CommitTreeBranch {
    var incoming: [Line]
    var outgoing: [Line]
    var hasBubble: Bool
    var trace: Int
    
    init(incoming: [Line], outgoing: [Line], hasBubble: Bool, trace: Int) {
        self.incoming = incoming
        self.outgoing = outgoing
        self.hasBubble = hasBubble
        self.trace = trace
    }
}

struct Line {
    let begins: Int
    let ends: Int
    let isShift: Bool
}

class CommitListInformation {
    let commit: Commit
    let treeItem: CommitTreeItem
    
    init(commit: Commit, treeItem: CommitTreeItem) {
        self.commit = commit
        self.treeItem = treeItem
    }
}

indirect enum PathStep {
    case opens(from: Int, shiftBy: Int)
    case commit(commit: Commit)
    case fallThrough(toCommit: Commit?, closes: Int?, opens: Int?, shiftBy: Int)
    case closes(to: Int, shiftBy: Int)
    
    var fallThroughOpens: Int? {
        switch self {
        case .fallThrough(_, _, let opens, _):
            return opens
        default: return nil
        }
    }
    
    var fallThroughShiftBy: Int {
        switch self {
        case .fallThrough(_, _, _, let shiftBy):
            return shiftBy
        default: return 0
        }
    }
    
    var fallThroughNextCommit: Commit? {
        switch self {
        case .fallThrough(let commit, _, _, _):
            return commit
        default: return nil
        }
    }
}

class GitPath {
    var currentStep: PathStep?
    var nextStep: PathStep?
    let trace: Int
    let position: Int
    
    init(currentStep: PathStep?, nextStep: PathStep?, trace: Int, position: Int) {
        self.currentStep = currentStep
        self.nextStep = nextStep
        self.trace = trace
        self.position = position
    }
}

class CommitList: BidirectionalCollection {
    
    enum CommitListError: Error {
        case outOfBounds
    }
    
    var indices: CountableRange<Int> {
        CountableRange<Int>(uncheckedBounds: (0, endIndex))
    }
    
    typealias Index = Int
    
    typealias SubSequence = CommitList
    
    typealias Indices = CountableRange<Int>
    
    typealias Element = CommitListInformation
    
    let base: LogResult
    var indexedObjects = [Element]()
    let indexedCommits: [String: Int]
    var accessedIndex = 0
    
    var paths = [GitPath]()
    
    var currentTreeCommits: [Commit]
    private var currentTrace = 0
    
    func index(before i: Int) -> Int {
        i - 1
    }
    
    func index(after i: Int) -> Int {
        i + 1
    }
    
    var startIndex: Int {
        0
    }
    
    var endIndex: Int {
        return base.commits?.count ?? 0
    }
    
    init(base: LogResult) {
        self.base = base
        let firstCommit = base.commits?.first
        self.currentTreeCommits = firstCommit != nil ? [firstCommit!] : []
        self.indexedCommits = self.base.commits?.enumerated().reduce(into: [:]) { (result, element) in
            result[element.element.objectHash] = element.offset
        } ?? [:]
    }
    
    subscript(position: Index) -> Element {
        print("subscript of position: \(position)")
        if position >= indexedObjects.count {
            (indexedObjects.count...position).forEach {
                let commit = commit(for: position)
                indexedObjects.append(
                    CommitListInformation(
                        commit: commit,
                        treeItem: getCommitTreeItem(for: $0)
                    )
                )
            }
        }

        return indexedObjects[position]
    }
    
    subscript(bounds: Range<Index>) -> SubSequence {
        guard let currentCommits = base.commits else {
            return CommitList(
                base: LogResult(originalOutput: "")
            )
        }
        let newBase = LogResult(originalOutput: "", commits: Array(currentCommits[bounds]))
        return CommitList(base: newBase)
    }
    
    private func commit(for position: Index) -> Commit {
        return base.commits![position]
    }
    
    private func getCommitTreeItem(for position: Int) -> CommitTreeItem {
        let currentCommit = commit(for: position)
        
        var treeBranches = [CommitTreeBranch]()
        
        let paths = getPaths(for: position)
        
        for (index, path) in paths.enumerated() {
            switch path.currentStep {
            case .opens(let from, let shiftBy):
                treeBranches.append(
                    CommitTreeBranch(incoming: [], outgoing: [Line(begins: from, ends: index - shiftBy, isShift: false)], hasBubble: false, trace: path.trace)
                )
            case .closes(let to, let shiftBy):
                treeBranches.append(
                    CommitTreeBranch(incoming: [Line(begins: index, ends: to - shiftBy, isShift: false)], outgoing: [], hasBubble: false, trace: path.trace)
                )
            case .commit(_):
                let incoming = position != 0 ? [Line(begins: index, ends: index, isShift: false)] : []
                treeBranches.append(
                    CommitTreeBranch(incoming: incoming, outgoing: [Line(begins: index, ends: index, isShift: false)], hasBubble: true, trace: path.trace)
                )
            case .fallThrough(_, _, _, let shiftBy):
                var income = [Line(begins: index, ends: index, isShift: false)]
                
                treeBranches.append(
                    CommitTreeBranch(incoming: income, outgoing: [Line(begins: index, ends: index - shiftBy, isShift: shiftBy != 0)], hasBubble: false, trace: path.trace)
                )
            default: break
            }
        }
        
        return CommitTreeItem(branches: treeBranches, commit: currentCommit)
    }
    
    private func getPaths(for position: Int) -> [GitPath] {
        let currentCommit = commit(for: position)
        let nextCommit: Commit? = self.index(after: position) < endIndex ? commit(for: self.index(after: position)) : nil
        
        paths = paths.filter({ (path) -> Bool in
            switch path.currentStep {
            case .closes(_, _): return false
            default: return true
            }
        })
        
        var newPaths = [GitPath]()
        var standingOpenings = [Int: Int]()
        var shiftWaiters = [Int]()
        var shifts = 0
        
        paths.filter {
            switch $0.currentStep {
            case .closes(_, _): return false
            default: return true
            }
        }
        .forEach {
            newPaths.append($0)
        }
        
        let parents = getParents(for: currentCommit)
        
        guard !parents.isEmpty else {
            return newPaths
        }
        
        if position == 0 {
            newPaths.append(
                GitPath(
                    currentStep: .commit(commit: currentCommit),
                    nextStep: getNextStep(for: parents[0], nextCommit: nextCommit),
                    trace: newTrace(),
                    position: position
                )
            )
            for parent in parents.dropFirst() {
                newPaths.append(
                    GitPath(
                        currentStep: .opens(from: 0, shiftBy: 0),
                        nextStep: getNextStep(for: parent, nextCommit: nextCommit),
                        trace: newTrace(),
                        position: position
                    )
                )
            }
        } else {
        
            for (index, path) in paths.enumerated() {
                calculateNext(
                    of: path,
                    currentCommit: currentCommit,
                    nextCommit: nextCommit,
                    index: index,
                    position: position,
                    standingOpenings: &standingOpenings,
                    shiftWaiters: &shiftWaiters,
                    shifts: &shifts,
                    into: &newPaths)
            }
            
        }
        
        paths = newPaths
        
        return newPaths
    }
    
    private func getParents(for commit: Commit) -> [Commit] {
        commit.parents.map { base.commitDict?[$0] }.filter { $0 != nil }.map { $0! }
    }
    
    private func getNextStep(for commit: Commit?, nextCommit: Commit?) -> PathStep {
        if let commit = commit, commit == nextCommit {
            return .commit(commit: commit)
        } else {
            return .fallThrough(toCommit: commit, closes: nil, opens: nil, shiftBy: 0)
        }
    }
    
    private func findClosingPathIndex(for commit: Commit, in pathList: [GitPath]) -> Int? {
        return pathList.firstIndex { (other) -> Bool in
            
            switch other.nextStep {
            case .commit(let otherCommit):
                return otherCommit == commit
            default: break
            }
        
            return false
        }
    }
    
    private func findMergePathIndex(for commit: Commit, in pathList: [GitPath]) -> Int? {
        return pathList.firstIndex { (other) -> Bool in
            switch other.currentStep {
            case let .commit(otherCommit):
                return otherCommit == commit
            default: break
            }
            
            switch other.nextStep {
            case .commit(let otherCommit):
                return otherCommit == commit
            default: break
            }
        
            return false
        }
    }
    
    private func findOpenIntoPathIndex(for commit: Commit, nextCommit: Commit?, inBranchParent: Commit?, in pathList: [GitPath], for position: Int) -> Int? {
        return pathList.firstIndex { (other) -> Bool in
            guard other.position == position - 1 else { return false }
            var resultList = [GitPath]()
            var shiftWaiters = [Int]()
            var shifts = 0
            var standingOpenings = [Int: Int]()
            resultList.append(other)
            calculateNext(
                of: other,
                currentCommit: nil,
                nextCommit: nextCommit,
                index: 0,
                position: 0,
                standingOpenings: &standingOpenings,
                shiftWaiters: &shiftWaiters,
                shifts: &shifts,
                into: &resultList
            )
            let next = resultList[0]
            
            switch next.currentStep {
            case .fallThrough(let otherCommit, _, _, _):
                return otherCommit == commit && otherCommit != inBranchParent
            default: break
            }
            
            return false
        }
    }
    
    private func calculateNext(
        of path: GitPath,
        currentCommit: Commit?,
        nextCommit: Commit?,
        index: Int,
        position: Int,
        standingOpenings: inout [Int: Int],
        shiftWaiters: inout [Int],
        shifts: inout Int,
        into result: inout [GitPath]
    ) {
        switch path.nextStep {
        case .commit(let commit):
            if commit == currentCommit {
                
                var currentPathParent: Commit? = nil
                
                let parents = getParents(for: commit)

                for parent in parents {
                    var closingPathIndex: Int?
                    var mergePathIndex: Int?
                    var opensIntoPathIndex: Int?
                    if parents.count == 1 {
                        closingPathIndex = findClosingPathIndex(for: parent, in: result.only(for: position))
                    } else {
                        mergePathIndex = findMergePathIndex(for: parent, in: result.only(for: position))
                        if currentPathParent != nil {
                            opensIntoPathIndex = findOpenIntoPathIndex(for: parent, nextCommit: nextCommit, inBranchParent: currentPathParent, in: result, for: position)
                        }
                    }
                    
                    if let closingPathIndex = closingPathIndex, closingPathIndex < index {
                        result[index] = GitPath(currentStep: path.nextStep, nextStep: .closes(to: closingPathIndex, shiftBy: shifts), trace: path.trace, position: position)
                    } else if let mergePathIndex = mergePathIndex {
                        result[mergePathIndex].currentStep = .fallThrough(
                            toCommit: result[mergePathIndex].currentStep?.fallThroughNextCommit!,
                            closes: index,
                            opens: result[mergePathIndex].currentStep?.fallThroughOpens,
                            shiftBy: result[mergePathIndex].currentStep?.fallThroughShiftBy ?? 0
                        )
                    } else if let opensIntoPathIndex = opensIntoPathIndex, opensIntoPathIndex > index {
                        standingOpenings[opensIntoPathIndex] = index
                    } else {
                        if parents.count > 1 && currentPathParent != nil {
                            shiftWaiters.append(result.count)
                            result.append(
                                GitPath(
                                    currentStep: .opens(from: index, shiftBy: shifts),
                                    nextStep: getNextStep(for: parent, nextCommit: nextCommit),
                                    trace: newTrace(),
                                    position: position
                                )
                            )
                        } else {
                            result[index] = GitPath(currentStep: path.nextStep, nextStep: getNextStep(for: parent, nextCommit: nextCommit), trace: path.trace, position: position)
                            currentPathParent = parent
                        }
                    }
                }
            }
        case .fallThrough(let toCommit, _, _, _):
            var closingPathIndex: Int?
            if let commit = toCommit, commit == nextCommit {
                closingPathIndex = findClosingPathIndex(for: commit, in: result)
            }
            
            if let closingPathIndex = closingPathIndex, closingPathIndex < index {
                result[index] = GitPath(
                    currentStep: .fallThrough(
                        toCommit: toCommit,
                        closes: nil,
                        opens: standingOpenings[index],
                        shiftBy: shifts),
                    nextStep: .closes(to: closingPathIndex, shiftBy: shifts),
                    trace: path.trace, position: position
                )
            } else {
                result[index] = GitPath(
                    currentStep: .fallThrough(
                        toCommit: toCommit,
                        closes: nil,
                        opens: standingOpenings[index],
                        shiftBy: shifts
                    ),
                    nextStep: getNextStep(for: toCommit, nextCommit: nextCommit),
                    trace: path.trace,
                    position: position
                )
            }
        case .closes(_, _):
            result[index] = GitPath(currentStep: path.nextStep, nextStep: nil, trace: path.trace, position: position)
            shifts += 1
            for shiftWaiter in shiftWaiters.map({ result[$0] }) {
                switch shiftWaiter.currentStep {
                case .opens(let from, let shiftBy):
                    shiftWaiter.currentStep = .opens(from: from, shiftBy: shiftBy + 1)
                default: break
                }
            }
        case .none: break
        case .some(_): break
        }
    }
    
    private func newTrace() -> Int {
        let trace = currentTrace
        currentTrace += 1
        return trace
    }
}

extension Array where Element == GitPath {
    func only(for position: Int) -> [GitPath] {
        filter { $0.position == position }
    }
}
