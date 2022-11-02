import XCodeRunner

struct MockCommandRegister: RegisterFactoryProtocol {
    let commands: [CommandType]

    var allCases: [CommandType] {
        commands
    }

    func get() -> [Command] {
        allCases.map { 
            .init(name: $0.stringValue,
                  type: $0,
                  argumentsNeeded: $0.argumentsRange,
                  availableOptions: $0.options) 
        }
    }
}
