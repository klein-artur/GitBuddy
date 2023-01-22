import GitCaller
import Cocoa
import SwiftUI

extension Change.Kind {
    var infoString: String {
        switch self {
        case .bothAdded, .bothModified: return "MRG"
        case .deleted: return "DEL"
        case .newFile: return "ADD"
        case .modified: return "MOD"
        case .renamed: return "REN"
        }
    }
    
    var infoColor: Color {
        switch self {
        case .bothAdded, .bothModified: return Color(NSColor.systemYellow)
        case .deleted: return Color(NSColor.systemRed)
        case .newFile: return Color(NSColor.systemGreen)
        case .modified, .renamed: return Color(NSColor.systemOrange)
        }
    }
}
