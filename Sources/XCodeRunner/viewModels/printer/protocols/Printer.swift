public protocol Printer {
    func printError(withTitle title: String, description: String) 
    func printMessage(_ message: String)
}

public extension Printer {
    func printUnknownError() {
        printError(withTitle: unknownErrorMessage, description: "")
    }

    func printError(_ error: Error) {
        printError(withTitle: commonErrorTitle, description: error.localizedDescription)
    }

    func printError(_ error: RunTimeError) {
        printError(withTitle: error.stringValue, description: error.description)
    }

    func printMessage(_ message: String) {
        print(message)
    }
}
