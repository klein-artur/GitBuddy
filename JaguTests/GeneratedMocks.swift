// MARK: - Mocks generated from file: Jagu/Generalizations/Pasteboard.swift at 2023-02-16 10:38:31 +0000

//
//  Pasteboard.swift
//  Jagu
//
//  Created by Artur Hellmann on 13.02.23.
//

import Cuckoo
@testable import Jagu

import Cocoa
import Foundation






 class MockClipboard: Clipboard, Cuckoo.ProtocolMock {
    
     typealias MocksType = Clipboard
    
     typealias Stubbing = __StubbingProxy_Clipboard
     typealias Verification = __VerificationProxy_Clipboard

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: Clipboard?

     func enableDefaultImplementation(_ stub: Clipboard) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    
     func declareTypes(_ newTypes: [NSPasteboard.PasteboardType], owner newOwner: Any?) -> Int {
        
    return cuckoo_manager.call(
    """
    declareTypes(_: [NSPasteboard.PasteboardType], owner: Any?) -> Int
    """,
            parameters: (newTypes, newOwner),
            escapingParameters: (newTypes, newOwner),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.declareTypes(newTypes, owner: newOwner))
        
    }
    
    
    
    
    
     func setString(_ string: String, forType dataType: NSPasteboard.PasteboardType) -> Bool {
        
    return cuckoo_manager.call(
    """
    setString(_: String, forType: NSPasteboard.PasteboardType) -> Bool
    """,
            parameters: (string, dataType),
            escapingParameters: (string, dataType),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.setString(string, forType: dataType))
        
    }
    
    

     struct __StubbingProxy_Clipboard: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
         init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        
        
        func declareTypes<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable>(_ newTypes: M1, owner newOwner: M2) -> Cuckoo.ProtocolStubFunction<([NSPasteboard.PasteboardType], Any?), Int> where M1.MatchedType == [NSPasteboard.PasteboardType], M2.OptionalMatchedType == Any {
            let matchers: [Cuckoo.ParameterMatcher<([NSPasteboard.PasteboardType], Any?)>] = [wrap(matchable: newTypes) { $0.0 }, wrap(matchable: newOwner) { $0.1 }]
            return .init(stub: cuckoo_manager.createStub(for: MockClipboard.self, method:
    """
    declareTypes(_: [NSPasteboard.PasteboardType], owner: Any?) -> Int
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func setString<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ string: M1, forType dataType: M2) -> Cuckoo.ProtocolStubFunction<(String, NSPasteboard.PasteboardType), Bool> where M1.MatchedType == String, M2.MatchedType == NSPasteboard.PasteboardType {
            let matchers: [Cuckoo.ParameterMatcher<(String, NSPasteboard.PasteboardType)>] = [wrap(matchable: string) { $0.0 }, wrap(matchable: dataType) { $0.1 }]
            return .init(stub: cuckoo_manager.createStub(for: MockClipboard.self, method:
    """
    setString(_: String, forType: NSPasteboard.PasteboardType) -> Bool
    """, parameterMatchers: matchers))
        }
        
        
    }

     struct __VerificationProxy_Clipboard: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
         init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
    
        
    
        
        
        
        @discardableResult
        func declareTypes<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable>(_ newTypes: M1, owner newOwner: M2) -> Cuckoo.__DoNotUse<([NSPasteboard.PasteboardType], Any?), Int> where M1.MatchedType == [NSPasteboard.PasteboardType], M2.OptionalMatchedType == Any {
            let matchers: [Cuckoo.ParameterMatcher<([NSPasteboard.PasteboardType], Any?)>] = [wrap(matchable: newTypes) { $0.0 }, wrap(matchable: newOwner) { $0.1 }]
            return cuckoo_manager.verify(
    """
    declareTypes(_: [NSPasteboard.PasteboardType], owner: Any?) -> Int
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func setString<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ string: M1, forType dataType: M2) -> Cuckoo.__DoNotUse<(String, NSPasteboard.PasteboardType), Bool> where M1.MatchedType == String, M2.MatchedType == NSPasteboard.PasteboardType {
            let matchers: [Cuckoo.ParameterMatcher<(String, NSPasteboard.PasteboardType)>] = [wrap(matchable: string) { $0.0 }, wrap(matchable: dataType) { $0.1 }]
            return cuckoo_manager.verify(
    """
    setString(_: String, forType: NSPasteboard.PasteboardType) -> Bool
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
    }
}


 class ClipboardStub: Clipboard {
    

    

    
    
    
    
     func declareTypes(_ newTypes: [NSPasteboard.PasteboardType], owner newOwner: Any?) -> Int  {
        return DefaultValueRegistry.defaultValue(for: (Int).self)
    }
    
    
    
    
    
     func setString(_ string: String, forType dataType: NSPasteboard.PasteboardType) -> Bool  {
        return DefaultValueRegistry.defaultValue(for: (Bool).self)
    }
    
    
}





// MARK: - Mocks generated from file: Jagu/Repositories/FavoriteRepoRepository.swift at 2023-02-16 10:38:31 +0000

//
//  FavoriteRepoRepository.swift
//  Jagu
//
//  Created by Artur Hellmann on 08.02.23.
//

import Cuckoo
@testable import Jagu

import Foundation






 class MockFavoriteRepoRepository: FavoriteRepoRepository, Cuckoo.ProtocolMock {
    
     typealias MocksType = FavoriteRepoRepository
    
     typealias Stubbing = __StubbingProxy_FavoriteRepoRepository
     typealias Verification = __VerificationProxy_FavoriteRepoRepository

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: FavoriteRepoRepository?

     func enableDefaultImplementation(_ stub: FavoriteRepoRepository) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    
     func setAsFavorite(path: String)  {
        
    return cuckoo_manager.call(
    """
    setAsFavorite(path: String)
    """,
            parameters: (path),
            escapingParameters: (path),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.setAsFavorite(path: path))
        
    }
    
    
    
    
    
     func getFavorites() -> [String] {
        
    return cuckoo_manager.call(
    """
    getFavorites() -> [String]
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getFavorites())
        
    }
    
    
    
    
    
     func deleteFavorite(path: String)  {
        
    return cuckoo_manager.call(
    """
    deleteFavorite(path: String)
    """,
            parameters: (path),
            escapingParameters: (path),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.deleteFavorite(path: path))
        
    }
    
    

     struct __StubbingProxy_FavoriteRepoRepository: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
         init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        
        
        func setAsFavorite<M1: Cuckoo.Matchable>(path: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(String)> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: path) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockFavoriteRepoRepository.self, method:
    """
    setAsFavorite(path: String)
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func getFavorites() -> Cuckoo.ProtocolStubFunction<(), [String]> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockFavoriteRepoRepository.self, method:
    """
    getFavorites() -> [String]
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func deleteFavorite<M1: Cuckoo.Matchable>(path: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(String)> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: path) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockFavoriteRepoRepository.self, method:
    """
    deleteFavorite(path: String)
    """, parameterMatchers: matchers))
        }
        
        
    }

     struct __VerificationProxy_FavoriteRepoRepository: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
         init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
    
        
    
        
        
        
        @discardableResult
        func setAsFavorite<M1: Cuckoo.Matchable>(path: M1) -> Cuckoo.__DoNotUse<(String), Void> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: path) { $0 }]
            return cuckoo_manager.verify(
    """
    setAsFavorite(path: String)
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func getFavorites() -> Cuckoo.__DoNotUse<(), [String]> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    getFavorites() -> [String]
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func deleteFavorite<M1: Cuckoo.Matchable>(path: M1) -> Cuckoo.__DoNotUse<(String), Void> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: path) { $0 }]
            return cuckoo_manager.verify(
    """
    deleteFavorite(path: String)
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
    }
}


 class FavoriteRepoRepositoryStub: FavoriteRepoRepository {
    

    

    
    
    
    
     func setAsFavorite(path: String)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     func getFavorites() -> [String]  {
        return DefaultValueRegistry.defaultValue(for: ([String]).self)
    }
    
    
    
    
    
     func deleteFavorite(path: String)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
}





// MARK: - Mocks generated from file: Jagu/Services/FavoriteRepoService.swift at 2023-02-16 10:38:31 +0000

//
//  FavoriteRepoService.swift
//  Jagu
//
//  Created by Artur Hellmann on 08.02.23.
//

import Cuckoo
@testable import Jagu

