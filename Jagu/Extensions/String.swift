//
//  String.swift
//  Jagu
//
//  Created by Artur Hellmann on 29.12.22.
//

import Foundation

protocol Localizable {
    var localized: String { get }
}

extension String: Localizable {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func formatted(_ arguments: CVarArg...) -> String {
        return String(format: self, arguments: arguments)
    }
}

extension String {
    var url: URL? {
        URL(string: self.replacingOccurrences(of: " ", with: "%20"))
    }
    
    var lastPathComponent: String? {
        self.url?.lastPathComponent
    }
}


// MARK: Wording

extension String {
    var words: [String] {
        self.components(separatedBy: .whitespacesAndNewlines).filter { !$0.isEmpty }
    }
}
