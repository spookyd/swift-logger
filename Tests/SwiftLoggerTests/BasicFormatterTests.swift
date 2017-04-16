//
//  BasicFormatterTests.swift
//  Swift-Logger
//
//  Created by Luke Davis on 3/26/17.
//
//

import XCTest
@testable import SwiftLogger

class BasicFormatterTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testFormat_message() {
        let msg = UUID().uuidString
        let expected = "\(msg)"
        let layout = "$m"
        let formatter = BasicLayoutFormatter()
        formatter.layout = layout
        let actual = formatter.format(msg, nil)
        XCTAssertEqual(expected, actual)
    }
    
    func testFormat_message_withMoreFormatting() {
        let msg = UUID().uuidString
        let expected = "~~\(msg)~~"
        let layout = "~~$m~~"
        let formatter = BasicLayoutFormatter()
        formatter.layout = layout
        let actual = formatter.format(msg, nil)
        XCTAssertEqual(expected, actual)
    }
    
    func testFormat_message_withMultiple() {
        let msg = UUID().uuidString
        let expected = "\(msg)::\(msg)"
        let layout = "$m::$m"
        let formatter = BasicLayoutFormatter()
        formatter.layout = layout
        let actual = formatter.format(msg, nil)
        XCTAssertEqual(expected, actual)
    }
    
    func testFormat_Level() {
        let msg = UUID().uuidString
        let expectedLevel = UUID().uuidString
        let expected = "Log Level -> \(expectedLevel)"
        let layout = "Log Level -> $l"
        let formatter = BasicLayoutFormatter()
        formatter.layout = layout
        let info = [LoggingInfoKey.level: expectedLevel]
        let actual = formatter.format(msg, info)
        XCTAssertEqual(expected, actual)
    }
    
    func testFormat_CallingFile() {
        let msg = UUID().uuidString
        let expectedFile = UUID().uuidString
        let expected = "File Name -> \(expectedFile)"
        let layout = "File Name -> $F"
        let formatter = BasicLayoutFormatter()
        formatter.layout = layout
        let info = [LoggingInfoKey.file: expectedFile]
        let actual = formatter.format(msg, info)
        XCTAssertEqual(expected, actual)
    }
    
    func testFormat_CallingLine() {
        let msg = UUID().uuidString
        let expectedLine = 123
        let expected = "Line number -> \(expectedLine)"
        let layout = "Line number -> $L"
        let formatter = BasicLayoutFormatter()
        formatter.layout = layout
        let info = [LoggingInfoKey.line: expectedLine]
        let actual = formatter.format(msg, info)
        XCTAssertEqual(expected, actual)
    }
    
    func testFormat_CallingFunc() {
        let msg = UUID().uuidString
        let expectedFunc = UUID().uuidString
        let expected = "Func Name -> \(expectedFunc)"
        let layout = "Func Name -> $M"
        let formatter = BasicLayoutFormatter()
        formatter.layout = layout
        let info = [LoggingInfoKey.function: expectedFunc]
        let actual = formatter.format(msg, info)
        XCTAssertEqual(expected, actual)
    }
    
    func testFormat_ThreadName() {
        let msg = UUID().uuidString
        let expectedName = UUID().uuidString
        let expected = "Thread Name -> \(expectedName)"
        let layout = "Thread Name -> $t"
        let formatter = BasicLayoutFormatter()
        formatter.layout = layout
        let info = [LoggingInfoKey.threadName: expectedName]
        let actual = formatter.format(msg, info)
        XCTAssertEqual(expected, actual)
    }
    
    func testFormat_Date() {
        let msg = UUID().uuidString
        let expectedDate = Date()
        let expected = "Date -> \(expectedDate)"
        let layout = "Date -> $d"
        let formatter = BasicLayoutFormatter()
        formatter.layout = layout
        let info = [LoggingInfoKey.date: expectedDate]
        let actual = formatter.format(msg, info)
        XCTAssertEqual(expected, actual)
    }
    
    func testFormat_DateCustomFormatter() {
        let msg = UUID().uuidString
        let expectedDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let expected = "\(dateFormatter.string(from: expectedDate))"
        let layout = "$d"
        let formatter = BasicLayoutFormatter()
        formatter.dateFormatter = dateFormatter
        formatter.layout = layout
        let info = [LoggingInfoKey.date: expectedDate]
        let actual = formatter.format(msg, info)
        XCTAssertEqual(expected, actual)
    }
    
    func testFormat_layout() {
        let msg = UUID().uuidString
        let expectedLevel = UUID().uuidString
        let expectedFile = UUID().uuidString
        let expectedLine = 123
        let expectedFunc = UUID().uuidString
        let expectedDate = Date()
        let expectedName = UUID().uuidString
        let expected = "\(expectedDate)-\(expectedLevel)::\(msg)(\(expectedFile):\(expectedLine)-\(expectedFunc)) on \(expectedName)"
        let layout = "$d-$l::$m($F:$L-$M) on $t"
        let formatter = BasicLayoutFormatter()
        formatter.layout = layout
        let info: [String: Any] = [LoggingInfoKey.level: expectedLevel,
                    LoggingInfoKey.file: expectedFile,
                    LoggingInfoKey.line: expectedLine,
                    LoggingInfoKey.function: expectedFunc,
                    LoggingInfoKey.date: expectedDate,
                    LoggingInfoKey.threadName: expectedName]
        let actual = formatter.format(msg, info)
        XCTAssertEqual(expected, actual)
    }
    
}
