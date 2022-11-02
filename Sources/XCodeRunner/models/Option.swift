import CLArgumentsParser

public struct Option: OptionType {

    public static let help = Option(type: .help)
    public static let xVer = Option(type: .xcodeVersion)
    public static let projName = Option(type: .projName)

    public var type: OptionVariant
    public var arguments: [String] = []

    public var argumentsNeeded: ArgsRange {
        type.argumentsRange
    }
    public var stringValue: String {
        type.rawValue
    }
}

public enum OptionVariant: String, ArgsRangeHolder {
    case help = "-help"
    case xcodeVersion = "-xver"
    case projName = "-proj"

    public var argumentsRange: ArgsRange {
        switch self {
            case .help:
                return ZeroArgsRange

            case .xcodeVersion:
                return (min: 1, max: 1)

            case .projName:
                return (min: 1, max: 1)
        }
    }
}
