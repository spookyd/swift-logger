//
//  LoggerIntegrationTests.swift
//  LoggerIntegrationTests
//
//  Created by Luke Davis on 4/8/17.
//
//

import XCTest
@testable import SwiftLogger

class LoggerIntegrationTests: XCTestCase {
    
    var factory: LoggerFactory!
    var logger: Logger!
    var appender: CollectionAppender!
    
    override func setUp() {
        super.setUp()
        appender = CollectionAppender()
        var config = Configuration()
        config.add(appender: appender)
        factory = LoggerFactory()
        factory.set(configuration: config)
        logger = factory.getLogger(UUID().uuidString)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMinimumLogger_debug() {
        let expected = UUID().uuidString
        logger.debug(expected)
        let actual = appender.collectedLogStrings
        XCTAssertEqual(1, actual.count)
        XCTAssertEqual(expected, actual.first?.1)
        XCTAssertEqual(LogLevel.debug, actual.first?.0)
    }
    
    func testMultipleAppenders() {
        let secondAppender = CollectionAppender()
        factory.appenders = ["1": self.appender, "2": secondAppender]
        logger.debug(UUID().uuidString)
        XCTAssertEqual(1, appender.collectedLogStrings.count)
        XCTAssertEqual(1, secondAppender.collectedLogStrings.count)
    }
    
    /// Validates functionality when using logger through the factory
    func testMultipleLoggers_managed_withDifferentLevel() {
        let secondAppender = CollectionAppender()
        factory.appenders = ["1": self.appender, "2": secondAppender]
        logger.debug(UUID().uuidString)
        let logger2 = factory.getLogger(UUID().uuidString)
        logger.logLevel = .debug
        logger2.logLevel = .error
        XCTAssertEqual(1, appender.collectedLogStrings.count)
        XCTAssertEqual(1, secondAppender.collectedLogStrings.count)
        logger2.error(UUID().uuidString, error: nil)
        XCTAssertEqual(2, appender.collectedLogStrings.count)
        XCTAssertEqual(2, secondAppender.collectedLogStrings.count)
    }
    
    /// Exercises the different ways loggers and appenders interact
    func testMultipleLoggers_withDifferentAppenders() {
        // Test each logger has their own appender
        let debugLogger = factory.getLogger("com.lucky.debug.logger")
        debugLogger.logLevel = .debug
        // Use default appender
        let errorLogger = factory.getLogger("com.lucky.error.logger")
        errorLogger.logLevel = .error
        let someOtherAppender = CollectionAppender(identifier: "com.lucky.error.appender")
        errorLogger.appenders = [someOtherAppender]
        debugLogger.debug(UUID().uuidString)
        XCTAssertEqual(1, appender.collectedLogStrings.count)
        XCTAssertEqual(0, someOtherAppender.collectedLogStrings.count)
        errorLogger.error(UUID().uuidString, error: nil)
        XCTAssertEqual(1, appender.collectedLogStrings.count)
        XCTAssertEqual(1, someOtherAppender.collectedLogStrings.count)
    }
    
    
}

class CollectionAppender: Appender {
    
    var collectedLogStrings: [(LogLevel, String)] = []
    
    var identifier: String
    
    var formatter: SwiftLogger.Formatter? = nil
    
    required init(identifier: String = UUID().uuidString) {
        self.identifier = identifier
    }
    
    func sendLog(_ level: LogLevel, _ output: String) {
        collectedLogStrings.append((level, output))
    }
    
}
