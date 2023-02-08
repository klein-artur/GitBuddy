//
//  LocalFavoriteRepoRepository.swift
//  Jagu
//
//  Created by Artur Hellmann on 08.02.23.
//

import Foundation

class LocalFavoriteRepoRepository: FavoriteRepoRepository, UserDefaultsRepo {
    
    static let defaultsKey: String = "LOCAL_FAVORITE_REPOSITORIES_KEY"
    
    let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    func setAsFavorite(path: String) {
        var currentList = Set(getFavorites())
        currentList.insert(path)
        userDefaults.set(Array(currentList), forKey: Self.defaultsKey)
        userDefaults.synchronize()
    }
    
    func getFavorites() -> [String] {
        return userDefaults.stringArray(forKey: Self.defaultsKey) ?? []
    }
}
