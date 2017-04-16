//
//  LoggerPerformanceTests.swift
//  Logger
//
//  Created by Luke Davis on 4/13/17.
//
//

import XCTest
@testable import SwiftLogger

class LoggerPerformanceTests: XCTestCase {
    
    var appender: Appender!
    
    override func setUp() {
        super.setUp()
        let formatter = BasicLayoutFormatter()
        let layout = "$d-$l::$m($F:$L-$M) on $t"
        formatter.layout = layout
        appender = ConsolePrintAppender(formatter: formatter)
    }
    
    override func tearDown() {
        appender = nil
        super.tearDown()
    }

    func testLoggingPerformance() {
        let logger = Logger(named: "com.lucky13.performance.test")
        logger.appenders = [appender]
        self.measure {
            for idx in 0...1500 {
                logger.debug("Performance Log Message \(idx)")
            }
        }
    }
    
    func testAsyncLoggingPerformance() {
        let logger = Logger(named: "com.lucky13.performance.test")
        logger.appenders = [appender]
        logger.isAsync = true
        let queue = DispatchQueue(label: "com.lucky13.performance.queue",
                                  qos: .userInitiated,
                                  attributes: .concurrent,
                                  autoreleaseFrequency: .inherit,
                                  target: nil)
        logger.queue = queue
        print("Starting Async Performance Test")
        self.measure {
            for idx in 0...1500 {
                logger.debug("Performance Async Log Message \(idx)")
            }
        }
        print("Completing Async Performance Test")
    }
    
    func testLoggerFactoryPerformance() {
        let logger = Logger.getLogger(by: "com.lucky13.performance.factory.test")
        logger.appenders = [appender]
        self.measure {
            for idx in 0...1500 {
                logger.debug("Factory Performance Log Message \(idx)")
            }
        }
    }

}
