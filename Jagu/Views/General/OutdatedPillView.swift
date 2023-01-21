//
//  OutdatedPillView.swift
//  Jagu
//
//  Created by Artur Hellmann on 08.01.23.
//

import SwiftUI
import GitCaller

struct OutdatedPillView: View {
    let branch: Branch
    
    var body: some View {
        if !branch.outDatedPillText.isEmpty {
            VStack {
                Text(branch.outDatedPillText)
                    .font(.caption)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 6)
            }
            .background(Color.gray, in: RoundedRectangle(cornerRadius: 15))
        }
    }
}

private extension Branch {
    var outDatedPillText: String {
        var strings = [String]()
        
        if ahead > 0 {
            strings.append("\(ahead) ↑")
        }
        
        if behind > 0 {
            strings.append("\(behind) ↓")
        }
        
        return strings.joined(separator: " | ")
    }
}

struct OutdatedPillView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            OutdatedPillView(
                branch: try! BranchResultParser().parse(result: """
                          main                                   8667982e1 [ahead 2] fixed issue
                        """).get().branches!.first!
            )
            OutdatedPillView(
                branch: try! BranchResultParser().parse(result: """
                        other                                  8667982e1 [behind 2] fixed issue
                        """).get().branches!.first!
            )
            OutdatedPillView(
                branch: try! BranchResultParser().parse(result: """
                        test/nested                            8667982e1 [ahead 3, behind 2] fixed issue
                        """).get().branches!.first!
            )
        }
        
    }
}
