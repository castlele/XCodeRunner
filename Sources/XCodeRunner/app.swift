@main
public struct App {

    private static let printer = CLPrinter()

    private static let fileManager: any FileManagerProtocol = {
        let fileManager = DefaultFileManager()
        fileManager.configure(with: printer)
        return fileManager
    }()

    private static let configurationsManager: any ConfigurationsManagerProtocol = {
        let config = ConfigurationsManager()
        config.configure(with: fileManager)
        return config
    }()

    private static let xcodeManager: XCodeManagerProtocol = {
        let xcodeManager = XCodeManager(configurationsManager: configurationsManager,
                                        fileManager: fileManager)
        return xcodeManager
    }()

    private static let runnerConfigurator: CommandRunnerConfigurator = {
        let config = CommandRunnerConfigurator(printer: printer, xcodeManager: xcodeManager)
        return config
    }()

    public static func main() {
        let parsingService = ParsingService()
        let parsingResults: Result<[Command], Error> = parsingService.parse(CommandLine.arguments)

        let commandRunner = CommandRunner()

        commandRunner.configure(with: runnerConfigurator)
        commandRunner.process(parsingResults: parsingResults)
    }
}
