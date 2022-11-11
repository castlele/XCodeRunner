public protocol ConfigurationsManagerProtocol: Configurable {
    func configure(with fileManager: any FileManagerProtocol)
    func getXCodesPath() -> String
    func getConfiguration() -> Configuration
    func updateXCodesIfNeeded(_ xcodes: [XCodeModel])
}
