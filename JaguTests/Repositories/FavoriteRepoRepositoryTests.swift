//
//  FavoriteRepoRepositoryTests.swift
//  JaguTests
//
//  Created by Artur Hellmann on 08.02.23.
//
@testable import Jagu

import XCTest
import Cuckoo

final class FavoriteRepoRepositoryTests: XCTestCase {
    var sut: LocalFavoriteRepoRepository!
    
    let mockUserDefaults = MockUserDefaultsSC()

    override func setUpWithError() throws {
        self.sut = LocalFavoriteRepoRepository(userDefaults: mockUserDefaults)
    }

    override func tearDownWithError() throws {
        self.sut = nil
    }

    func testSetAsFavoriteNotExistentYet() throws {
        // given
        stub(mockUserDefaults) {
            when($0).stringArray(forKey: anyString()).thenReturn([])
            when($0).set(any(), forKey: LocalFavoriteRepoRepository.defaultsKey).thenDoNothing()
            when($0).synchronize().thenReturn(true)
        }
        let newPath = "test/path"
        
        // when
        self.sut.setAsFavorite(path: newPath)
        
        // then
        verify(mockUserDefaults).stringArray(forKey: LocalFavoriteRepoRepository.defaultsKey)
        verify(mockUserDefaults).set(ParameterMatcher<Any?> { input in
            guard let input = input as? [String] else {
                return false
            }
            return input.isEmpty != true && input.first == "test/path"
        }, forKey: LocalFavoriteRepoRepository.defaultsKey)
        verify(mockUserDefaults).synchronize()
    }
    
    func testSetAsFavoriteExistent() throws {
        // given
        let newPath = "test/path"
        stub(mockUserDefaults) {
            when($0).stringArray(forKey: anyString()).thenReturn([newPath])
            when($0).set(any(), forKey: LocalFavoriteRepoRepository.defaultsKey).thenDoNothing()
            when($0).synchronize().thenReturn(true)
        }
        
        // when
        self.sut.setAsFavorite(path: newPath)
        
        // then
        verify(mockUserDefaults).stringArray(forKey: LocalFavoriteRepoRepository.defaultsKey)
        verify(mockUserDefaults).set(ParameterMatcher<Any?> { input in
            guard let input = input as? [String] else {
                return false
            }
            return input.count == 1
        }, forKey: LocalFavoriteRepoRepository.defaultsKey)
        verify(mockUserDefaults).synchronize()
    }
    
    func testGetPaths() throws {
        // given
        let newPath = "test/path"
        stub(mockUserDefaults) {
            when($0).stringArray(forKey: anyString()).thenReturn([newPath])
        }
        
        // when
        let result = self.sut.getFavorites()
        
        // then
        verify(mockUserDefaults).stringArray(forKey: LocalFavoriteRepoRepository.defaultsKey)
        XCTAssertEqual(result, [newPath])
    }
}
