//
//  Date.swift
//  Jagu
//
//  Created by Artur Hellmann on 05.01.23.
//

import Foundation

extension Date {
    var localized: String {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("ddMMyyyy HHmm")
        return dateFormatter.string(from: self)
    }
}

