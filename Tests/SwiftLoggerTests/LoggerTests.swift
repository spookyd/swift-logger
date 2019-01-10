//
//  LoggerTests.swift
//  Swift-Logger
//
//  Created by Luke Davis on 4/8/17.
//  Copyright © 2017 Lucky 13 Technologies, LLC. All rights reserved.
//

@testable import SwiftLogger
import XCTest

class LoggerTests: XCTestCase { // swiftlint:disable:this type_body_length

    func testCreateLogger() {
        let expected = UUID().uuidString
        let logger = Logger(named: expected)
        XCTAssertEqual(expected, logger.identifier)
    }

    func testDebug() {
        let expected = UUID().uuidString
        let level = LogLevel.debug
        let logger = Logger(named: "")
        let appender = MockAppender()
        logger.appenders = [appender]
        logger.logLevel = level
        logger.debug(expected)
        XCTAssertEqual(expected, appender.output)
        XCTAssertEqual(level, appender.level!)
    }

    func testInfo() {
        let expected = UUID().uuidString
        let level = LogLevel.info
        let logger = Logger(named: "")
        let appender = MockAppender()
        logger.appenders = [appender]
        logger.logLevel = level
        logger.info(expected)
        XCTAssertEqual(expected, appender.output)
        XCTAssertEqual(level, appender.level!)
    }

    func testWarn() {
        let expected = UUID().uuidString
        let level = LogLevel.warn
        let logger = Logger(named: "")
        let appender = MockAppender()
        logger.appenders = [appender]
        logger.logLevel = level
        logger.warn(expected)
        XCTAssertEqual(expected, appender.output)
        XCTAssertEqual(level, appender.level!)
    }

    func testError() {
        let expected = UUID().uuidString
        let level = LogLevel.error
        let logger = Logger(named: "")
        let appender = MockAppender()
        logger.appenders = [appender]
        logger.logLevel = level
        logger.error(expected, error: nil)
        XCTAssertEqual(expected, appender.output)
        XCTAssertEqual(level, appender.level!)
    }

    func testFatal() {
        let expected = UUID().uuidString
        let level = LogLevel.fatal
        let logger = Logger(named: "")
        let appender = MockAppender()
        logger.appenders = [appender]
        logger.logLevel = level
        logger.fatal(expected, error: nil)
        XCTAssertEqual(expected, appender.output)
        XCTAssertEqual(level, appender.level!)
    }

    func testAppender_output() {
        let expected = UUID().uuidString
        let logger = Logger(named: "")
        let appender = MockAppender()
        logger.appenders = [appender]
        logger.log(.debug, expected)
        XCTAssertEqual(expected, appender.output)
    }

    func testLog_FiltersFatal() {
        // Only Fatals should make it through
        let expected = UUID().uuidString
        let logger = Logger(named: "")
        logger.logLevel = .fatal
        let appender = MockAppender()
        logger.appenders = [appender]
        logger.log(.debug, expected)
        XCTAssertNil(appender.output)
        logger.log(.info, expected)
        XCTAssertNil(appender.output)
        logger.log(.warn, expected)
        XCTAssertNil(appender.output)
        logger.log(.error, expected)
        XCTAssertNil(appender.output)
        logger.log(.fatal, expected)
        XCTAssertEqual(expected, appender.output)
    }

    func testLog_FiltersError() {
        // Only Fatals and Errors should make it through
        let expected = UUID().uuidString
        let logger = Logger(named: "")
        logger.logLevel = .error
        let appender = MockAppender()
        logger.appenders = [appender]
        logger.log(.debug, expected)
        XCTAssertNil(appender.output)
        logger.log(.info, expected)
        XCTAssertNil(appender.output)
        logger.log(.warn, expected)
        XCTAssertNil(appender.output)
        logger.log(.error, expected)
        XCTAssertEqual(expected, appender.output)
        logger.log(.fatal, expected)
        XCTAssertEqual(expected, appender.output)
    }

    func testLog_FiltersWarn() {
        // Only Fatals, Errors, and Warnings should make it through
        let expected = UUID().uuidString
        let logger = Logger(named: "")
        logger.logLevel = .warn
        let appender = MockAppender()
        logger.appenders = [appender]
        logger.log(.debug, expected)
        XCTAssertNil(appender.output)
        logger.log(.info, expected)
        XCTAssertNil(appender.output)
        logger.log(.warn, expected)
        XCTAssertEqual(expected, appender.output)
        logger.log(.error, expected)
        XCTAssertEqual(expected, appender.output)
        logger.log(.fatal, expected)
        XCTAssertEqual(expected, appender.output)
    }

    func testLog_FiltersInfo() {
        // Only Fatals, Errors, Warnings, and Info should make it through
        let expected = UUID().uuidString
        let logger = Logger(named: "")
        logger.logLevel = .info
        let appender = MockAppender()
        logger.appenders = [appender]
        logger.log(.debug, expected)
        XCTAssertNil(appender.output)
        logger.log(.info, expected)
        XCTAssertEqual(expected, appender.output)
        logger.log(.warn, expected)
        XCTAssertEqual(expected, appender.output)
        logger.log(.error, expected)
        XCTAssertEqual(expected, appender.output)
        logger.log(.fatal, expected)
        XCTAssertEqual(expected, appender.output)
    }

