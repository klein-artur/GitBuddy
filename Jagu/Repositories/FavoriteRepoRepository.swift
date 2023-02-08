//
//  FavoriteRepoRepository.swift
//  Jagu
//
//  Created by Artur Hellmann on 08.02.23.
//

import Foundation

/// A repository for favorite repos.
protocol FavoriteRepoRepository {
    
    /// Sets the path as a favorite repo. If already existent, nothing will happen.
    func setAsFavorite(path: String)
    
    /// Gets all favorite paths.
    func getFavorites() -> [String]
    
}
