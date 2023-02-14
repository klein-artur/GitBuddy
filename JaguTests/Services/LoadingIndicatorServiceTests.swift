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

    func testShouldEmitTrue() {
        // when
        sut.setLoading()
        
        // then
        let expectation = expectation(description: "should emit")
        let subscription = sut.$isLoading
            .sink { loading in
                XCTAssertTrue(loading)
                expectation.fulfill()
            }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testShouldEmitFalse() {
        // when
        sut.setLoading()
        sut.stopLoading()
        
        // then
        let expectation = expectation(description: "should emit")
        let subscription = sut.$isLoading
            .sink { loading in
                XCTAssertFalse(loading)
                expectation.fulfill()
            }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testShouldEmitTrueAsNotEnoughStopped() {
        // when
        sut.setLoading()
        sut.setLoading()
        sut.stopLoading()
        
        // then
        let expectation = expectation(description: "should emit")
        let subscription = sut.$isLoading
            .sink { loading in
                XCTAssertTrue(loading)
                expectation.fulfill()
            }
        
        wait(for: [expectation], timeout: 1)
    }
}
