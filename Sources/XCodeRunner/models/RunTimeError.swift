import CLArgumentsParser
import Foundation

public enum RunTimeError: StringRepresentable {
    case decodingError(filePath: String)

    public var stringValue: String {
        switch self {
            case .decodingError(_):
                return decodingErrorTitle
        }
    }

    public var description: String {
        switch self {
            case let .decodingError(filePath):
                return String(format: decodingErrorMessage, filePath)
        }
    }
}
