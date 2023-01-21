//
//  CommitTreeItem+drawing.swift
//  Jagu
//
//  Created by Artur Hellmann on 05.01.23.
//

import Foundation
import SwiftUI
import GitCaller

extension CommitTreeItem {
    static let colorSet = [
        Color(red: 0.19, green: 0.36, blue: 0.62),
        Color(red: 0.73, green: 0.35, blue: 0.18),
        Color(red: 0.07, green: 0.73, blue: 0.68),
        Color(red: 0.51, green: 0.41, blue: 0.57),
        Color(red: 0.65, green: 0.60, blue: 0.41)
    ]
    static let paddingOverdraw = CGFloat(4)
    static let leftPadding = CGFloat(8)
    static let branchShift = CGFloat(8)
    static let bubbleRadius = CGFloat(4)
    static let lineWidth = CGFloat(2)
    static let lineShiftCurveFlattnes = CGFloat(0.5)
    
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
            
            let isChange = $0.begins != $0.ends
            
            let startPosition = CommitTreeItem.leftPadding + CGFloat($0.begins) * CommitTreeItem.branchShift
            let endPosition = CGFloat($0.ends) * CommitTreeItem.branchShift + CommitTreeItem.leftPadding
            let startPoint = CGPoint(x: startPosition, y: 0 - CommitTreeItem.paddingOverdraw)
            let endPoint = CGPoint(x: endPosition, y: centerY)
            
            path.move(to: startPoint)
            
            if !isChange {
                path.addLine(to: endPoint)
            } else {
                if $0.isShift {
                    path.addCurve(
                        to: endPoint,
                        control1: CGPoint(x: CommitTreeItem.leftPadding + CGFloat($0.begins) * CommitTreeItem.branchShift, y: centerY - CommitTreeItem.lineShiftCurveFlattnes * centerY),
                        control2: CGPoint(x: CommitTreeItem.leftPadding + CGFloat($0.ends) * CommitTreeItem.branchShift, y: CommitTreeItem.lineShiftCurveFlattnes * centerY)
                    )
                } else {
                    path.addQuadCurve(to: endPoint, control: CGPoint(x: CommitTreeItem.leftPadding + CGFloat($0.begins) * CommitTreeItem.branchShift, y: centerY))
                }
            }
        }
        
        outgoing.forEach {
            let isChange = $0.begins != $0.ends
            
            let startPosition = CGFloat($0.begins) * CommitTreeItem.branchShift + CommitTreeItem.leftPadding
            let endPosition = CommitTreeItem.leftPadding + CGFloat($0.ends) * CommitTreeItem.branchShift
            let endPoint = CGPoint(x: endPosition, y: rect.maxY + CommitTreeItem.paddingOverdraw)
            let startPoint = CGPoint(x: startPosition, y: centerY)
            
            path.move(to: startPoint)
//
            if !isChange {
                path.addLine(to: endPoint)
            } else {
                if $0.isShift {
                    path.addCurve(
                        to: endPoint,
                        control1: CGPoint(x: CommitTreeItem.leftPadding + CGFloat($0.begins) * CommitTreeItem.branchShift, y: rect.maxY - CommitTreeItem.lineShiftCurveFlattnes * centerY),
                        control2: CGPoint(x: CommitTreeItem.leftPadding + CGFloat($0.ends) * CommitTreeItem.branchShift, y: centerY + CommitTreeItem.lineShiftCurveFlattnes * centerY)
                    )
                } else {
                    path.addQuadCurve(to: endPoint, control: CGPoint(x: CommitTreeItem.leftPadding + CGFloat($0.ends) * CommitTreeItem.branchShift, y: centerY))
                }
            }
        }
        
        return path.strokedPath(StrokeStyle(lineWidth: CommitTreeItem.lineWidth))
        
    }
    
    public func drawBubble(for position: Int, in rect: CGRect) -> Path {
        
        var circlePath = Path()
        
        guard hasBubble else {
            return circlePath
        }
        
        let centerY = rect.maxY / 2
        let leftPadding = CGFloat(position) * CommitTreeItem.branchShift + CommitTreeItem.leftPadding
        
        circlePath.addEllipse(in: CGRect(x: leftPadding - CommitTreeItem.bubbleRadius, y: centerY - CommitTreeItem.bubbleRadius, width: CommitTreeItem.bubbleRadius * 2, height: CommitTreeItem.bubbleRadius * 2))
        
        return circlePath
    }
}
