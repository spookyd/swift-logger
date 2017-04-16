//
//  LogLevel.swift
//  Swift-Logger
//
//  Created by Luke Davis on 3/18/17.
//
//

import Foundation

/**
 Logging Levels
 VERBOSE < DEBUG < INFO < WARN < ERROR < FATAL < OFF
 */
public enum LogLevel: Int {
    case verbose
    case debug
    case info
    case warn
    case error
    case fatal
    case off
}

extension LogLevel: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .verbose: return "VERBOSE"
        case .debug: return "DEBUG"
        case .info: return "INFO"
        case .warn: return "WARN"
        case .error: return "ERROR"
        case .fatal: return "FATAL"
        case .off: return ""
        }
    }
    
}

extension LogLevel: Comparable {
    
    public static func <(lhs: LogLevel, rhs: LogLevel) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
    
    public static func <=(lhs: LogLevel, rhs: LogLevel) -> Bool {
        return lhs.rawValue <= rhs.rawValue
    }
    
    public static func >=(lhs: LogLevel, rhs: LogLevel) -> Bool {
        return lhs.rawValue >= rhs.rawValue
    }
    
    public static func >(lhs: LogLevel, rhs: LogLevel) -> Bool {
        return lhs.rawValue > rhs.rawValue
    }
}
