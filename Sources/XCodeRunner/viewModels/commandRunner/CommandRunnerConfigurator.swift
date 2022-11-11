public struct CommandRunnerConfigurator {

    public let printer: Printer
    public let xcodeManager: XCodeManagerProtocol

    public init(printer: Printer, xcodeManager: XCodeManagerProtocol) {
        self.printer = printer
        self.xcodeManager = xcodeManager
    }
}
