public class ConfigurationsManager: ConfigurationsManagerProtocol {

    private let logger = Logger()

    private var fileManager: (any FileManagerProtocol)?

    private var configuration: Configuration?

    // MARK: - ConfigurationsManagerProtocol

    public func configure(with fileManager: any FileManagerProtocol) {
        self.fileManager = fileManager
    }

    public func getXCodesPath() -> String {
        configuration = getConfiguration()
        return configuration!.path
    }

    public func getConfiguration() -> Configuration {
        if let config = configuration {
            logger.log(.gotConfig(config: config)) 
            return config
        }

        configuration = fileManager?.getConfiguration() ?? Configuration.defaultConfig
        logger.log(.gotConfig(config: configuration!)) 
        return configuration!
    }

    public func updateXCodesIfNeeded(_ xcodes: [XCodeModel]) {
        xcodes.forEach { xcode in
            if configuration?.addXCodeIfNeeded(xcode) == true {
                logger.log(.xcodeAdded(xcode: xcode))
            }
        }
    }
}
