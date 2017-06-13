import Foundation

/** 
 Logger
 */
public final class Logger {

    /// The appenders used for adding custom logging functionality
    public var appenders: [Appender] = []

    /// A unique identifier for an instance of a logger
    public let identifier: String

    /// The maximum level of logging output
    public var logLevel: LogLevel = .debug

    /// Specifies which queue to execute the log on
    public var queue: DispatchQueue = DispatchQueue(label: "com.lucky13.logger")

    /// Specifies if the log should be exectued on the queue synchronously or asynchronously. 
    /// Defaults to `false`
    public var isAsync: Bool = false

    /// Initializes a new logger object.
    ///
    /// *Note:* For optimazation reasons consider using the `Logger.getLogger(named:)` instead.
    ///
    /// - Parameter named: A unique name to be used for this logger instance.
    public init(named: String) {
        identifier = named
    }

    /// Sends log as debug log level
    ///
    /// - Parameters:
    ///   - messsage: The message to be sent to the appenders
    ///   - callingFile: Defaults to the calling `#file`
    ///   - executedLine: Defaults to the calling `#line`
    ///   - callingFunction: Defaults to the calling `#function`
    public func debug(_ messsage: CustomStringConvertible,
                      _ callingFile: String = #file,
                      _ executedLine: Int = #line,
                      _ callingFunction: String = #function) {
        log(.debug, messsage, callingFile, executedLine, callingFunction)
    }

    /// Sends log as info log level
    ///
    /// - Parameters:
    ///   - messsage: The message to be sent to the appenders
    ///   - callingFile: Defaults to the calling `#file`
    ///   - executedLine: Defaults to the calling `#line`
    ///   - callingFunction: Defaults to the calling `#function`
    public func info(_ messsage: CustomStringConvertible,
                     _ callingFile: String = #file,
                     _ executedLine: Int = #line,
                     _ callingFunction: String = #function) {
        log(.info, messsage, callingFile, executedLine, callingFunction)
    }

    /// Sends log as warn log level
    ///
    /// - Parameters:
    ///   - messsage: The message to be sent to the appenders
    ///   - callingFile: Defaults to the calling `#file`
    ///   - executedLine: Defaults to the calling `#line`
    ///   - callingFunction: Defaults to the calling `#function`
    public func warn(_ messsage: CustomStringConvertible,
                     _ callingFile: String = #file,
                     _ executedLine: Int = #line,
                     _ callingFunction: String = #function) {
        log(.warn, messsage, callingFile, executedLine, callingFunction)
    }

    /// Sends log as error log level
    ///
    /// - Parameters:
    ///   - messsage: The message to be sent to the appenders
    ///   - callingFile: Defaults to the calling `#file`
    ///   - executedLine: Defaults to the calling `#line`
    ///   - callingFunction: Defaults to the calling `#function`
    public func error(_ messsage: CustomStringConvertible,
                      error: Error?,
                      _ callingFile: String = #file,
                      _ executedLine: Int = #line,
                      _ callingFunction: String = #function) {
        log(.error, messsage, callingFile, executedLine, callingFunction)
    }

    /// Sends log as fatal log level
    ///
    /// - Parameters:
    ///   - messsage: The message to be sent to the appenders
    ///   - callingFile: Defaults to the calling `#file`
    ///   - executedLine: Defaults to the calling `#line`
    ///   - callingFunction: Defaults to the calling `#function`
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
    
    public static func setConfiguration(configuration: Configuration) {
        return LoggerFactory.shared.set(configuration: configuration)
    }

}

extension Logger: Equatable {

    public static func == (lhs: Logger, rhs: Logger) -> Bool {
        return lhs.identifier == rhs.identifier
    }

}
