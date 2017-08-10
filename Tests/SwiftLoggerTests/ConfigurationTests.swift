//
//  ConfigurationTests.swift
//  Swift-Logger
//
//  Created by Luke Davis on 3/19/17.
//  Copyright © 2017 Lucky 13 Technologies, LLC. All rights reserved.
//

@testable import SwiftLogger
import XCTest

class ConfigurationTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testDefault() {
        let config = Configuration.default
        XCTAssertEqual(config.appenders.count, 0)
    }

    func testAddAppenders() {
        var configuration = Configuration()
        XCTAssertEqual(configuration.appenders.count, 0)
        configuration.add(appender: MockAppender())
        XCTAssertEqual(configuration.appenders.count, 1)
    }

}

class MockFormatter: SwiftLogger.Formatter {

    var sentMessage: String?
    var additionalInfo: LoggingInfo?
    var formattedMessage: String = ""

    var identifier: String = UUID().uuidString

    func format(_ message: String, _ additionalInfo: LoggingInfo?) -> String {
        self.sentMessage = message
        self.additionalInfo = additionalInfo
        return formattedMessage
    }

}
