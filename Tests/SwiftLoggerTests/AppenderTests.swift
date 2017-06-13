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
        let expectedLevel: LogLevel = .debug
        let expectedMessage = UUID().uuidString
        appender.log(expectedLevel, expectedMessage, nil)
        XCTAssertEqual(expectedLevel, appender.level)
        XCTAssertEqual(expectedMessage, appender.output)
    }
    
    func testExecuteLog_lowerLogLevel() {
        let appender = MockAppender()
        appender.loglevel = .error
        let expectedLevel: LogLevel = .debug
        let expectedMessage = UUID().uuidString
        appender.log(expectedLevel, expectedMessage, nil)
        XCTAssertNotEqual(expectedLevel, appender.level)
        XCTAssertNotEqual(expectedMessage, appender.output)
        XCTAssertNil(appender.level)
        XCTAssertNil(appender.output)
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