    func testLog_FiltersDebug() {
        // All levels should make it through
        let expected = UUID().uuidString
        let logger = Logger(named: "")
        logger.logLevel = .debug
        let appender = MockAppender()
        logger.appenders = [appender]
        logger.log(.debug, expected)
        XCTAssertEqual(expected, appender.output)
        logger.log(.info, expected)
        XCTAssertEqual(expected, appender.output)
        logger.log(.warn, expected)
        XCTAssertEqual(expected, appender.output)
        logger.log(.error, expected)
        XCTAssertEqual(expected, appender.output)
        logger.log(.fatal, expected)
        XCTAssertEqual(expected, appender.output)
    }

    // MARK: -
    // MARK: Logging Details
    func testLog_sendsLoggingInfoToFormatter() {
        let expected = UUID().uuidString
        let expectedFile = UUID().uuidString
        let expectedLine = Int(arc4random())
        let expectedFunction = UUID().uuidString
        let expectedLevel = LogLevel.debug.description
        let logger = Logger(named: "")
        let appender = MockAppender()
        let formatter = MockFormatter()
        appender.formatter = formatter
        logger.appenders = [appender]
        logger.log(.debug, expected, expectedFile, expectedLine, expectedFunction)
        XCTAssertNotNil(formatter.additionalInfo)
        let info = formatter.additionalInfo!
        let actualDate = info[LoggingInfoKey.date]
        XCTAssertNotNil(actualDate)
        let actualFile = info[LoggingInfoKey.file]
        XCTAssertEqual(expectedFile, actualFile as! String) // swiftlint:disable:this force_cast
        let actualLine = info[LoggingInfoKey.line]
        XCTAssertEqual(expectedLine, actualLine as! Int) // swiftlint:disable:this force_cast
        let actualFunction = info[LoggingInfoKey.function]
        XCTAssertEqual(expectedFunction, actualFunction as! String) // swiftlint:disable:this force_cast
        let actualLevel = info[LoggingInfoKey.level]
        XCTAssertEqual(expectedLevel, actualLevel as! String) // swiftlint:disable:this force_cast
    }

    func testLog_sendsLoggingInfoToFormatter_missingData() {
        let expected = UUID().uuidString
        let expectedLevel = LogLevel.debug.description
        let logger = Logger(named: "")
        let appender = MockAppender()
        let formatter = MockFormatter()
        appender.formatter = formatter
        logger.appenders = [appender]
        logger.log(.debug, expected)
        XCTAssertNotNil(formatter.additionalInfo)
        let info = formatter.additionalInfo!
        let actualDate = info[LoggingInfoKey.date]
        XCTAssertNotNil(actualDate)
        let actualFile = info[LoggingInfoKey.file]
        XCTAssertNil(actualFile)
        let actualLine = info[LoggingInfoKey.line]
        XCTAssertNil(actualLine)
        let actualFunction = info[LoggingInfoKey.function]
        XCTAssertNil(actualFunction)
        let actualLevel = info[LoggingInfoKey.level]
        XCTAssertEqual(expectedLevel, actualLevel as! String) // swiftlint:disable:this force_cast
    }

    func testThreadName() {
        let expected = UUID().uuidString
        Thread.current.name = expected
        let logger = Logger(named: "")
        let actual = logger.threadName
        XCTAssertEqual(expected, actual)
    }

    func testExecutionQueue_Default() {
        let logger = Logger(named: "")
        let queue = logger.queue
        XCTAssertFalse(queue.label.isEmpty)
    }

    func testExecution_CustomQueue() {
        let expectation = self.expectation(description: "Async threaded execution")
        let appender = MockFulfillmentAppender()
        appender.expectation = expectation
        let label = UUID().uuidString
        let logger = Logger(named: "")
        logger.appenders.append(appender)
        logger.queue = DispatchQueue(label: label)
        logger.isAsync = true
        logger.debug(UUID().uuidString)
        XCTAssertTrue(Thread.current.isMainThread)
        waitForExpectations(timeout: 1) { (_) in
            XCTAssertNotNil(appender.executedOnMainThread)
            XCTAssertFalse(appender.executedOnMainThread!)
        }
    }

}

class MockAppender: Appender {

    var output: String?
    var level: LogLevel?

    var loglevel: LogLevel = .verbose

    var formatter: SwiftLogger.Formatter?

    var identifier: String

    convenience init() {
        self.init(identifier: UUID().uuidString)
    }

    required init(identifier: String) {
        self.identifier = identifier
    }

    func sendLog(_ level: LogLevel, _ output: String) {
        self.level = level
        self.output = output
    }

}

class MockFulfillmentAppender: Appender {

    var expectation: XCTestExpectation?
    var executedOnMainThread: Bool?

    var loglevel: LogLevel = .verbose

    var formatter: SwiftLogger.Formatter?

    var identifier: String

    convenience init() {
        self.init(identifier: UUID().uuidString)
    }

    required init(identifier: String) {
        self.identifier = identifier
    }

    func sendLog(_ level: LogLevel, _ output: String) {
        executedOnMainThread = Thread.current.isMainThread
        expectation?.fulfill()
    }

}
