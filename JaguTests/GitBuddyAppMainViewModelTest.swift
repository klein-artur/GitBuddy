//
//  JaguAppMainViewModelTest.swift
//  JaguTests
//
//  Created by Artur Hellmann on 30.12.22.
//

@testable import Jagu

import XCTest
import Combine

final class JaguAppMainViewModelTest: XCTestCase {
    
    var sut: JaguAppMainViewModel!
    
    let repoPublisher: CurrentValueSubject<String?, Never> = CurrentValueSubject(nil)

    override func setUpWithError() throws {
        sut = JaguAppMainViewModel()
        sut.repoPathPublisher = repoPublisher
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testNameIsSetToNilOnStartup() {
        XCTAssertNil(sut.repoName)
    }
    
    func testNameWillBeSomeValueAfterPathPushed() {
        repoPublisher.send("some/path/to send")
        
        XCTAssertEqual(sut.repoName, "to send")
    }
}
