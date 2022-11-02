public protocol Printer {
    func printError(withTitle title: String, description: String) 
    func printMessage(_ message: String)
}

public extension Printer {
    func printMessage(_ message: String) {
        print(message)
    }
}
