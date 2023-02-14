//
//  UserDefaults.swift
//  JaguTests
//
//  Created by Artur Hellmann on 08.02.23.
//

import Foundation

class UserDefaultsSC: UserDefaults {
    override func stringArray(forKey defaultName: String) -> [String]? { nil }
    override func set(_ value: Any?, forKey defaultName: String) { }
    override func synchronize() -> Bool { true }
}
