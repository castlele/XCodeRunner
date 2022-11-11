import CLArgumentsParser

public typealias Command = BaseCLCommand<Option, CommandType>

public enum CommandType: String, StringRepresentable, CaseIterable, ArgsRangeHolder {
    case main = "xrunner"
    case versions
    case open
    case run
    case go
    case save

    public var stringValue: String {
        #if DEBUG

        switch self {
            case .main:
                return ".build/debug/xrunner"
            default:
                return rawValue
        }

        #else

        return rawValue

        #endif
    }

    public var argumentsRange: ArgsRange {
        switch self {
            case .versions, .open, .run, .main, .save:
                return ZeroArgsRange

            case .go:
                return (min: 0, max: 1)
        }
    }

    public var options: [String: Option] {
        switch self {
            case .main:
                return [
                    Option.help.stringValue: .help,
                ]

            case .versions:
                return [:]

            case .save, .open, .run:
                return [
                    Option.help.stringValue: .help,
                    Option.projName.stringValue: .projName,
                    Option.xVer.stringValue: .xVer
                ]

            case .go:
                return [
                    Option.help.stringValue: .help,
                ]
        }
    }
}