import Foundation
import SwiftDose






 class MockFavoriteRepoService: FavoriteRepoService, Cuckoo.ClassMock {
    
     typealias MocksType = FavoriteRepoService
    
     typealias Stubbing = __StubbingProxy_FavoriteRepoService
     typealias Verification = __VerificationProxy_FavoriteRepoService

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: FavoriteRepoService?

     func enableDefaultImplementation(_ stub: FavoriteRepoService) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
    
     override var repoRepository: FavoriteRepoRepository {
        get {
            return cuckoo_manager.getter("repoRepository",
                superclassCall:
                    
                    super.repoRepository
                    ,
                defaultCall: __defaultImplStub!.repoRepository)
        }
        
        set {
            cuckoo_manager.setter("repoRepository",
                value: newValue,
                superclassCall:
                    
                    super.repoRepository = newValue
                    ,
                defaultCall: __defaultImplStub!.repoRepository = newValue)
        }
        
    }
    
    
    
    
    
     override var favorites: [RepoFavorite] {
        get {
            return cuckoo_manager.getter("favorites",
                superclassCall:
                    
                    super.favorites
                    ,
                defaultCall: __defaultImplStub!.favorites)
        }
        
    }
    
    

    

    
    
    
    
     override func saveFavorite(path: String)  {
        
    return cuckoo_manager.call(
    """
    saveFavorite(path: String)
    """,
            parameters: (path),
            escapingParameters: (path),
            superclassCall:
                
                super.saveFavorite(path: path)
                ,
            defaultCall: __defaultImplStub!.saveFavorite(path: path))
        
    }
    
    
    
    
    
     override func deleteFavorite(path: String)  {
        
    return cuckoo_manager.call(
    """
    deleteFavorite(path: String)
    """,
            parameters: (path),
            escapingParameters: (path),
            superclassCall:
                
                super.deleteFavorite(path: path)
                ,
            defaultCall: __defaultImplStub!.deleteFavorite(path: path))
        
    }
    
    

     struct __StubbingProxy_FavoriteRepoService: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
         init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        
        var repoRepository: Cuckoo.ClassToBeStubbedProperty<MockFavoriteRepoService, FavoriteRepoRepository> {
            return .init(manager: cuckoo_manager, name: "repoRepository")
        }
        
        
        
        
        var favorites: Cuckoo.ClassToBeStubbedReadOnlyProperty<MockFavoriteRepoService, [RepoFavorite]> {
            return .init(manager: cuckoo_manager, name: "favorites")
        }
        
        
        
        
        
        func saveFavorite<M1: Cuckoo.Matchable>(path: M1) -> Cuckoo.ClassStubNoReturnFunction<(String)> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: path) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockFavoriteRepoService.self, method:
    """
    saveFavorite(path: String)
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func deleteFavorite<M1: Cuckoo.Matchable>(path: M1) -> Cuckoo.ClassStubNoReturnFunction<(String)> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: path) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockFavoriteRepoService.self, method:
    """
    deleteFavorite(path: String)
    """, parameterMatchers: matchers))
        }
        
        
    }

     struct __VerificationProxy_FavoriteRepoService: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
         init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
    
        
        
        
        var repoRepository: Cuckoo.VerifyProperty<FavoriteRepoRepository> {
            return .init(manager: cuckoo_manager, name: "repoRepository", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
        
        
        var favorites: Cuckoo.VerifyReadOnlyProperty<[RepoFavorite]> {
            return .init(manager: cuckoo_manager, name: "favorites", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
    
        
        
        
        @discardableResult
        func saveFavorite<M1: Cuckoo.Matchable>(path: M1) -> Cuckoo.__DoNotUse<(String), Void> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: path) { $0 }]
            return cuckoo_manager.verify(
    """
    saveFavorite(path: String)
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func deleteFavorite<M1: Cuckoo.Matchable>(path: M1) -> Cuckoo.__DoNotUse<(String), Void> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: path) { $0 }]
            return cuckoo_manager.verify(
    """
    deleteFavorite(path: String)
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
    }
}


 class FavoriteRepoServiceStub: FavoriteRepoService {
    
    
    
    
     override var repoRepository: FavoriteRepoRepository {
        get {
            return DefaultValueRegistry.defaultValue(for: (FavoriteRepoRepository).self)
        }
        
        set { }
        
    }
    
    
    
    
    
     override var favorites: [RepoFavorite] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([RepoFavorite]).self)
        }
        
    }
    
    

    

    
    
    
    
     override func saveFavorite(path: String)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     override func deleteFavorite(path: String)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
}





// MARK: - Mocks generated from file: Jagu/Services/FileService.swift at 2023-02-16 10:38:31 +0000

//
//  FileService.swift
//  Jagu
//
//  Created by Artur Hellmann on 23.01.23.
//

import Cuckoo
@testable import Jagu

import Foundation
import GitCaller






 class MockFileService: FileService, Cuckoo.ClassMock {
    
     typealias MocksType = FileService
    
     typealias Stubbing = __StubbingProxy_FileService
     typealias Verification = __VerificationProxy_FileService

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: FileService?

     func enableDefaultImplementation(_ stub: FileService) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    
     override func delete(file: String) throws {
        
    return try cuckoo_manager.callThrows(
    """
    delete(file: String) throws
    """,
            parameters: (file),
            escapingParameters: (file),
            superclassCall:
                
                super.delete(file: file)
                ,
            defaultCall: __defaultImplStub!.delete(file: file))
        
    }
    
    

     struct __StubbingProxy_FileService: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
         init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        
        
        func delete<M1: Cuckoo.Matchable>(file: M1) -> Cuckoo.ClassStubNoReturnThrowingFunction<(String)> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: file) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockFileService.self, method:
    """
    delete(file: String) throws
    """, parameterMatchers: matchers))
        }
        
        
    }

     struct __VerificationProxy_FileService: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
         init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
    
        
    
        
        
        
        @discardableResult
        func delete<M1: Cuckoo.Matchable>(file: M1) -> Cuckoo.__DoNotUse<(String), Void> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: file) { $0 }]
            return cuckoo_manager.verify(
    """
    delete(file: String) throws
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
    }
}


 class FileServiceStub: FileService {
    

    

    
    
    
    
     override func delete(file: String) throws  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
}





// MARK: - Mocks generated from file: Jagu/Views/Helper/PreviewHelper.swift at 2023-02-16 10:38:31 +0000

//
//  PreviewHelper.swift
//  Jagu
//
//  Created by Artur Hellmann on 15.01.23.
//

import Cuckoo
@testable import Jagu

