//
//  GitBuddyAppMainViewModelTest.swift
//  GitBuddyTests
//
//  Created by Artur Hellmann on 30.12.22.
//

@testable import GitBuddy

import XCTest
import Combine

final class GitBuddyAppMainViewModelTest: XCTestCase {
    
    var sut: GitBuddyAppMainViewModel!
    
    let repoPublisher: CurrentValueSubject<String?, Never> = CurrentValueSubject(nil)

    override func setUpWithError() throws {
        sut = GitBuddyAppMainViewModel()
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
