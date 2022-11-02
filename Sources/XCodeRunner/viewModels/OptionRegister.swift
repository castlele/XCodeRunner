public struct OptionRegister: RegisterFactoryProtocol {

    public var allCases: [Option] {
        [.help, .xVer, .projName]
    }

    public func get() -> [Option] {
        allCases
    }
}