import Foundation
import GitCaller






 class MockPreviewRepo: PreviewRepo, Cuckoo.ClassMock {
    
     typealias MocksType = PreviewRepo
    
     typealias Stubbing = __StubbingProxy_PreviewRepo
     typealias Verification = __VerificationProxy_PreviewRepo

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: PreviewRepo?

     func enableDefaultImplementation(_ stub: PreviewRepo) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    
     override func stage(files paths: [String]) async throws {
        
    return try await cuckoo_manager.callThrows(
    """
    stage(files: [String]) async throws
    """,
            parameters: (paths),
            escapingParameters: (paths),
            superclassCall:
                
                await super.stage(files: paths)
                ,
            defaultCall: await __defaultImplStub!.stage(files: paths))
        
    }
    
    
    
    
    
     override func unstage(files paths: [String]) async throws {
        
    return try await cuckoo_manager.callThrows(
    """
    unstage(files: [String]) async throws
    """,
            parameters: (paths),
            escapingParameters: (paths),
            superclassCall:
                
                await super.unstage(files: paths)
                ,
            defaultCall: await __defaultImplStub!.unstage(files: paths))
        
    }
    
    
    
    
    
     override func rebase(onto branch: String) async throws {
        
    return try await cuckoo_manager.callThrows(
    """
    rebase(onto: String) async throws
    """,
            parameters: (branch),
            escapingParameters: (branch),
            superclassCall:
                
                await super.rebase(onto: branch)
                ,
            defaultCall: await __defaultImplStub!.rebase(onto: branch))
        
    }
    
    
    
    
    
     override func abortRebase() async throws {
        
    return try await cuckoo_manager.callThrows(
    """
    abortRebase() async throws
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                await super.abortRebase()
                ,
            defaultCall: await __defaultImplStub!.abortRebase())
        
    }
    
    
    
    
    
     override func continueRebase() async throws {
        
    return try await cuckoo_manager.callThrows(
    """
    continueRebase() async throws
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                await super.continueRebase()
                ,
            defaultCall: await __defaultImplStub!.continueRebase())
        
    }
    
    
    
    
    
     override func getRebaseCommitMessage() async throws -> String {
        
    return try await cuckoo_manager.callThrows(
    """
    getRebaseCommitMessage() async throws -> String
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                await super.getRebaseCommitMessage()
                ,
            defaultCall: await __defaultImplStub!.getRebaseCommitMessage())
        
    }
    
    
    
    
    
     override func pushTags() async throws {
        
    return try await cuckoo_manager.callThrows(
    """
    pushTags() async throws
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                await super.pushTags()
                ,
            defaultCall: await __defaultImplStub!.pushTags())
        
    }
    
    
    
    
    
     override func deleteTag(name: String) async throws {
        
    return try await cuckoo_manager.callThrows(
    """
    deleteTag(name: String) async throws
    """,
            parameters: (name),
            escapingParameters: (name),
            superclassCall:
                
                await super.deleteTag(name: name)
                ,
            defaultCall: await __defaultImplStub!.deleteTag(name: name))
        
    }
    
    
    
    
    
     override func getConfig(scope: GitCaller.ConfigScope, key: GitCaller.ConfigKey) async throws -> String {
        
    return try await cuckoo_manager.callThrows(
    """
    getConfig(scope: GitCaller.ConfigScope, key: GitCaller.ConfigKey) async throws -> String
    """,
            parameters: (scope, key),
            escapingParameters: (scope, key),
            superclassCall:
                
                await super.getConfig(scope: scope, key: key)
                ,
            defaultCall: await __defaultImplStub!.getConfig(scope: scope, key: key))
        
    }
    
    
    
    
    
     override func setConfig(scope: GitCaller.ConfigScope, key: GitCaller.ConfigKey, value: String) async throws {
        
    return try await cuckoo_manager.callThrows(
    """
    setConfig(scope: GitCaller.ConfigScope, key: GitCaller.ConfigKey, value: String) async throws
    """,
            parameters: (scope, key, value),
            escapingParameters: (scope, key, value),
            superclassCall:
                
                await super.setConfig(scope: scope, key: key, value: value)
                ,
            defaultCall: await __defaultImplStub!.setConfig(scope: scope, key: key, value: value))
        
    }
    
    
    
    
    
     override func unsetConfig(scope: GitCaller.ConfigScope, key: GitCaller.ConfigKey) async throws {
        
    return try await cuckoo_manager.callThrows(
    """
    unsetConfig(scope: GitCaller.ConfigScope, key: GitCaller.ConfigKey) async throws
    """,
            parameters: (scope, key),
            escapingParameters: (scope, key),
            superclassCall:
                
                await super.unsetConfig(scope: scope, key: key)
                ,
            defaultCall: await __defaultImplStub!.unsetConfig(scope: scope, key: key))
        
    }
    
    
    
    
    
     override func continueMerge() async throws {
        
    return try await cuckoo_manager.callThrows(
    """
    continueMerge() async throws
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                await super.continueMerge()
                ,
            defaultCall: await __defaultImplStub!.continueMerge())
        
    }
    
    
    
    
    
     override func clone(url: String) async throws -> GitCaller.CloneResult {
        
    return try await cuckoo_manager.callThrows(
    """
    clone(url: String) async throws -> GitCaller.CloneResult
    """,
            parameters: (url),
            escapingParameters: (url),
            superclassCall:
                
                await super.clone(url: url)
                ,
            defaultCall: await __defaultImplStub!.clone(url: url))
        
    }
    
    
    
    
    
     override func show(commitHash: String) async throws -> LogResult {
        
    return try await cuckoo_manager.callThrows(
    """
    show(commitHash: String) async throws -> LogResult
    """,
            parameters: (commitHash),
            escapingParameters: (commitHash),
            superclassCall:
                
                await super.show(commitHash: commitHash)
                ,
            defaultCall: await __defaultImplStub!.show(commitHash: commitHash))
        
    }
    
    
    
    
    
     override func getLog(branchNames: [String]) async throws -> GitCaller.LogResult {
        
    return try await cuckoo_manager.callThrows(
    """
    getLog(branchNames: [String]) async throws -> GitCaller.LogResult
    """,
            parameters: (branchNames),
            escapingParameters: (branchNames),
            superclassCall:
                
                await super.getLog(branchNames: branchNames)
                ,
            defaultCall: await __defaultImplStub!.getLog(branchNames: branchNames))
        
    }
    
    
    
    
    
     override func getLog(commitHash: String) async throws -> GitCaller.LogResult {
        
    return try await cuckoo_manager.callThrows(
    """
    getLog(commitHash: String) async throws -> GitCaller.LogResult
    """,
            parameters: (commitHash),
            escapingParameters: (commitHash),
            superclassCall:
                
                await super.getLog(commitHash: commitHash)
                ,
            defaultCall: await __defaultImplStub!.getLog(commitHash: commitHash))
        
    }
    
    
    
    
    
     override func getLog() async throws -> GitCaller.LogResult {
        
    return try await cuckoo_manager.callThrows(
    """
    getLog() async throws -> GitCaller.LogResult
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                await super.getLog()
                ,
            defaultCall: await __defaultImplStub!.getLog())
        
    }
    
    
    
    
    
     override func getStatus() async throws -> GitCaller.StatusResult {
        
    return try await cuckoo_manager.callThrows(
    """
    getStatus() async throws -> GitCaller.StatusResult
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                await super.getStatus()
                ,
            defaultCall: await __defaultImplStub!.getStatus())
        
    }
    
    
    
    
    
     override func getBranches() async throws -> GitCaller.BranchResult {
        
    return try await cuckoo_manager.callThrows(
    """
    getBranches() async throws -> GitCaller.BranchResult
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                await super.getBranches()
                ,
            defaultCall: await __defaultImplStub!.getBranches())
        
    }
    
    
    
    
    
     override func checkout(branch: GitCaller.Branch) async throws -> GitCaller.CheckoutResult {
        
    return try await cuckoo_manager.callThrows(
    """
    checkout(branch: GitCaller.Branch) async throws -> GitCaller.CheckoutResult
    """,
            parameters: (branch),
            escapingParameters: (branch),
            superclassCall:
                
                await super.checkout(branch: branch)
                ,
            defaultCall: await __defaultImplStub!.checkout(branch: branch))
        
    }
    
    
    
    
    
     override func delete(branch: GitCaller.Branch, force: Bool) async throws -> GitCaller.BranchResult {
        
    return try await cuckoo_manager.callThrows(
    """
    delete(branch: GitCaller.Branch, force: Bool) async throws -> GitCaller.BranchResult
    """,
            parameters: (branch, force),
            escapingParameters: (branch, force),
            superclassCall:
                
                await super.delete(branch: branch, force: force)
                ,
            defaultCall: await __defaultImplStub!.delete(branch: branch, force: force))
        
    }
    
    
    
    
    
     override func stage(file path: String?) async throws {
        
    return try await cuckoo_manager.callThrows(
    """
    stage(file: String?) async throws
    """,
            parameters: (path),
            escapingParameters: (path),
            superclassCall:
                
                await super.stage(file: path)
                ,
            defaultCall: await __defaultImplStub!.stage(file: path))
        
    }
    
    
    
    
    
     override func unstage(file path: String) async throws -> RestoreResult {
        
    return try await cuckoo_manager.callThrows(
    """
    unstage(file: String) async throws -> RestoreResult
    """,
            parameters: (path),
            escapingParameters: (path),
            superclassCall:
                
                await super.unstage(file: path)
                ,
            defaultCall: await __defaultImplStub!.unstage(file: path))
        
    }
    
    
    
    
    
     override func revert(unstagedFile path: String) async throws -> RestoreResult {
        
    return try await cuckoo_manager.callThrows(
    """
    revert(unstagedFile: String) async throws -> RestoreResult
    """,
            parameters: (path),
            escapingParameters: (path),
            superclassCall:
                
                await super.revert(unstagedFile: path)
                ,
            defaultCall: await __defaultImplStub!.revert(unstagedFile: path))
        
    }
    
    
    
    
    
     override func revert(unstagedFiles paths: [String]) async throws {
        
    return try await cuckoo_manager.callThrows(
    """
    revert(unstagedFiles: [String]) async throws
    """,
            parameters: (paths),
            escapingParameters: (paths),
            superclassCall:
                
                await super.revert(unstagedFiles: paths)
                ,
            defaultCall: await __defaultImplStub!.revert(unstagedFiles: paths))
        
    }
    
    
    
    
    
     override func revertDeleted(unstagedFile path: String) async throws {
        
    return try await cuckoo_manager.callThrows(
    """
    revertDeleted(unstagedFile: String) async throws
    """,
            parameters: (path),
            escapingParameters: (path),
            superclassCall:
                
                await super.revertDeleted(unstagedFile: path)
                ,
            defaultCall: await __defaultImplStub!.revertDeleted(unstagedFile: path))
        
    }
    
    
    
    
    
     override func commit(message: String) async throws {
        
    return try await cuckoo_manager.callThrows(
    """
    commit(message: String) async throws
    """,
            parameters: (message),
            escapingParameters: (message),
            superclassCall:
                
                await super.commit(message: message)
                ,
            defaultCall: await __defaultImplStub!.commit(message: message))
        
    }
    
    
    
    
    
     override func fetch() async throws {
        
    return try await cuckoo_manager.callThrows(
    """
    fetch() async throws
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                await super.fetch()
                ,
            defaultCall: await __defaultImplStub!.fetch())
        
    }
    
    
    
    
    
     override func pull(force: Bool) async throws -> PullResult {
        
    return try await cuckoo_manager.callThrows(
    """
    pull(force: Bool) async throws -> PullResult
    """,
            parameters: (force),
            escapingParameters: (force),
            superclassCall:
                
                await super.pull(force: force)
                ,
            defaultCall: await __defaultImplStub!.pull(force: force))
        
    }
    
    
    
    
    
    public override func push(force: Bool, createUpstream: Bool, remoteName: String?, newName: String?) async throws -> PushResult {
        
    return try await cuckoo_manager.callThrows(
    """
    push(force: Bool, createUpstream: Bool, remoteName: String?, newName: String?) async throws -> PushResult
    """,
            parameters: (force, createUpstream, remoteName, newName),
            escapingParameters: (force, createUpstream, remoteName, newName),
            superclassCall:
                
                await super.push(force: force, createUpstream: createUpstream, remoteName: remoteName, newName: newName)
                ,
            defaultCall: await __defaultImplStub!.push(force: force, createUpstream: createUpstream, remoteName: remoteName, newName: newName))
        
    }
    
    
    
    
    
     override func newBranchAndCheckout(name: String) async throws -> CheckoutResult {
        
    return try await cuckoo_manager.callThrows(
    """
    newBranchAndCheckout(name: String) async throws -> CheckoutResult
    """,
            parameters: (name),
            escapingParameters: (name),
            superclassCall:
                
                await super.newBranchAndCheckout(name: name)
                ,
            defaultCall: await __defaultImplStub!.newBranchAndCheckout(name: name))
        
    }
    
    
    
    
    
     override func diff(path: String?, staged: Bool, rightPath: String?) async throws -> DiffResult {
        
    return try await cuckoo_manager.callThrows(
    """
    diff(path: String?, staged: Bool, rightPath: String?) async throws -> DiffResult
    """,
            parameters: (path, staged, rightPath),
            escapingParameters: (path, staged, rightPath),
            superclassCall:
                
                await super.diff(path: path, staged: staged, rightPath: rightPath)
                ,
            defaultCall: await __defaultImplStub!.diff(path: path, staged: staged, rightPath: rightPath))
        
    }
    
    
    
    
    
     override func needsUpdate()  {
        
    return cuckoo_manager.call(
    """
    needsUpdate()
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.needsUpdate()
                ,
            defaultCall: __defaultImplStub!.needsUpdate())
        
    }
    
    
    
    
    
     override func merge(branch: String) async throws {
        
    return try await cuckoo_manager.callThrows(
    """
    merge(branch: String) async throws
    """,
            parameters: (branch),
            escapingParameters: (branch),
            superclassCall:
                
                await super.merge(branch: branch)
                ,
            defaultCall: await __defaultImplStub!.merge(branch: branch))
        
    }
    
    
    
    
    
     override func abortMerge() async throws {
        
    return try await cuckoo_manager.callThrows(
    """
    abortMerge() async throws
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                await super.abortMerge()
                ,
            defaultCall: await __defaultImplStub!.abortMerge())
        
    }
    
    
    
    
    
     override func mergetool(file: String, tool: String) async throws {
        
    return try await cuckoo_manager.callThrows(
    """
    mergetool(file: String, tool: String) async throws
    """,
            parameters: (file, tool),
            escapingParameters: (file, tool),
            superclassCall:
                
                await super.mergetool(file: file, tool: tool)
                ,
            defaultCall: await __defaultImplStub!.mergetool(file: file, tool: tool))
        
    }
    
    
    
    
    
     override func useOurs(path: String) async throws {
        
    return try await cuckoo_manager.callThrows(
    """
    useOurs(path: String) async throws
    """,
            parameters: (path),
            escapingParameters: (path),
            superclassCall:
                
                await super.useOurs(path: path)
                ,
            defaultCall: await __defaultImplStub!.useOurs(path: path))
        
    }
    
    
    
    
    
     override func useTheirs(path: String) async throws {
        
    return try await cuckoo_manager.callThrows(
    """
    useTheirs(path: String) async throws
    """,
            parameters: (path),
            escapingParameters: (path),
            superclassCall:
                
                await super.useTheirs(path: path)
                ,
            defaultCall: await __defaultImplStub!.useTheirs(path: path))
        
    }
    
    
    
    
    
     override func getMergeCommitMessage() async throws -> String {
        
    return try await cuckoo_manager.callThrows(
    """
    getMergeCommitMessage() async throws -> String
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                await super.getMergeCommitMessage()
                ,
            defaultCall: await __defaultImplStub!.getMergeCommitMessage())
        
    }
    
    

     struct __StubbingProxy_PreviewRepo: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
         init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        
        
        func stage<M1: Cuckoo.Matchable>(files paths: M1) -> Cuckoo.ClassStubNoReturnThrowingFunction<([String])> where M1.MatchedType == [String] {
            let matchers: [Cuckoo.ParameterMatcher<([String])>] = [wrap(matchable: paths) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockPreviewRepo.self, method:
    """
    stage(files: [String]) async throws
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func unstage<M1: Cuckoo.Matchable>(files paths: M1) -> Cuckoo.ClassStubNoReturnThrowingFunction<([String])> where M1.MatchedType == [String] {
            let matchers: [Cuckoo.ParameterMatcher<([String])>] = [wrap(matchable: paths) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockPreviewRepo.self, method:
    """
    unstage(files: [String]) async throws
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func rebase<M1: Cuckoo.Matchable>(onto branch: M1) -> Cuckoo.ClassStubNoReturnThrowingFunction<(String)> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: branch) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockPreviewRepo.self, method:
    """
    rebase(onto: String) async throws
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func abortRebase() -> Cuckoo.ClassStubNoReturnThrowingFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockPreviewRepo.self, method:
    """
    abortRebase() async throws
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func continueRebase() -> Cuckoo.ClassStubNoReturnThrowingFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockPreviewRepo.self, method:
    """
    continueRebase() async throws
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func getRebaseCommitMessage() -> Cuckoo.ClassStubThrowingFunction<(), String> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockPreviewRepo.self, method:
    """
    getRebaseCommitMessage() async throws -> String
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func pushTags() -> Cuckoo.ClassStubNoReturnThrowingFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockPreviewRepo.self, method:
    """
    pushTags() async throws
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func deleteTag<M1: Cuckoo.Matchable>(name: M1) -> Cuckoo.ClassStubNoReturnThrowingFunction<(String)> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: name) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockPreviewRepo.self, method:
    """
    deleteTag(name: String) async throws
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func getConfig<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(scope: M1, key: M2) -> Cuckoo.ClassStubThrowingFunction<(GitCaller.ConfigScope, GitCaller.ConfigKey), String> where M1.MatchedType == GitCaller.ConfigScope, M2.MatchedType == GitCaller.ConfigKey {
            let matchers: [Cuckoo.ParameterMatcher<(GitCaller.ConfigScope, GitCaller.ConfigKey)>] = [wrap(matchable: scope) { $0.0 }, wrap(matchable: key) { $0.1 }]
            return .init(stub: cuckoo_manager.createStub(for: MockPreviewRepo.self, method:
    """
    getConfig(scope: GitCaller.ConfigScope, key: GitCaller.ConfigKey) async throws -> String
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func setConfig<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(scope: M1, key: M2, value: M3) -> Cuckoo.ClassStubNoReturnThrowingFunction<(GitCaller.ConfigScope, GitCaller.ConfigKey, String)> where M1.MatchedType == GitCaller.ConfigScope, M2.MatchedType == GitCaller.ConfigKey, M3.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(GitCaller.ConfigScope, GitCaller.ConfigKey, String)>] = [wrap(matchable: scope) { $0.0 }, wrap(matchable: key) { $0.1 }, wrap(matchable: value) { $0.2 }]
            return .init(stub: cuckoo_manager.createStub(for: MockPreviewRepo.self, method:
    """
    setConfig(scope: GitCaller.ConfigScope, key: GitCaller.ConfigKey, value: String) async throws
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func unsetConfig<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(scope: M1, key: M2) -> Cuckoo.ClassStubNoReturnThrowingFunction<(GitCaller.ConfigScope, GitCaller.ConfigKey)> where M1.MatchedType == GitCaller.ConfigScope, M2.MatchedType == GitCaller.ConfigKey {
            let matchers: [Cuckoo.ParameterMatcher<(GitCaller.ConfigScope, GitCaller.ConfigKey)>] = [wrap(matchable: scope) { $0.0 }, wrap(matchable: key) { $0.1 }]
            return .init(stub: cuckoo_manager.createStub(for: MockPreviewRepo.self, method:
    """
    unsetConfig(scope: GitCaller.ConfigScope, key: GitCaller.ConfigKey) async throws
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func continueMerge() -> Cuckoo.ClassStubNoReturnThrowingFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockPreviewRepo.self, method:
    """
    continueMerge() async throws
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func clone<M1: Cuckoo.Matchable>(url: M1) -> Cuckoo.ClassStubThrowingFunction<(String), GitCaller.CloneResult> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: url) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockPreviewRepo.self, method:
    """
    clone(url: String) async throws -> GitCaller.CloneResult
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func show<M1: Cuckoo.Matchable>(commitHash: M1) -> Cuckoo.ClassStubThrowingFunction<(String), LogResult> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: commitHash) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockPreviewRepo.self, method:
    """
    show(commitHash: String) async throws -> LogResult
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func getLog<M1: Cuckoo.Matchable>(branchNames: M1) -> Cuckoo.ClassStubThrowingFunction<([String]), GitCaller.LogResult> where M1.MatchedType == [String] {
            let matchers: [Cuckoo.ParameterMatcher<([String])>] = [wrap(matchable: branchNames) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockPreviewRepo.self, method:
    """
    getLog(branchNames: [String]) async throws -> GitCaller.LogResult
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func getLog<M1: Cuckoo.Matchable>(commitHash: M1) -> Cuckoo.ClassStubThrowingFunction<(String), GitCaller.LogResult> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: commitHash) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockPreviewRepo.self, method:
    """
    getLog(commitHash: String) async throws -> GitCaller.LogResult
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func getLog() -> Cuckoo.ClassStubThrowingFunction<(), GitCaller.LogResult> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockPreviewRepo.self, method:
    """
    getLog() async throws -> GitCaller.LogResult
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func getStatus() -> Cuckoo.ClassStubThrowingFunction<(), GitCaller.StatusResult> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockPreviewRepo.self, method:
    """
    getStatus() async throws -> GitCaller.StatusResult
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func getBranches() -> Cuckoo.ClassStubThrowingFunction<(), GitCaller.BranchResult> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockPreviewRepo.self, method:
    """
    getBranches() async throws -> GitCaller.BranchResult
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func checkout<M1: Cuckoo.Matchable>(branch: M1) -> Cuckoo.ClassStubThrowingFunction<(GitCaller.Branch), GitCaller.CheckoutResult> where M1.MatchedType == GitCaller.Branch {
            let matchers: [Cuckoo.ParameterMatcher<(GitCaller.Branch)>] = [wrap(matchable: branch) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockPreviewRepo.self, method:
    """
    checkout(branch: GitCaller.Branch) async throws -> GitCaller.CheckoutResult
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func delete<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(branch: M1, force: M2) -> Cuckoo.ClassStubThrowingFunction<(GitCaller.Branch, Bool), GitCaller.BranchResult> where M1.MatchedType == GitCaller.Branch, M2.MatchedType == Bool {
            let matchers: [Cuckoo.ParameterMatcher<(GitCaller.Branch, Bool)>] = [wrap(matchable: branch) { $0.0 }, wrap(matchable: force) { $0.1 }]
            return .init(stub: cuckoo_manager.createStub(for: MockPreviewRepo.self, method:
    """
    delete(branch: GitCaller.Branch, force: Bool) async throws -> GitCaller.BranchResult
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func stage<M1: Cuckoo.OptionalMatchable>(file path: M1) -> Cuckoo.ClassStubNoReturnThrowingFunction<(String?)> where M1.OptionalMatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String?)>] = [wrap(matchable: path) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockPreviewRepo.self, method:
    """
    stage(file: String?) async throws
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func unstage<M1: Cuckoo.Matchable>(file path: M1) -> Cuckoo.ClassStubThrowingFunction<(String), RestoreResult> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: path) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockPreviewRepo.self, method:
    """
    unstage(file: String) async throws -> RestoreResult
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func revert<M1: Cuckoo.Matchable>(unstagedFile path: M1) -> Cuckoo.ClassStubThrowingFunction<(String), RestoreResult> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: path) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockPreviewRepo.self, method:
    """
    revert(unstagedFile: String) async throws -> RestoreResult
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func revert<M1: Cuckoo.Matchable>(unstagedFiles paths: M1) -> Cuckoo.ClassStubNoReturnThrowingFunction<([String])> where M1.MatchedType == [String] {
            let matchers: [Cuckoo.ParameterMatcher<([String])>] = [wrap(matchable: paths) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockPreviewRepo.self, method:
    """
    revert(unstagedFiles: [String]) async throws
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func revertDeleted<M1: Cuckoo.Matchable>(unstagedFile path: M1) -> Cuckoo.ClassStubNoReturnThrowingFunction<(String)> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: path) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockPreviewRepo.self, method:
    """
    revertDeleted(unstagedFile: String) async throws
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func commit<M1: Cuckoo.Matchable>(message: M1) -> Cuckoo.ClassStubNoReturnThrowingFunction<(String)> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: message) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockPreviewRepo.self, method:
    """
    commit(message: String) async throws
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func fetch() -> Cuckoo.ClassStubNoReturnThrowingFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockPreviewRepo.self, method:
    """
    fetch() async throws
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func pull<M1: Cuckoo.Matchable>(force: M1) -> Cuckoo.ClassStubThrowingFunction<(Bool), PullResult> where M1.MatchedType == Bool {
            let matchers: [Cuckoo.ParameterMatcher<(Bool)>] = [wrap(matchable: force) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockPreviewRepo.self, method:
    """
    pull(force: Bool) async throws -> PullResult
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func push<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.OptionalMatchable, M4: Cuckoo.OptionalMatchable>(force: M1, createUpstream: M2, remoteName: M3, newName: M4) -> Cuckoo.ClassStubThrowingFunction<(Bool, Bool, String?, String?), PushResult> where M1.MatchedType == Bool, M2.MatchedType == Bool, M3.OptionalMatchedType == String, M4.OptionalMatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(Bool, Bool, String?, String?)>] = [wrap(matchable: force) { $0.0 }, wrap(matchable: createUpstream) { $0.1 }, wrap(matchable: remoteName) { $0.2 }, wrap(matchable: newName) { $0.3 }]
            return .init(stub: cuckoo_manager.createStub(for: MockPreviewRepo.self, method:
    """
    push(force: Bool, createUpstream: Bool, remoteName: String?, newName: String?) async throws -> PushResult
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func newBranchAndCheckout<M1: Cuckoo.Matchable>(name: M1) -> Cuckoo.ClassStubThrowingFunction<(String), CheckoutResult> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: name) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockPreviewRepo.self, method:
    """
    newBranchAndCheckout(name: String) async throws -> CheckoutResult
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func diff<M1: Cuckoo.OptionalMatchable, M2: Cuckoo.Matchable, M3: Cuckoo.OptionalMatchable>(path: M1, staged: M2, rightPath: M3) -> Cuckoo.ClassStubThrowingFunction<(String?, Bool, String?), DiffResult> where M1.OptionalMatchedType == String, M2.MatchedType == Bool, M3.OptionalMatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String?, Bool, String?)>] = [wrap(matchable: path) { $0.0 }, wrap(matchable: staged) { $0.1 }, wrap(matchable: rightPath) { $0.2 }]
            return .init(stub: cuckoo_manager.createStub(for: MockPreviewRepo.self, method:
    """
    diff(path: String?, staged: Bool, rightPath: String?) async throws -> DiffResult
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func needsUpdate() -> Cuckoo.ClassStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockPreviewRepo.self, method:
    """
    needsUpdate()
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func merge<M1: Cuckoo.Matchable>(branch: M1) -> Cuckoo.ClassStubNoReturnThrowingFunction<(String)> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: branch) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockPreviewRepo.self, method:
    """
    merge(branch: String) async throws
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func abortMerge() -> Cuckoo.ClassStubNoReturnThrowingFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockPreviewRepo.self, method:
    """
    abortMerge() async throws
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func mergetool<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(file: M1, tool: M2) -> Cuckoo.ClassStubNoReturnThrowingFunction<(String, String)> where M1.MatchedType == String, M2.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: file) { $0.0 }, wrap(matchable: tool) { $0.1 }]
            return .init(stub: cuckoo_manager.createStub(for: MockPreviewRepo.self, method:
    """
    mergetool(file: String, tool: String) async throws
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func useOurs<M1: Cuckoo.Matchable>(path: M1) -> Cuckoo.ClassStubNoReturnThrowingFunction<(String)> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: path) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockPreviewRepo.self, method:
    """
    useOurs(path: String) async throws
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func useTheirs<M1: Cuckoo.Matchable>(path: M1) -> Cuckoo.ClassStubNoReturnThrowingFunction<(String)> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: path) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockPreviewRepo.self, method:
    """
    useTheirs(path: String) async throws
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func getMergeCommitMessage() -> Cuckoo.ClassStubThrowingFunction<(), String> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockPreviewRepo.self, method:
    """
    getMergeCommitMessage() async throws -> String
    """, parameterMatchers: matchers))
        }
        
        
    }

     struct __VerificationProxy_PreviewRepo: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
         init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
    
        
    
        
        
        
        @discardableResult
        func stage<M1: Cuckoo.Matchable>(files paths: M1) -> Cuckoo.__DoNotUse<([String]), Void> where M1.MatchedType == [String] {
            let matchers: [Cuckoo.ParameterMatcher<([String])>] = [wrap(matchable: paths) { $0 }]
            return cuckoo_manager.verify(
    """
    stage(files: [String]) async throws
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func unstage<M1: Cuckoo.Matchable>(files paths: M1) -> Cuckoo.__DoNotUse<([String]), Void> where M1.MatchedType == [String] {
            let matchers: [Cuckoo.ParameterMatcher<([String])>] = [wrap(matchable: paths) { $0 }]
            return cuckoo_manager.verify(
    """
    unstage(files: [String]) async throws
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func rebase<M1: Cuckoo.Matchable>(onto branch: M1) -> Cuckoo.__DoNotUse<(String), Void> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: branch) { $0 }]
            return cuckoo_manager.verify(
    """
    rebase(onto: String) async throws
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func abortRebase() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    abortRebase() async throws
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func continueRebase() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    continueRebase() async throws
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func getRebaseCommitMessage() -> Cuckoo.__DoNotUse<(), String> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    getRebaseCommitMessage() async throws -> String
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func pushTags() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    pushTags() async throws
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func deleteTag<M1: Cuckoo.Matchable>(name: M1) -> Cuckoo.__DoNotUse<(String), Void> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: name) { $0 }]
            return cuckoo_manager.verify(
    """
    deleteTag(name: String) async throws
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func getConfig<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(scope: M1, key: M2) -> Cuckoo.__DoNotUse<(GitCaller.ConfigScope, GitCaller.ConfigKey), String> where M1.MatchedType == GitCaller.ConfigScope, M2.MatchedType == GitCaller.ConfigKey {
            let matchers: [Cuckoo.ParameterMatcher<(GitCaller.ConfigScope, GitCaller.ConfigKey)>] = [wrap(matchable: scope) { $0.0 }, wrap(matchable: key) { $0.1 }]
            return cuckoo_manager.verify(
    """
    getConfig(scope: GitCaller.ConfigScope, key: GitCaller.ConfigKey) async throws -> String
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func setConfig<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(scope: M1, key: M2, value: M3) -> Cuckoo.__DoNotUse<(GitCaller.ConfigScope, GitCaller.ConfigKey, String), Void> where M1.MatchedType == GitCaller.ConfigScope, M2.MatchedType == GitCaller.ConfigKey, M3.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(GitCaller.ConfigScope, GitCaller.ConfigKey, String)>] = [wrap(matchable: scope) { $0.0 }, wrap(matchable: key) { $0.1 }, wrap(matchable: value) { $0.2 }]
            return cuckoo_manager.verify(
    """
    setConfig(scope: GitCaller.ConfigScope, key: GitCaller.ConfigKey, value: String) async throws
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func unsetConfig<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(scope: M1, key: M2) -> Cuckoo.__DoNotUse<(GitCaller.ConfigScope, GitCaller.ConfigKey), Void> where M1.MatchedType == GitCaller.ConfigScope, M2.MatchedType == GitCaller.ConfigKey {
            let matchers: [Cuckoo.ParameterMatcher<(GitCaller.ConfigScope, GitCaller.ConfigKey)>] = [wrap(matchable: scope) { $0.0 }, wrap(matchable: key) { $0.1 }]
            return cuckoo_manager.verify(
    """
    unsetConfig(scope: GitCaller.ConfigScope, key: GitCaller.ConfigKey) async throws
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func continueMerge() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    continueMerge() async throws
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func clone<M1: Cuckoo.Matchable>(url: M1) -> Cuckoo.__DoNotUse<(String), GitCaller.CloneResult> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: url) { $0 }]
            return cuckoo_manager.verify(
    """
    clone(url: String) async throws -> GitCaller.CloneResult
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func show<M1: Cuckoo.Matchable>(commitHash: M1) -> Cuckoo.__DoNotUse<(String), LogResult> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: commitHash) { $0 }]
            return cuckoo_manager.verify(
    """
    show(commitHash: String) async throws -> LogResult
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func getLog<M1: Cuckoo.Matchable>(branchNames: M1) -> Cuckoo.__DoNotUse<([String]), GitCaller.LogResult> where M1.MatchedType == [String] {
            let matchers: [Cuckoo.ParameterMatcher<([String])>] = [wrap(matchable: branchNames) { $0 }]
            return cuckoo_manager.verify(
    """
    getLog(branchNames: [String]) async throws -> GitCaller.LogResult
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func getLog<M1: Cuckoo.Matchable>(commitHash: M1) -> Cuckoo.__DoNotUse<(String), GitCaller.LogResult> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: commitHash) { $0 }]
            return cuckoo_manager.verify(
    """
    getLog(commitHash: String) async throws -> GitCaller.LogResult
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func getLog() -> Cuckoo.__DoNotUse<(), GitCaller.LogResult> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    getLog() async throws -> GitCaller.LogResult
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func getStatus() -> Cuckoo.__DoNotUse<(), GitCaller.StatusResult> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    getStatus() async throws -> GitCaller.StatusResult
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func getBranches() -> Cuckoo.__DoNotUse<(), GitCaller.BranchResult> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    getBranches() async throws -> GitCaller.BranchResult
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func checkout<M1: Cuckoo.Matchable>(branch: M1) -> Cuckoo.__DoNotUse<(GitCaller.Branch), GitCaller.CheckoutResult> where M1.MatchedType == GitCaller.Branch {
            let matchers: [Cuckoo.ParameterMatcher<(GitCaller.Branch)>] = [wrap(matchable: branch) { $0 }]
            return cuckoo_manager.verify(
    """
    checkout(branch: GitCaller.Branch) async throws -> GitCaller.CheckoutResult
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func delete<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(branch: M1, force: M2) -> Cuckoo.__DoNotUse<(GitCaller.Branch, Bool), GitCaller.BranchResult> where M1.MatchedType == GitCaller.Branch, M2.MatchedType == Bool {
            let matchers: [Cuckoo.ParameterMatcher<(GitCaller.Branch, Bool)>] = [wrap(matchable: branch) { $0.0 }, wrap(matchable: force) { $0.1 }]
            return cuckoo_manager.verify(
    """
    delete(branch: GitCaller.Branch, force: Bool) async throws -> GitCaller.BranchResult
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func stage<M1: Cuckoo.OptionalMatchable>(file path: M1) -> Cuckoo.__DoNotUse<(String?), Void> where M1.OptionalMatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String?)>] = [wrap(matchable: path) { $0 }]
            return cuckoo_manager.verify(
    """
    stage(file: String?) async throws
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func unstage<M1: Cuckoo.Matchable>(file path: M1) -> Cuckoo.__DoNotUse<(String), RestoreResult> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: path) { $0 }]
            return cuckoo_manager.verify(
    """
    unstage(file: String) async throws -> RestoreResult
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func revert<M1: Cuckoo.Matchable>(unstagedFile path: M1) -> Cuckoo.__DoNotUse<(String), RestoreResult> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: path) { $0 }]
            return cuckoo_manager.verify(
    """
    revert(unstagedFile: String) async throws -> RestoreResult
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func revert<M1: Cuckoo.Matchable>(unstagedFiles paths: M1) -> Cuckoo.__DoNotUse<([String]), Void> where M1.MatchedType == [String] {
            let matchers: [Cuckoo.ParameterMatcher<([String])>] = [wrap(matchable: paths) { $0 }]
            return cuckoo_manager.verify(
    """
    revert(unstagedFiles: [String]) async throws
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func revertDeleted<M1: Cuckoo.Matchable>(unstagedFile path: M1) -> Cuckoo.__DoNotUse<(String), Void> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: path) { $0 }]
            return cuckoo_manager.verify(
    """
    revertDeleted(unstagedFile: String) async throws
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func commit<M1: Cuckoo.Matchable>(message: M1) -> Cuckoo.__DoNotUse<(String), Void> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: message) { $0 }]
            return cuckoo_manager.verify(
    """
    commit(message: String) async throws
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func fetch() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    fetch() async throws
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func pull<M1: Cuckoo.Matchable>(force: M1) -> Cuckoo.__DoNotUse<(Bool), PullResult> where M1.MatchedType == Bool {
            let matchers: [Cuckoo.ParameterMatcher<(Bool)>] = [wrap(matchable: force) { $0 }]
            return cuckoo_manager.verify(
    """
    pull(force: Bool) async throws -> PullResult
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func push<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.OptionalMatchable, M4: Cuckoo.OptionalMatchable>(force: M1, createUpstream: M2, remoteName: M3, newName: M4) -> Cuckoo.__DoNotUse<(Bool, Bool, String?, String?), PushResult> where M1.MatchedType == Bool, M2.MatchedType == Bool, M3.OptionalMatchedType == String, M4.OptionalMatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(Bool, Bool, String?, String?)>] = [wrap(matchable: force) { $0.0 }, wrap(matchable: createUpstream) { $0.1 }, wrap(matchable: remoteName) { $0.2 }, wrap(matchable: newName) { $0.3 }]
            return cuckoo_manager.verify(
    """
    push(force: Bool, createUpstream: Bool, remoteName: String?, newName: String?) async throws -> PushResult
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func newBranchAndCheckout<M1: Cuckoo.Matchable>(name: M1) -> Cuckoo.__DoNotUse<(String), CheckoutResult> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: name) { $0 }]
            return cuckoo_manager.verify(
    """
    newBranchAndCheckout(name: String) async throws -> CheckoutResult
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func diff<M1: Cuckoo.OptionalMatchable, M2: Cuckoo.Matchable, M3: Cuckoo.OptionalMatchable>(path: M1, staged: M2, rightPath: M3) -> Cuckoo.__DoNotUse<(String?, Bool, String?), DiffResult> where M1.OptionalMatchedType == String, M2.MatchedType == Bool, M3.OptionalMatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String?, Bool, String?)>] = [wrap(matchable: path) { $0.0 }, wrap(matchable: staged) { $0.1 }, wrap(matchable: rightPath) { $0.2 }]
            return cuckoo_manager.verify(
    """
    diff(path: String?, staged: Bool, rightPath: String?) async throws -> DiffResult
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func needsUpdate() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    needsUpdate()
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func merge<M1: Cuckoo.Matchable>(branch: M1) -> Cuckoo.__DoNotUse<(String), Void> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: branch) { $0 }]
            return cuckoo_manager.verify(
    """
    merge(branch: String) async throws
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func abortMerge() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    abortMerge() async throws
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func mergetool<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(file: M1, tool: M2) -> Cuckoo.__DoNotUse<(String, String), Void> where M1.MatchedType == String, M2.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: file) { $0.0 }, wrap(matchable: tool) { $0.1 }]
            return cuckoo_manager.verify(
    """
    mergetool(file: String, tool: String) async throws
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func useOurs<M1: Cuckoo.Matchable>(path: M1) -> Cuckoo.__DoNotUse<(String), Void> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: path) { $0 }]
            return cuckoo_manager.verify(
    """
    useOurs(path: String) async throws
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func useTheirs<M1: Cuckoo.Matchable>(path: M1) -> Cuckoo.__DoNotUse<(String), Void> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: path) { $0 }]
            return cuckoo_manager.verify(
    """
    useTheirs(path: String) async throws
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func getMergeCommitMessage() -> Cuckoo.__DoNotUse<(), String> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    getMergeCommitMessage() async throws -> String
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
    }
}


 class PreviewRepoStub: PreviewRepo {
    

    

    
    
    
    
     override func stage(files paths: [String]) async throws  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     override func unstage(files paths: [String]) async throws  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     override func rebase(onto branch: String) async throws  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     override func abortRebase() async throws  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     override func continueRebase() async throws  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     override func getRebaseCommitMessage() async throws -> String  {
        return DefaultValueRegistry.defaultValue(for: (String).self)
    }
    
    
    
    
    
     override func pushTags() async throws  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     override func deleteTag(name: String) async throws  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     override func getConfig(scope: GitCaller.ConfigScope, key: GitCaller.ConfigKey) async throws -> String  {
        return DefaultValueRegistry.defaultValue(for: (String).self)
    }
    
    
    
    
    
     override func setConfig(scope: GitCaller.ConfigScope, key: GitCaller.ConfigKey, value: String) async throws  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     override func unsetConfig(scope: GitCaller.ConfigScope, key: GitCaller.ConfigKey) async throws  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     override func continueMerge() async throws  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     override func clone(url: String) async throws -> GitCaller.CloneResult  {
        return DefaultValueRegistry.defaultValue(for: (GitCaller.CloneResult).self)
    }
    
    
    
    
    
     override func show(commitHash: String) async throws -> LogResult  {
        return DefaultValueRegistry.defaultValue(for: (LogResult).self)
    }
    
    
    
    
    
     override func getLog(branchNames: [String]) async throws -> GitCaller.LogResult  {
        return DefaultValueRegistry.defaultValue(for: (GitCaller.LogResult).self)
    }
    
    
    
    
    
     override func getLog(commitHash: String) async throws -> GitCaller.LogResult  {
        return DefaultValueRegistry.defaultValue(for: (GitCaller.LogResult).self)
    }
    
    
    
    
    
     override func getLog() async throws -> GitCaller.LogResult  {
        return DefaultValueRegistry.defaultValue(for: (GitCaller.LogResult).self)
    }
    
    
    
    
    
     override func getStatus() async throws -> GitCaller.StatusResult  {
        return DefaultValueRegistry.defaultValue(for: (GitCaller.StatusResult).self)
    }
    
    
    
    
    
     override func getBranches() async throws -> GitCaller.BranchResult  {
        return DefaultValueRegistry.defaultValue(for: (GitCaller.BranchResult).self)
    }
    
    
    
    
    
     override func checkout(branch: GitCaller.Branch) async throws -> GitCaller.CheckoutResult  {
        return DefaultValueRegistry.defaultValue(for: (GitCaller.CheckoutResult).self)
    }
    
    
    
    
    
     override func delete(branch: GitCaller.Branch, force: Bool) async throws -> GitCaller.BranchResult  {
        return DefaultValueRegistry.defaultValue(for: (GitCaller.BranchResult).self)
    }
    
    
    
    
    
     override func stage(file path: String?) async throws  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     override func unstage(file path: String) async throws -> RestoreResult  {
        return DefaultValueRegistry.defaultValue(for: (RestoreResult).self)
    }
    
    
    
    
    
     override func revert(unstagedFile path: String) async throws -> RestoreResult  {
        return DefaultValueRegistry.defaultValue(for: (RestoreResult).self)
    }
    
    
    
    
    
     override func revert(unstagedFiles paths: [String]) async throws  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     override func revertDeleted(unstagedFile path: String) async throws  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     override func commit(message: String) async throws  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     override func fetch() async throws  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     override func pull(force: Bool) async throws -> PullResult  {
        return DefaultValueRegistry.defaultValue(for: (PullResult).self)
    }
    
    
    
    
    
    public override func push(force: Bool, createUpstream: Bool, remoteName: String?, newName: String?) async throws -> PushResult  {
        return DefaultValueRegistry.defaultValue(for: (PushResult).self)
    }
    
    
    
    
    
     override func newBranchAndCheckout(name: String) async throws -> CheckoutResult  {
        return DefaultValueRegistry.defaultValue(for: (CheckoutResult).self)
    }
    
    
    
    
    
     override func diff(path: String?, staged: Bool, rightPath: String?) async throws -> DiffResult  {
        return DefaultValueRegistry.defaultValue(for: (DiffResult).self)
    }
    
    
    
    
    
     override func needsUpdate()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     override func merge(branch: String) async throws  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     override func abortMerge() async throws  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     override func mergetool(file: String, tool: String) async throws  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     override func useOurs(path: String) async throws  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     override func useTheirs(path: String) async throws  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     override func getMergeCommitMessage() async throws -> String  {
        return DefaultValueRegistry.defaultValue(for: (String).self)
    }
    
    
}





// MARK: - Mocks generated from file: JaguTests/Generalizations/FileManager.swift at 2023-02-16 10:38:31 +0000

//
//  FileManagerProtocol.swift
//  Jagu
//
//  Created by Artur Hellmann on 08.02.23.
//

import Cuckoo
@testable import Jagu

import Foundation






 class MockFileManagerSC: FileManagerSC, Cuckoo.ClassMock {
    
     typealias MocksType = FileManagerSC
    
     typealias Stubbing = __StubbingProxy_FileManagerSC
     typealias Verification = __VerificationProxy_FileManagerSC

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: FileManagerSC?

     func enableDefaultImplementation(_ stub: FileManagerSC) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    
     override func removeItem(atPath path: String) throws {
        
    return try cuckoo_manager.callThrows(
    """
    removeItem(atPath: String) throws
    """,
            parameters: (path),
            escapingParameters: (path),
            superclassCall:
                
                super.removeItem(atPath: path)
                ,
            defaultCall: __defaultImplStub!.removeItem(atPath: path))
        
    }
    
    

     struct __StubbingProxy_FileManagerSC: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
         init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        
        
        func removeItem<M1: Cuckoo.Matchable>(atPath path: M1) -> Cuckoo.ClassStubNoReturnThrowingFunction<(String)> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: path) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockFileManagerSC.self, method:
    """
    removeItem(atPath: String) throws
    """, parameterMatchers: matchers))
        }
        
        
    }

     struct __VerificationProxy_FileManagerSC: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
         init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
    
        
    
        
        
        
        @discardableResult
        func removeItem<M1: Cuckoo.Matchable>(atPath path: M1) -> Cuckoo.__DoNotUse<(String), Void> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: path) { $0 }]
            return cuckoo_manager.verify(
    """
    removeItem(atPath: String) throws
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
    }
}


 class FileManagerSCStub: FileManagerSC {
    

    

    
    
    
    
     override func removeItem(atPath path: String) throws  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
}





// MARK: - Mocks generated from file: JaguTests/Generalizations/UserDefaults.swift at 2023-02-16 10:38:31 +0000

//
//  UserDefaults.swift
//  JaguTests
//
//  Created by Artur Hellmann on 08.02.23.
//

import Cuckoo
@testable import Jagu

import Foundation






 class MockUserDefaultsSC: UserDefaultsSC, Cuckoo.ClassMock {
    
     typealias MocksType = UserDefaultsSC
    
     typealias Stubbing = __StubbingProxy_UserDefaultsSC
     typealias Verification = __VerificationProxy_UserDefaultsSC

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: UserDefaultsSC?

     func enableDefaultImplementation(_ stub: UserDefaultsSC) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    
     override func stringArray(forKey defaultName: String) -> [String]? {
        
    return cuckoo_manager.call(
    """
    stringArray(forKey: String) -> [String]?
    """,
            parameters: (defaultName),
            escapingParameters: (defaultName),
            superclassCall:
                
                super.stringArray(forKey: defaultName)
                ,
            defaultCall: __defaultImplStub!.stringArray(forKey: defaultName))
        
    }
    
    
    
    
    
     override func set(_ value: Any?, forKey defaultName: String)  {
        
    return cuckoo_manager.call(
    """
    set(_: Any?, forKey: String)
    """,
            parameters: (value, defaultName),
            escapingParameters: (value, defaultName),
            superclassCall:
                
                super.set(value, forKey: defaultName)
                ,
            defaultCall: __defaultImplStub!.set(value, forKey: defaultName))
        
    }
    
    
    
    
    
     override func synchronize() -> Bool {
        
    return cuckoo_manager.call(
    """
    synchronize() -> Bool
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.synchronize()
                ,
            defaultCall: __defaultImplStub!.synchronize())
        
    }
    
    

     struct __StubbingProxy_UserDefaultsSC: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
         init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        
        
        func stringArray<M1: Cuckoo.Matchable>(forKey defaultName: M1) -> Cuckoo.ClassStubFunction<(String), [String]?> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: defaultName) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockUserDefaultsSC.self, method:
    """
    stringArray(forKey: String) -> [String]?
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func set<M1: Cuckoo.OptionalMatchable, M2: Cuckoo.Matchable>(_ value: M1, forKey defaultName: M2) -> Cuckoo.ClassStubNoReturnFunction<(Any?, String)> where M1.OptionalMatchedType == Any, M2.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(Any?, String)>] = [wrap(matchable: value) { $0.0 }, wrap(matchable: defaultName) { $0.1 }]
            return .init(stub: cuckoo_manager.createStub(for: MockUserDefaultsSC.self, method:
    """
    set(_: Any?, forKey: String)
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func synchronize() -> Cuckoo.ClassStubFunction<(), Bool> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockUserDefaultsSC.self, method:
    """
    synchronize() -> Bool
    """, parameterMatchers: matchers))
        }
        
        
    }

     struct __VerificationProxy_UserDefaultsSC: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
         init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
    
        
    
        
        
        
        @discardableResult
        func stringArray<M1: Cuckoo.Matchable>(forKey defaultName: M1) -> Cuckoo.__DoNotUse<(String), [String]?> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: defaultName) { $0 }]
            return cuckoo_manager.verify(
    """
    stringArray(forKey: String) -> [String]?
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func set<M1: Cuckoo.OptionalMatchable, M2: Cuckoo.Matchable>(_ value: M1, forKey defaultName: M2) -> Cuckoo.__DoNotUse<(Any?, String), Void> where M1.OptionalMatchedType == Any, M2.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(Any?, String)>] = [wrap(matchable: value) { $0.0 }, wrap(matchable: defaultName) { $0.1 }]
            return cuckoo_manager.verify(
    """
    set(_: Any?, forKey: String)
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func synchronize() -> Cuckoo.__DoNotUse<(), Bool> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    synchronize() -> Bool
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
    }
}


 class UserDefaultsSCStub: UserDefaultsSC {
    

    

    
    
    
    
     override func stringArray(forKey defaultName: String) -> [String]?  {
        return DefaultValueRegistry.defaultValue(for: ([String]?).self)
    }
    
    
    
    
    
     override func set(_ value: Any?, forKey defaultName: String)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     override func synchronize() -> Bool  {
        return DefaultValueRegistry.defaultValue(for: (Bool).self)
    }
    
    
}




