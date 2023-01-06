//
//  CommitTreeItem+drawing.swift
//  GitBuddy
//
//  Created by Artur Hellmann on 05.01.23.
//

import Foundation
import SwiftUI



extension CommitTreeItem {
    static let colorSet = [
        Color(red: 0.19, green: 0.36, blue: 0.62),
        Color(red: 0.73, green: 0.35, blue: 0.18),
        Color(red: 0.07, green: 0.73, blue: 0.68),
        Color(red: 0.51, green: 0.41, blue: 0.57),
        Color(red: 0.65, green: 0.60, blue: 0.41)
    ]
    static let paddingOverdraw = CGFloat(3)
    static let leftPadding = CGFloat(8)
    static let branchShift = CGFloat(15)
    static let bubbleRadius = CGFloat(3)
    static let lineWidth = CGFloat(3)
    
    static func color(for index: Int) -> Color {
        var realIndex = index % 4
        if index > 0 {
            realIndex += 1
        }
        return CommitTreeItem.colorSet[realIndex]
    }
    
    var calculatedWidth: CGFloat {
        Self.leftPadding + Self.branchShift * CGFloat(self.branches.count)
    }
}

extension CommitTreeBranch {
    func drawPath(for position: Int, in rect: CGRect) -> Path {
        let centerY = rect.maxY / 2
        let leftPadding = CGFloat(position) * CommitTreeItem.branchShift + CommitTreeItem.leftPadding
        
        var path = Path()
        
        incoming.forEach {
            let startPosition = CommitTreeItem.leftPadding + CGFloat($0.begins) * CommitTreeItem.branchShift
            let endPosition = CGFloat($0.ends) * CommitTreeItem.branchShift + CommitTreeItem.leftPadding
            let startPoint = CGPoint(x: startPosition, y: 0 - CommitTreeItem.paddingOverdraw)
            let endPoint = calculateNewEndPoint(between: startPoint, and: CGPoint(x: endPosition, y: centerY), withBubble: hasBubble, isShift: $0.isShift)
            path.move(to: startPoint)
            path.addLine(to: endPoint.point)
        }
        
        outgoing.forEach {
            let startPosition = CGFloat($0.begins) * CommitTreeItem.branchShift + CommitTreeItem.leftPadding
            let endPosition = CommitTreeItem.leftPadding + CGFloat($0.ends) * CommitTreeItem.branchShift
            let endPoint = CGPoint(x: endPosition, y: rect.maxY + CommitTreeItem.paddingOverdraw)
            let startPoint = calculateNewStartPoint(between: CGPoint(x: startPosition, y: centerY), and: endPoint, withBubble: hasBubble, isShift: $0.isShift)
            path.move(to: startPoint.point)
            path.addLine(to: endPoint)
        }
        
        if hasBubble {
            path.move(to: CGPoint(x: leftPadding + CGFloat(3), y: centerY))
            path.addArc(center: CGPoint(x: leftPadding, y: centerY), radius: CommitTreeItem.bubbleRadius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: false)
        }
        
        return path.strokedPath(StrokeStyle(lineWidth: CommitTreeItem.lineWidth, lineCap: .round, lineJoin: .round, miterLimit: 1, dash: [], dashPhase: 1))
    }
    
    private func calculateSubstractions(between startPoint: CGPoint, and endPoint: CGPoint) -> (x: CGFloat, y: CGFloat) {
        let deltaX = endPoint.x - startPoint.x
        let deltaY = endPoint.y - startPoint.y
        
        let tan = CGFloat(deltaX) / CGFloat(deltaY)
        let angle = atan(tan)
        
        let xFit = (CommitTreeItem.bubbleRadius + CommitTreeItem.lineWidth * 2) * sin(angle)
        let yFit = (CommitTreeItem.bubbleRadius + CommitTreeItem.lineWidth * 2) * cos(angle)
        
        return (xFit, yFit)
    }
    
    private func calculateNewStartPoint(between startPoint: CGPoint, and endPoint: CGPoint, withBubble: Bool, isShift: Bool) -> (point: CGPoint, changed: Bool) {
        let isChange = endPoint.x != startPoint.x
        
        guard (withBubble || isChange) && !isShift else { return (startPoint, false) }
        
        let deltas = calculateSubstractions(between: startPoint, and: endPoint)
        return (CGPoint(x: startPoint.x + deltas.x, y: startPoint.y + deltas.y), true)
    }
    
    private func calculateNewEndPoint(between startPoint: CGPoint, and endPoint: CGPoint, withBubble: Bool, isShift: Bool) -> (point: CGPoint, changed: Bool) {
        let isChange = endPoint.x != startPoint.x
        
        guard (withBubble || isChange) && !isShift else { return (endPoint, false) }
        
        let deltas = calculateSubstractions(between: startPoint, and: endPoint)
        return (CGPoint(x: endPoint.x - deltas.x, y: endPoint.y - deltas.y), true)
    }
}
