//
//  FavoritesViewModel.swift
//  Jagu
//
//  Created by Artur Hellmann on 08.02.23.
//

import Foundation
import SwiftUI

class FavoritesViewModel: BaseViewModel {
    
    let favoriteRepoService: FavoriteRepoService
    
    @Published var favorites: [RepoFavorite] = []
    
    init(favoriteRepoService: FavoriteRepoService) {
        self.favoriteRepoService = favoriteRepoService
        super.init()
        load()
    }
    
    override func load() {
        self.favorites = favoriteRepoService.favorites
            .sorted(by: { left, right in
                left.name < right.name
            })
    }
    
    func favoriteSelected(favorite: RepoFavorite) {
        AppDelegate.shared?.openRepo(path: favorite.path)
    }
    
    func delete(favorite: RepoFavorite) {
        self.favoriteRepoService.deleteFavorite(path: favorite.path)
        load()
    }
}
