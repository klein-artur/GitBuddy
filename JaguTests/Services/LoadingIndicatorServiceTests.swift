//
//  LoadingIndicatorServiceTests.swift
//  JaguTests
//
//  Created by Artur Hellmann on 14.02.23.
//
@testable import Jagu

import XCTest

final class LoadingIndicatorServiceTests: XCTestCase {
    var sut: LoadingIndicatorService!

    override func setUpWithError() throws {
        sut = LoadingIndicatorService()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testShouldEmitTrueAfter500ms() {
        // when
        let currentTime = Date.now.timeIntervalSince1970 * 1000
        _ = sut.setLoading(text: "")
        
        var isFirst = true
        
        // then
        let expectation = expectation(description: "should emit")
        let subscription = sut.$isLoading
            .sink { loading in
                if isFirst {
                    isFirst.toggle()
                } else {
                    XCTAssertTrue(loading)
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 1)
        XCTAssertTrue(sut.currentTexts.isEmpty)
        XCTAssertGreaterThan((Date.now.timeIntervalSince1970 * 1000) - currentTime, 500)
    }
    
    func testShouldEmitFalse() {
        // when
        let uuid = sut.setLoading(text: "")
        sut.stopLoading(uuid: uuid)
        
        // then
        let expectation = expectation(description: "should emit")
        let subscription = sut.$isLoading
            .sink { loading in
                XCTAssertFalse(loading)
                expectation.fulfill()
            }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testShouldNotEmitFalse() {
        // when
        let uuid = sut.setLoading(text: "")
        sut.stopLoading(uuid: UUID())
        
        var isFirst = true
        
        // then
        let expectation = expectation(description: "should emit")
        let subscription = sut.$isLoading
            .sink { loading in
                if isFirst {
                    isFirst.toggle()
                } else {
                    XCTAssertTrue(loading)
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testShouldEmitTrueAsNotEnoughStopped() {
        // when
        let firstUUID = sut.setLoading(text: "first")
        let secondUUID = sut.setLoading(text: "second")
        sut.stopLoading(uuid: firstUUID)
        
        // then
        let expectation = expectation(description: "should emit")
        let subscription = sut.$isLoading
            .sink { loading in
                XCTAssertTrue(loading)
                expectation.fulfill()
            }
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(sut.currentTexts.first, "second")
        
    }
}
