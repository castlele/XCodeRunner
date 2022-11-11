import CLArgumentsParser
import Foundation 

public struct Logger: Printer {

    public enum Task: StringRepresentable {
        case commandVersions(versions: [String])
        case gotConfig(config: Configuration)
        case xcodeAdded(xcode: XCodeModel)
        case getContents(path: String, contents: [String])
        case gotXcodes(path: String, xcodes: [XCodeModel])

        private var curDate: String {
            "[\(Date())]: "
        }

        public var stringValue: String {
            switch self {
                case let .commandVersions(versions):
                    return makeMessage("parsedVersions: {\(versions)}")

                case let .gotConfig(config):
                    return makeMessage("got config: {\(config)}")

                case let .xcodeAdded(xcode):
                    return makeMessage("added xcode: {\(xcode)}")

                case let .getContents(path, contents):
                    return makeMessage("got contents: {\(contents)}, from path: {\(path)}")

                case let .gotXcodes(path, xcodes):
                    return makeMessage("got xcodes: {\(xcodes)}, from path: {\(path)}")
            }
        }

        private func makeMessage(_ message: String) -> String {
            curDate + message
        }
    }

    public init() { }

    public func log(_ task: Task) {
        #if DEBUG
        printMessage(task.stringValue)
        #endif
    }

    public func printError(withTitle title: String = "", description: String = "") {
        printMessage(title + "\n" + description)
    }
}
