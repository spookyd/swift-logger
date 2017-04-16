//
//  LoggerFactoryTests.swift
//  Swift-Logger
//
//  Created by Luke Davis on 3/19/17.
//
//

import XCTest
@testable import SwiftLogger

class LoggerFactoryTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetLogger() {
        let expected = UUID().uuidString
        let factory = LoggerFactory()
        XCTAssertEqual(factory.loggers.count, 0)
        let _ = factory.getLogger(expected)
        XCTAssertEqual(factory.loggers.count, 1)
    }
    
    func testGetLogger_returnsCachedLogger() {
        let expected = UUID().uuidString
        let factory = LoggerFactory()
        XCTAssertEqual(factory.loggers.count, 0)
        let logger = factory.getLogger(expected)
        XCTAssertEqual(factory.loggers.count, 1)
        let cachedLogger = factory.getLogger(expected)
        XCTAssertEqual(logger, cachedLogger)
        XCTAssertEqual(factory.loggers.count, 1)
    }
    
    func testSetConfiguration() {
        let appender = MockAppender()
        var config = Configuration()
        config.add(appender: appender)
        let factory = LoggerFactory()
        factory.set(configuration: config)
        XCTAssertEqual(factory.appenders.count, 1)
    }
    
}
