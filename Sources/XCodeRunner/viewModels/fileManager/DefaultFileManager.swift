import Foundation

public class DefaultFileManager: FileManagerProtocol {

    private let path = ".config/xrunner"
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

    private var homeDirectory: NSString {
        let prefix = "file:/"
        var path = fileManager.homeDirectoryForCurrentUser.absoluteString
        path.removeSubrange(path.startIndex..<path.index(path.startIndex, offsetBy: prefix.count))
        return path as NSString
    }
    
    private var baseFolder: String {
        homeDirectory.appendingPathComponent(path)
    }

    private var configPath: String {
        (baseFolder as NSString).appendingPathComponent(configFileName)
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
            createFolderIfNeeded(atPath: baseFolder)
            createFile(atPath: configPath, withObject: Configuration.defaultConfig)
            return Configuration.defaultConfig
        }

        return getContents(fromFilePath: configPath)
    }

    public func save(config: Configuration) {
        let fullPath = "file://" + configPath

        guard let url = URL(string: fullPath) else { return }

        let data = encode(object: config)
        try? data?.write(to: url)
    }

    // MARK: - Private methods

    private func getContents(ofPath path: String) -> [String] {
        let applications = (try? fileManager.contentsOfDirectory(atPath: path)) ?? []
        logger.log(.getContents(path: path, contents: applications))
        return applications
    }

    private func isFileExists(atPath path: String) -> Bool {
        fileManager.fileExists(atPath: path)
    }

    private func createFile<T: Encodable>(atPath path: String, withObject obj: T? = nil) {
        let data = encode(object: obj)
        fileManager.createFile(atPath: path, contents: data)
    }

    private func createFolderIfNeeded(atPath path: String) {
        var isDirectory: ObjCBool = true

        if !fileManager.fileExists(atPath: path, isDirectory: &isDirectory) {
            try? fileManager.createDirectory(atPath: path, withIntermediateDirectories: true)
        }
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
