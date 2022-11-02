import CLArgumentsParser

private typealias Register = BaseCLRegister<Command> 
private typealias Parser = BaseCLParser<BaseCLRegister<Command>> 

public struct ParsingService {

    private let register: Register
    private let parser: Parser

    public init() {
        register = .init()
        parser = .init(register: register)

        CommandRegister()
            .get()
            .forEach { register.register(command: $0) }

        OptionRegister()
            .get()
            .forEach { register.register(option: $0) }
    }


    public func parse(_ args: [String]) throws -> [Command] {
        try parser.parse(args)
    }

    public func parse(_ args: [String]) -> Result<[Command], Error> {
        do {
            let commands: [Command] = try parse(args)
            return .success(commands)

        } catch {
            return .failure(error)
        }
    }
}
