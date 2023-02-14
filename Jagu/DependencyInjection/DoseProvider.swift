//
//  DoseKeys.swift
//  Jagu
//
//  Created by Artur Hellmann on 09.02.23.
//

import Foundation
import SwiftDose
import GitCaller
import Cocoa

struct RepositoryProvider: SingletonProvider {
    static var value: any Repository = GitRepo.standard
}

struct FavoriteRepoRepositoryProvider: InstanceProvider {
    static var savedValue: FavoriteRepoRepository?
    static func provide() -> FavoriteRepoRepository {
        print("providing new repo")
        return LocalFavoriteRepoRepository()
    }
}

struct UserDefaultsProvider: SingletonProvider {
    static var value: UserDefaults = UserDefaults.standard
}

struct PasteboardProvider: SingletonProvider {
    static var value: Clipboard = NSPasteboard.general
}

struct LoadingIndicatorServiceProvider: SingletonProvider {
    static var value: LoadingIndicatorService = LoadingIndicatorService()
}

struct FavoriteRepoServiceProvider: InstanceProvider {
    static var savedValue: FavoriteRepoService?
    static func provide() -> FavoriteRepoService {
        print("providing new service")
        return FavoriteRepoService()
    }
}

struct PasteboardServiceProvider: InstanceProvider {
    static var savedValue: PasteboardService?
    static func provide() -> PasteboardService {
        print("providing new pasteboard service")
        return PasteboardService()
    }
}
