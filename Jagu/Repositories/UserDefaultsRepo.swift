//
//  UserDefaultsRepo.swift
//  Jagu
//
//  Created by Artur Hellmann on 08.02.23.
//

import Foundation

protocol UserDefaultsRepo {
    var userDefaults: UserDefaults { get }
    static var defaultsKey: String { get }
}
