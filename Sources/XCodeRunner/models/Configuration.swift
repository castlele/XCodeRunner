public struct Configuration: Codable {

    private static let defaultXCodesPath = "/Applications"

    public static let defaultConfig = Configuration(defaultXcodeVersion: "13.2.1",
                                                    versionSeparator: "-")

    private var blackList = ["Xcodes.app"]

    public var xCodesPath: String?
    public var defaultXcodeVersion: String
    public var versionSeparator: String
    public var xcodes: [XCodeModel] = []
    
    public var path: String {
        xCodesPath ?? Configuration.defaultXCodesPath
    }

    public func isInWhiteList(_ appName: String) -> Bool {
        !blackList.contains(appName)
    }

    public mutating func addXCodeIfNeeded(_ xcode: XCodeModel) -> Bool {
        if xcodes.contains(xcode) {
            return false
        }

        xcodes.append(xcode)
        return true
    }
}
