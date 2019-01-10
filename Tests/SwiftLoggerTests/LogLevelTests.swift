//
//  LogLevelTests.swift
//  Swift-Logger
//
//  Created by Luke Davis on 3/18/17.
//  Copyright © 2017 Lucky 13 Technologies, LLC. All rights reserved.
//

@testable import SwiftLogger
import XCTest

class LogLevelTests: XCTestCase {

    var allLogValues: [LogLevel] = [.verbose, .debug, .info, .warn, .error, .fatal, .off]

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testLogLevel_comparableDebug() {
        let actual = LogLevel.debug
        let debug = LogLevel.debug
        XCTAssertGreaterThanOrEqual(debug, actual)
        let info = LogLevel.info
        XCTAssertGreaterThan(info, actual)
        let warn = LogLevel.warn
        XCTAssertGreaterThan(warn, actual)
        let error = LogLevel.error
        XCTAssertGreaterThan(error, actual)
        let fatal = LogLevel.fatal
        XCTAssertGreaterThan(fatal, actual)
    }

    func testLogLevel_comparableInfo() {
        let actual = LogLevel.info
        let debug = LogLevel.debug
        XCTAssertLessThan(debug, actual)
        let info = LogLevel.info
        XCTAssertGreaterThanOrEqual(info, actual)
        let warn = LogLevel.warn
        XCTAssertGreaterThan(warn, actual)
        let error = LogLevel.error
        XCTAssertGreaterThan(error, actual)
        let fatal = LogLevel.fatal
        XCTAssertGreaterThan(fatal, actual)
    }

    func testLogLevel_comparableWarn() {
        let actual = LogLevel.warn
        let debug = LogLevel.debug
        XCTAssertLessThan(debug, actual)
        let info = LogLevel.info
        XCTAssertLessThan(info, actual)
        let warn = LogLevel.warn
        XCTAssertGreaterThanOrEqual(warn, actual)
        let error = LogLevel.error
        XCTAssertGreaterThan(error, actual)
        let fatal = LogLevel.fatal
        XCTAssertGreaterThan(fatal, actual)
    }

    func testLogLevel_comparableError() {
        let actual = LogLevel.error
        let debug = LogLevel.debug
        XCTAssertLessThan(debug, actual)
        let info = LogLevel.info
        XCTAssertLessThan(info, actual)
        let warn = LogLevel.warn
        XCTAssertLessThan(warn, actual)
        let error = LogLevel.error
        XCTAssertGreaterThanOrEqual(error, actual)
        let fatal = LogLevel.fatal
        XCTAssertGreaterThan(fatal, actual)
    }

    func testLogLevel_comparableFatal() {
        let actual = LogLevel.fatal
        let debug = LogLevel.debug
        XCTAssertLessThan(debug, actual)
        let info = LogLevel.info
        XCTAssertLessThan(info, actual)
        let warn = LogLevel.warn
        XCTAssertLessThan(warn, actual)
        let error = LogLevel.error
        XCTAssertLessThan(error, actual)
        let fatal = LogLevel.fatal
        XCTAssertLessThanOrEqual(fatal, actual)
    }

    func testLogLevel_description() {
        for level in allLogValues {
            if level != .off {
                XCTAssertFalse(level.description.isEmpty)
            } else {
                XCTAssertTrue(level.description.isEmpty)
            }
        }
    }

}
