public struct CLPrinter: Printer {

    public init() { }

    public func printError(withTitle title: String = "", description: String = "") {
        var message = title
        message += description.isEmpty ? "" : "\n\n\(description)"

        var clString = CLString(string: message)
        clString.set(attribute: ANSIAttribute.color(.red), forRange: 0...title.count)

        print(clString: clString)
    }

    private func print(clString string: CLString) {
        printMessage(string.string)
    }
}
