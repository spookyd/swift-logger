# Swift Logger

---

[![Build Status](https://travis-ci.org/spookyd/swift-logger.svg?branch=master)](https://travis-ci.org/spookyd/swift-logger)

Swift Logger is a simple logger.

## Requirements

  - Swift 4

> [v0.1.0](https://github.com/spookyd/swift-logger/releases/tag/v0.1.0) supports Swift 3.

## How to Use

### Basic Use

In your projects `applicationDidLoad` set the configuration of the loggers.

```
  let consoleAppender = ConsolePrintAppender()
  var configuration = Configuration.default
  configuration.add(appender: consoleAppender)
  Logger.setConfiguration(configuration)
```

To start logging simply call getLogger and start sending messages

```
import SwiftLogger

class SomeViewController: UIViewController {

  static let logger = Logger.getLogger(by: "SomeViewController")

  ...

  override func viewDidLoad() {
    SomeViewController.logger.debug("Loaded view for View Controller")
    ...
  }

}
```

## Architecture

**Logger** - The logger consumes messages that will be sent to the appenders.
There can be zero to many appenders.

**Appender** - Appenders run the logger messages through their formatter and
then append the message on to a source. Example being, a file, console, a
web service, etc.

**Formatter** - A formatter simply takes the message details and formats it in
a way that is specified through string matching.
