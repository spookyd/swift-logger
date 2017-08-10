//
//  Configuration.swift
//  Swift-Logger
//
//  Created by Luke Davis on 3/19/17.
//  Copyright © 2017 Lucky 13 Technologies, LLC. All rights reserved.
//

import Foundation

public struct Configuration {

    var appenders: [String: Appender] = [:]

    public mutating func add(appender: Appender) {
        appenders[appender.identifier] = appender
    }

}

extension Configuration {
    public static var `default`: Configuration {
        return Configuration()
    }
}
