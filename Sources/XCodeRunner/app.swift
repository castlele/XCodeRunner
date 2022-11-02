@main
public struct App {

    public static func main() {
        let parsingService = ParsingService()
        let printer = CLPrinter()
        let parsingResults: Result<[Command], Error> = parsingService.parse(CommandLine.arguments)

        let commandRunner = CommandRunner()
        commandRunner.configure(with: printer)

        commandRunner.process(parsingResults: parsingResults)
    }
}
