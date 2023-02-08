//
//  FavoriteRepoService.swift
//  Jagu
//
//  Created by Artur Hellmann on 08.02.23.
//

import Foundation

class FavoriteRepoService {
    let repoRepository: FavoriteRepoRepository
    
    init(repoRepository: FavoriteRepoRepository) {
        self.repoRepository = repoRepository
    }
    
    var favorites: [RepoFavorite] {
        repoRepository.getFavorites()
            .map { path in
                RepoFavorite(path: path)
            }
    }
    
    func saveFavorite(path: String) {
        repoRepository.setAsFavorite(path: path)
    }
    
    func deleteFavorite(path: String) {
        repoRepository.deleteFavorite(path: path)
    }
}
