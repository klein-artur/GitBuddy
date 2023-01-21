//
//  LocalKeyValueRepository.swift
//  Jagu
//
//  Created by Artur Hellmann on 08.01.23.
//

import Foundation

class LocalKeyValueRepository: KeyValueRepository {
    
    func value<T>(for key: KeyValueKey<T>) -> T {
        UserDefaults.standard.value(forKey: key.key) as? T ?? key.value
    }
    
    func set<T>(key: KeyValueKey<T>) {
        let defaults = UserDefaults.standard
        defaults.set(key.value, forKey: key.key)
        defaults.synchronize()
    }
    
    
}
