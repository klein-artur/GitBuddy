//
//  FavoriteRepoServiceTests.swift
//  JaguTests
//
//  Created by Artur Hellmann on 08.02.23.
//

@testable import Jagu

import XCTest
import Cuckoo

final class FavoriteRepoServiceTests: XCTestCase {
    var sut: FavoriteRepoService!
    
    let mockFavoriteRepoRepository = MockFavoriteRepoRepository()

    override func setUpWithError() throws {
        self.sut = FavoriteRepoService(repoRepository: mockFavoriteRepoRepository)
        
        stub(mockFavoriteRepoRepository) { stub in
            when(stub).getFavorites().thenReturn(["test/one", "test/two"])
            when(stub).setAsFavorite(path: anyString()).thenDoNothing()
        }
    }

    override func tearDownWithError() throws {
        self.sut = nil
    }
    
    func testGetsTwoFavorites() {
        // when
        let result = sut.favorites
        
        // then
        verify(mockFavoriteRepoRepository).getFavorites()
        XCTAssertEqual(result, wantesFavorites)
    }
    
    func testSaveFavorites() {
        // when
        sut.saveFavorite(path: "some/path")
        
        // then
        verify(mockFavoriteRepoRepository).setAsFavorite(path: "some/path")
    }

}

let wantesFavorites = [
    RepoFavorite(path: "test/one"),
    RepoFavorite(path: "test/two")
]

extension RepoFavorite: Equatable {
    public static func == (lhs: RepoFavorite, rhs: RepoFavorite) -> Bool {
        lhs.path == rhs.path
    }
}
