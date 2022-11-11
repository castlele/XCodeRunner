import Foundation

public class DefaultFileManager: FileManagerProtocol {

    private let path = "~/.config/xrunner/"
    private let configFileName = "config.json"

    private let logger = Logger()
    private let fileManager = FileManager.default
    private let decoder = JSONDecoder()
    private lazy var encoder: JSONEncoder = {
        let encoder = JSONEncoder()

        encoder.outputFormatting = .prettyPrinted

        return encoder
    }()

    private var printer: Printer?

    private var configPath: String {
        path + configFileName
    }

    // MARK: - FileManagerProtocol

    public func configure(with printer: Printer) {
        self.printer = printer
    }

    public func getXCodes(withConfig config: Configuration) -> [XCodeModel] {
        let path = config.path
        let contents = getContents(ofPath: path)
        let xcodePaths = contents
            .filter { $0.lowercased().contains("xcode") &&  config.isInWhiteList($0) }

        let xcodes = XCodeModel.makeModels(fromAppsNames: xcodePaths, withConfig: config)
        logger.log(.gotXcodes(path: path, xcodes: xcodes))
        return xcodes
    }

    public func getConfiguration() -> Configuration? {
        if !isFileExists(atPath: configPath) {
            createFile(atPath: configPath, withObject: Configuration.defaultConfig)
            return Configuration.defaultConfig
        }

        return getContents(fromFilePath: configPath)
    }

    // MARK: - Private methods

    private func getContents(ofPath path: String) -> [String] {
        let applications = (try? fileManager.contentsOfDirectory(atPath: path)) ?? []
        logger.log(.getContents(path: path, contents: applications))
        return applications
    }

    private func isFileExists(atPath path: String) -> Bool {
        return false
    }

    private func createFile<T: Encodable>(atPath path: String, withObject obj: T? = nil) {
        let data = encode(object: obj)
        fileManager.createFile(atPath: path, contents: data)
    }

    // TODO: add concurrency
    private func getContents<T: Decodable>(fromFilePath filePath: String) -> T? {
        do {
            guard let data = try String(contentsOfFile: filePath).data(using: .utf8) else {
                printer?.printUnknownError()
                return nil
            }
            let object: T? = decode(data: data)
            return object

        } catch {
            printer?.printError(error)
            return nil
        }

    }

    private func encode<T: Encodable>(object: T) -> Data? {
        try? encoder.encode(object)
    }

    private func decode<T: Decodable>(data: Data) -> T? {
        try? decoder.decode(T.self, from: data)
    }
}
