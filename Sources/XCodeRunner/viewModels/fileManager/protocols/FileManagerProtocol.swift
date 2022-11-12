public protocol FileManagerProtocol: Configurable {
    func configure(with printer: Printer)
    func getConfiguration() -> Configuration?
    func getXCodes(withConfig config: Configuration) -> [XCodeModel]
    func save(config: Configuration)
}
