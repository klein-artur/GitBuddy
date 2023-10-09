//
//  DoseValues.swift
//  Jagu
//
//  Created by Artur Hellmann on 09.02.23.
//

import Foundation
import SwiftDose
import GitCaller
import Cocoa

private var repositoryProvider = SingletonProvider<Repository>(GitRepo.standard)
private var userDefaultsProvider = SingletonProvider(UserDefaults.standard)
private var pasteboardProvider = SingletonProvider(NSPasteboard.general)
private var favoriteRepoRepositoryProvider = InstanceProvider<any FavoriteRepoRepository> {
    print("providing new repo")
    return LocalFavoriteRepoRepository()
}
private var favoriteRepoServiceProvider = InstanceProvider {
    print("providing new service")
    return FavoriteRepoService()
}
private var loadingIndicatorServiceProvider = SingletonProvider(LoadingIndicatorService())
private var pasteboardServiceProvider = InstanceProvider {
    print("providing new pasteboard service")
    return PasteboardService()
}

extension DoseBindings {
    var repository: SingletonProvider<Repository> {
        get { repositoryProvider }
        set { repositoryProvider = newValue }
    }
    var userDefaults: SingletonProvider<UserDefaults> {
        get { userDefaultsProvider }
        set { userDefaultsProvider = newValue }
    }
    var favoriteRepoRepository: InstanceProvider<any FavoriteRepoRepository> {
        get { favoriteRepoRepositoryProvider }
        set { favoriteRepoRepositoryProvider = newValue }
    }
    var favoriteRepoService: InstanceProvider<FavoriteRepoService> {
        get { favoriteRepoServiceProvider }
        set { favoriteRepoServiceProvider = newValue }
    }
    var loadingIndicatorService: SingletonProvider<LoadingIndicatorService> {
        get { loadingIndicatorServiceProvider }
        set { loadingIndicatorServiceProvider = newValue }
    }
    var pasteboard: SingletonProvider<NSPasteboard> {
        get { pasteboardProvider }
        set { pasteboardProvider = newValue }
    }
    var pasteboardService: InstanceProvider<PasteboardService> {
        get { pasteboardServiceProvider }
        set { pasteboardServiceProvider = newValue }
    }
}
