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
    
    func testDummy() {
        XCTAssert(true)
    }
}
