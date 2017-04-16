//
//  Appender.swift
//  Swift-Logger
//
//  Created by Luke Davis on 3/18/17.
//
//

import Foundation

/**
 Appender is the mechanism that does something with the logging output
 */
public protocol Appender {
    
    /// A unique identifier to differentiate from other appenders
    var identifier: String { get }
    
    /// The formatter to be used to format the log message before it is sent to the appender
    var formatter: Formatter? { get set }
    
    /**
     Required initializer for creating an Appender
     */
//    init(identifier: String)
   
    /**
     Invoked after logging message has been formatted
     
     This is the point that the implementation should store/ print/ send the log message
     */
    func sendLog(_ level: LogLevel, _ output: String)
    
}

extension Appender {
    
    func log(_ level: LogLevel, _ output: String, _ loggingInfo: LoggingInfo?) {
        let formattedOutput = formatter?.format(output, loggingInfo) ?? output
        sendLog(level, formattedOutput)
    }
    
}
