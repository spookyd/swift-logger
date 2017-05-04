//
//  AppenderTests.swift
//  Swift-Logger
//
//  Created by Luke Davis on 3/18/17.
//
//

import XCTest
@testable import SwiftLogger

class AppenderTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExecuteLog() {
        let appender = MockAppender()
        appender.log(.debug, UUID().uuidString, nil)
    }

    func testAppenders_utilizeFormatters() {
        let formatter = MockFormatter()
        let appender = MockAppender()
        appender.formatter = formatter
        XCTAssertNotNil(appender.formatter)
        let expected = UUID().uuidString
        appender.log(.info, expected, nil)
        let actual = formatter.sentMessage
        XCTAssertEqual(expected, actual)
    }

}
