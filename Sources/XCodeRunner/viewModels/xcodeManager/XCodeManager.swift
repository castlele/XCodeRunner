public class XCodeManager: XCodeManagerProtocol {

    private let logger = Logger()

    private let configurationsManager: any ConfigurationsManagerProtocol
    private let fileManager: any FileManagerProtocol

    public init(configurationsManager: any ConfigurationsManagerProtocol, fileManager: any FileManagerProtocol) {
        self.configurationsManager = configurationsManager
        self.fileManager = fileManager
    }

    public func getVersions() -> [String] {
        let configuration = configurationsManager.getConfiguration()
        let xcodes = fileManager.getXCodes(withConfig: configuration)

        configurationsManager.updateXCodesIfNeeded(xcodes)

        return parseVersions(forXCodes: xcodes)
    }

    // MARK: - Private methods

    private func parseVersions(forXCodes xcodes: [XCodeModel]) -> [String] {
        let versions = xcodes.compactMap { $0.stringVersion }
        logger.log(.commandVersions(versions: versions))
        return versions
    }
}
