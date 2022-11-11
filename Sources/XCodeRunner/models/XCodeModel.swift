import Foundation

public struct XCodeModel: Codable, Equatable {

    public let version: Version?
    public let path: String
    public let isOpenWithRosetta: Bool // TODO: make a command to set this parameter

    public var stringVersion: String? {
        version?.asString
    }

    public var isCompatibleWithMacOS: Bool {
        guard let version = version else {
            return false
        }

        // TODO: Check if it works well with for all current macOS and xcodes. Fix if needed.
        if #available(macOS 13, *) {
            return isCompatibleWithMacOS13(version)
        }

        return true
    }
    
    private func isCompatibleWithMacOS13(_ version: Version) -> Bool {
        let minXcodeVersion = 14
        return !(version.major < minXcodeVersion)
    }
}

public extension XCodeModel {
    static func makeModels(fromAppsNames names: [String], withConfig config: Configuration) -> [XCodeModel] {
        names.map { parseApp(withName: $0, withConfig: config) }
    }

    private static func parseApp(withName appName: String, withConfig config: Configuration) -> XCodeModel {
        let components = appName
            .split(separator: Character(config.versionSeparator))
            .map { String($0) }
            .filter { $0 != "app" }
        let path = (config.path as NSString).appendingPathComponent(appName)
        
        if components.count == 1 {
            let version = Version.makeVersion(fromString: config.defaultXcodeVersion)
            return .init(version: version, path: path, isOpenWithRosetta: false)
        }

        let stringVersion = components[1]
            .split(separator: ".")
            .filter { Int($0) != nil }
            .joined(separator: ".")

        let version = Version.makeVersion(fromString: stringVersion)
        return .init(version: version, path: path, isOpenWithRosetta: false)
    }
}
