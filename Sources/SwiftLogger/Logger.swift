import Foundation
/**
 */
public final class Logger {
    
    public var appenders: [Appender] = []
    
    public let identifier: String
    public var logLevel: LogLevel = .debug
    
    public var queue: DispatchQueue = DispatchQueue(label: "com.lucky13.logger")
    public var isAsync: Bool = false
    
    public init(named: String) {
        identifier = named
    }
    
    public func debug(_ messsage: CustomStringConvertible,
                      _ callingFile: String = #file,
                      _ executedLine: Int = #line,
                      _ callingFunction: String = #function) {
        log(.debug, messsage, callingFile, executedLine, callingFunction)
    }
    
    public func info(_ messsage: CustomStringConvertible,
                     _ callingFile: String = #file,
                     _ executedLine: Int = #line,
                     _ callingFunction: String = #function) {
        log(.info, messsage, callingFile, executedLine, callingFunction)
    }
    
    public func warn(_ messsage: CustomStringConvertible,
                     _ callingFile: String = #file,
                     _ executedLine: Int = #line,
                     _ callingFunction: String = #function) {
        log(.warn, messsage, callingFile, executedLine, callingFunction)
    }
    
    public func error(_ messsage: CustomStringConvertible,
                      error: Error?,
                      _ callingFile: String = #file,
                      _ executedLine: Int = #line,
                      _ callingFunction: String = #function) {
        log(.error, messsage, callingFile, executedLine, callingFunction)
    }
    
    public func fatal(_ messsage: CustomStringConvertible,
                      error: Error?,
                      _ callingFile: String = #file,
                      _ executedLine: Int = #line,
                      _ callingFunction: String = #function) {
        log(.fatal, messsage, callingFile, executedLine, callingFunction)
    }
    
    internal func log(_ level: LogLevel,
                      _ message: CustomStringConvertible,
                      _ callingFile: String? = nil,
                      _ executedLine: Int? = nil,
                      _ callingFunction: String? = nil) {
        if level < logLevel {
            return
        }
        var additionInfo: [String: Any] = [
            LoggingInfoKey.level: level.description,
            LoggingInfoKey.date: Date(),
            LoggingInfoKey.threadName: threadName]
        if let callingFile = callingFile {
            additionInfo[LoggingInfoKey.file] = callingFile
        }
        if let executedLine = executedLine {
            additionInfo[LoggingInfoKey.line] = executedLine
        }
        if let callingFunction = callingFunction {
            additionInfo[LoggingInfoKey.function] = callingFunction
        }
        let callAppenders = {
            for appender in self.appenders {
                appender.log(level, message.description, additionInfo)
            }
        }
        if isAsync {
            self.queue.async(execute: callAppenders)
        } else {
            self.queue.sync(execute: callAppenders)
        }
    }
    
    internal var threadName: String {
        if let name = Thread.current.name, !name.characters.isEmpty {
            return name
        }
        return String(describing: Thread.current)
    }
    
    /// Gets cached logger. If one is not found one will be created
    public static func getLogger(by ID: String) -> Logger {
        return LoggerFactory.shared.getLogger(ID)
    }
    
}

extension Logger: Equatable {
    
    public static func ==(lhs: Logger, rhs: Logger) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
}
