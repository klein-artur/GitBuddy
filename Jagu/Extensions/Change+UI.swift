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
        case .deletedByThem: return "LEF"
        case .deletedByUs: return "RIG"
        }
    }
    
    var infoColor: Color {
        switch self {
        case .bothAdded, .bothModified: return Color(NSColor.systemYellow)
        case .deleted, .deletedByThem: return Color(NSColor.systemRed)
        case .newFile, .deletedByUs: return Color(NSColor.systemGreen)
        case .modified, .renamed: return Color(NSColor.systemOrange)
        }
    }
    
    var conflict: Bool {
        self == .deletedByThem || self == .deletedByUs || self == .bothAdded || self == .bothModified
    }
    
    var deletable: Bool {
        self == .newFile || self == .modified || self == .renamed
    }
    
    var canShowDetails: Bool {
        self == .modified
    }
}
