//
//  Configuration.swift
//  Swift-Logger
//
//  Created by Luke Davis on 3/19/17.
//
//

import Foundation

public struct Configuration {
    
    var appenders: [String: Appender] = [:]
    
    public mutating func add(appender: Appender) {
        appenders[appender.identifier] = appender
    }
    
}

extension Configuration {
    static var `default`: Configuration {
        return Configuration()
    }
}
