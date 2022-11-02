public struct CommandRegister: RegisterFactoryProtocol {

    public var allCases: [CommandType] {
        CommandType.allCases
    }

    public func get() -> [Command] {
        allCases.map { 
            .init(name: $0.stringValue,
                  type: $0,
                  argumentsNeeded: $0.argumentsRange,
                  availableOptions: $0.options) 
        }
    }
}
