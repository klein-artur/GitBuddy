//
//  FileServiceTests.swift
//  JaguTests
//
//  Created by Artur Hellmann on 08.02.23.
//

@testable import Jagu

import XCTest
import Cuckoo
import GitCaller

final class FileServiceTests: XCTestCase {
    var sut: FileService!
    
    let mockFileManager = MockFileManagerSC()
    let mockRepository = MockPreviewRepo()

    override func setUpWithError() throws {
        self.sut = FileService(fileManager: mockFileManager, repository: mockRepository)
        
        stub(mockFileManager) {
            when($0).removeItem(atPath: anyString()).thenDoNothing()
        }
        
        stub(mockRepository) {
            when($0).needsUpdate().thenDoNothing()
        }
    }

    override func tearDownWithError() throws {
        self.sut = nil
    }

    func testDeletion() throws {
        // when
        try sut.delete(file: "test/file.txt")
        
        // then
        verify(mockFileManager).removeItem(atPath: "test/file.txt")
        verify(mockRepository).needsUpdate()
    }

}
