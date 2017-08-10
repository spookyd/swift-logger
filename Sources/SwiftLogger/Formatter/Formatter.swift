//
//  Formatter.swift
//  Swift-Logger
//
//  Created by Luke Davis on 3/19/17.
//  Copyright © 2017 Lucky 13 Technologies, LLC. All rights reserved.
//

import Foundation

public typealias LoggingInfo = [String: Any]

public struct LoggingInfoKey {
    public static let level = "swift.logger.level"
    public static let date = "swift.logger.date"
    public static let file = "swift.logger.calling.file"
    public static let line = "swift.logger.calling.line"
    public static let function = "swift.logger.calling.function"
    public static let threadName = "swift.logger.thread.name"
}

public protocol Formatter {

    var identifier: String { get }

    func format(_ message: String, _ additionalInfo: LoggingInfo?) -> String

}
