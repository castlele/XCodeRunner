import CLArgumentsParser
import Foundation

public final class CommandRunner: Configurable {

    private var printer: Printer?

    public func configure(with printer: Printer) {
        self.printer = printer
    }

    public func process(parsingResults results: Result<[Command], Error>) {
        switch results {
            case let .success(commands):
                run(commands)

            case let .failure(error):
                process(error: error)
        }
    }

    private func process(error: Error) {
        guard let clError = error as? CLDefaultParserError else {
            printer?.printError(withTitle: unknownErrorMessage, description: "")
            return
        }

        var errorMessage = ""

        switch clError {
            case let .invalidArgument(argument):
                errorMessage = String(format: invalidArgumentMessage, argument)

            case let .invalidUsage(command):
                errorMessage = String(format: invalidUsageMessage, command)

            case let .invalidUseOfOption(option, command):
                errorMessage = String(format: invalidUsageOfOptionForCommand, option, command)
        }

        printer?.printError(withTitle: commonErrorTitle, description: errorMessage)
    }

    private func run(_ commands: [Command]) {
        for command in commands {
            if !run(command) {
                return
            }
        }
    }

    private func run(_ command: Command) -> Bool {
        switch command.type {
            case .main:
                return process(options: command.options)

            case .versions:
                return false

            default:
                return true
            /*
            case .open:
            
            case .run:

            case .go:

            case .save:
            */
        }
    }

    private func process(options: [Option] = []) -> Bool {
        for option in options {
            if !process(option: option) {
                return false
            }
        }

        return true
    }

    private func process(option: Option) -> Bool {
        switch option.type {
            case .help:
                printer?.printMessage(commonHelpMessage)
                return false

            default:
                return true
        }
    }
}
