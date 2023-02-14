//
//  Pasteboard.swift
//  Jagu
//
//  Created by Artur Hellmann on 13.02.23.
//

import Foundation
import Cocoa

protocol Clipboard {
    func declareTypes(_ newTypes: [NSPasteboard.PasteboardType], owner newOwner: Any?) -> Int
    func setString(_ string: String, forType dataType: NSPasteboard.PasteboardType) -> Bool
}

extension NSPasteboard: Clipboard { }
