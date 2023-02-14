//
//  DoseValues.swift
//  Jagu
//
//  Created by Artur Hellmann on 09.02.23.
//

import Foundation
import SwiftDose
import GitCaller

private var repositoryProvider = RepositoryProvider()
private var userDefaultsProvider = UserDefaultsProvider()
private var pasteboardProvider = PasteboardProvider()
private var favoriteRepoRepositoryProvider = FavoriteRepoRepositoryProvider()
private var favoriteRepoServiceProvider = FavoriteRepoServiceProvider()
private var pasteboardServiceProvider = PasteboardServiceProvider()

extension DoseValues {
    var repository: RepositoryProvider {
        get { repositoryProvider }
        set { repositoryProvider = newValue }
    }
    var userDefaults: UserDefaultsProvider {
        get { userDefaultsProvider }
        set { userDefaultsProvider = newValue }
    }
    var favoriteRepoRepository: FavoriteRepoRepositoryProvider {
        get { favoriteRepoRepositoryProvider }
        set { favoriteRepoRepositoryProvider = newValue }
    }
    var favoriteRepoService: FavoriteRepoServiceProvider {
        get { favoriteRepoServiceProvider }
        set { favoriteRepoServiceProvider = newValue }
    }
    var pasteboard: PasteboardProvider {
        get { pasteboardProvider }
        set { pasteboardProvider = newValue }
    }
    var pasteboardService: PasteboardServiceProvider {
        get { pasteboardServiceProvider }
        set { pasteboardServiceProvider = newValue }
    }
}
