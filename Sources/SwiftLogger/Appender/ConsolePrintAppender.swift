//
//  ConsolePrintAppender.swift
//  Logger
//
//  Created by Luke Davis on 4/13/17.
//
//

import Foundation

public class ConsolePrintAppender: Appender {

    public var identifier: String = "com.lucky13.printOutput"

    public var formatter: SwiftLogger.Formatter?

    public init(formatter: SwiftLogger.Formatter? = nil) {
        self.formatter = formatter
    }

    public func sendLog(_ level: LogLevel, _ output: String) {
        print(output)
    }
}
