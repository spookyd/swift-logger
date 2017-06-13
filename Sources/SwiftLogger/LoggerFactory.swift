//
//  LoggerFactory.swift
//  Swift-Logger
//
//  Created by Luke Davis on 3/19/17.
//
//

import Foundation

internal final class LoggerFactory {

    static let shared = LoggerFactory()

    var loggers: [String: Logger] = [:]
    var appenders: [String: Appender] = [:] {
        didSet {
            for logger in loggers {
                logger.value.appenders = appenders.map { $0.value }
            }
        }
    }

    init() {

    }

    func set(configuration: Configuration) {
        self.appenders = configuration.appenders
    }

    func getLogger(_ named: String) -> Logger {
        if let logger = loggers[named] {
            return logger
        }
        let logger = Logger(named: named)
        logger.appenders = appenders.map { $0.value }
        loggers[named] = logger
        return logger
    }

}
