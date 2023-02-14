//
//  PasteboardServiceTests.swift
//  JaguTests
//
//  Created by Artur Hellmann on 13.02.23.
//
@testable import Jagu

import XCTest
import SwiftDose
import Cuckoo

final class PasteboardServiceTests: XCTestCase {
    
    var sut: PasteboardService!
    
    let mockPasteboard = MockClipboard()

    override func setUpWithError() throws {
        DoseValues[PasteboardProvider.self] = mockPasteboard
        sut = PasteboardService()
        
        stub(mockPasteboard) { stub in
            when(stub.declareTypes(any(), owner: any())).thenReturn(0)
            when(stub.setString(any(), forType: any())).thenReturn(true)
        }
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testCopyString() {
        // when
        let result = sut.copy(string: "test")
        
        // then
        XCTAssertTrue(result)
        verify(mockPasteboard).declareTypes(equal(to: [.string]), owner: ParameterMatcher<Any?> { (item: Any?) in
            return item == nil
        })
        verify(mockPasteboard).setString("test", forType: equal(to: .string))
    }

}
