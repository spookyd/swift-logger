//
//  BasicLayoutFormatter.swift
//  Swift-Logger
//
//  Created by Luke Davis on 3/26/17.
//
//

import Foundation

/**
 Basic Formatter for Laying out a log message
 
 Parsing is based on the following identifiers
   1. $d - Log Date
   1. $m - Log Message
   1. $l - Log Level
   1. $t - Name of Thread
   1. $F - The name of the file calling the log method
   1. $L - The line number of the file executing the log method
   1. $M - The function/ method which invoked the log method
 */
open class BasicLayoutFormatter: Formatter {

    public var identifier: String

    /// The default layout is `<Log Level>-<Log Message>`
    open var layout: String = "$l-$m"

    /// Date formatter when using the $d tag. Providing `nil` but specifying $d will yield default date string 
    open var dateFormatter: DateFormatter?

    init() {
        identifier = UUID().uuidString
    }

    public func format(_ message: String, _ additionalInfo: LoggingInfo?) -> String {
        var text = layout
        text = text.replacingOccurrences(of: "$m", with: message)
        guard let info = additionalInfo else {
            return text
        }
        if let level = info[LoggingInfoKey.level] as? String {
            text = text.replacingOccurrences(of: "$l", with: level)
        }
        if let date = info[LoggingInfoKey.date] as? Date {
            var formattedDate = "\(date)"
            if let formatter = dateFormatter {
                formattedDate = formatter.string(from: date)
            }
            text = text.replacingOccurrences(of: "$d", with: formattedDate)
        }
        if let name = info[LoggingInfoKey.threadName] as? String {
            text = text.replacingOccurrences(of: "$t", with: name)
        }
        if let file = info[LoggingInfoKey.file] as? String {
            text = text.replacingOccurrences(of: "$F", with: file)
        }
        if let line = info[LoggingInfoKey.line] as? Int {
            text = text.replacingOccurrences(of: "$L", with: "\(line)")
        }
        if let function = info[LoggingInfoKey.function] as? String {
            text = text.replacingOccurrences(of: "$M", with: function)
        }
        return text
    }

}
