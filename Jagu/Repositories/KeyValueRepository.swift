//
//  KeyValueRepository.swift
//  Jagu
//
//  Created by Artur Hellmann on 08.01.23.
//

import Foundation

enum KeyValueKey<V> {
    case branchPathOpen(String, V)
    
    var key: String {
        switch self {
        case let .branchPathOpen(name, _):
            return "BRANCH_PATH_OPEN_\(name)"
        }
    }
    var value: V {
        switch self {
        case let .branchPathOpen(_, value):
            return value
        }
    }
}

protocol KeyValueRepository {
    
    func value<T>(for key: KeyValueKey<T>) -> T
    
    func set<T>(key: KeyValueKey<T>)
    
}
