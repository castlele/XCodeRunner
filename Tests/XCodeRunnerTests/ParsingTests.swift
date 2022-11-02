import XCTest
@testable import XCodeRunner

final class XCodeRunnerTests: XCTestCase {

    let parser = ParsingService()

    func testMainParsing() throws {
        let args = ["xrunner"]
        let args1 = ["xrunner", "-help"]
        let args2 = ["xrunner", "random"]
        let args3 = ["xrunner", "-help", "random"]

        let cmd = MockCommandRegister(commands: [.main]).get()

        XCTAssertEqual(try parser.parse(args), cmd)
        XCTAssertTrue(try parser.parse(args1)[0].options[0] == .help)
        XCTAssertThrowsError(try parser.parse(args2))
        XCTAssertThrowsError(try parser.parse(args3))
    }

    func testVersionsParsing() throws {
        let args = ["xrunner", "versions"]
        let args1 = ["versions"]
        let args2 = ["versions", "random"]
        let args3 = ["versions", "-help"]

        let cmd = MockCommandRegister(commands: [.main, .versions]).get()

        XCTAssertEqual(try parser.parse(args), cmd)
        XCTAssertEqual(try parser.parse(args1)[0], cmd[1])
        XCTAssertThrowsError(try parser.parse(args2))
        XCTAssertThrowsError(try parser.parse(args3))
    }

    func testOpenParsing() throws {
        let args = ["open"]
        let args1 = ["open", "-help"]
        let args2 = ["open", "-proj", "path"]
        let args3 = ["open", "-xver", "version"]
        let args4 = ["open", "-proj"]
        let args5 = ["open", "-xver"]
        let args6 = ["open", "random"]
    
        let cmd = MockCommandRegister(commands: [.open]).get()

        XCTAssertEqual(try parser.parse(args), cmd)
        XCTAssertNoThrow(try parser.parse(args1))
        XCTAssertEqual(try parser.parse(args2)[0].options[0].arguments, ["path"])
        XCTAssertEqual(try parser.parse(args3)[0].options[0].arguments, ["version"])
        XCTAssertThrowsError(try parser.parse(args4))
        XCTAssertThrowsError(try parser.parse(args5))
        XCTAssertThrowsError(try parser.parse(args6))
    }

    func testRunParsing() throws {
        let args = ["run"]
        let args1 = ["run", "-help"]
        let args2 = ["run", "-proj", "path"]
        let args3 = ["run", "-xver", "version"]
        let args4 = ["run", "-proj"]
        let args5 = ["run", "-xver"]
        let args6 = ["run", "random"]
    
        let cmd = MockCommandRegister(commands: [.run]).get()

        XCTAssertEqual(try parser.parse(args), cmd)
        XCTAssertNoThrow(try parser.parse(args1))
        XCTAssertEqual(try parser.parse(args2)[0].options[0].arguments, ["path"])
        XCTAssertEqual(try parser.parse(args3)[0].options[0].arguments, ["version"])
        XCTAssertThrowsError(try parser.parse(args4))
        XCTAssertThrowsError(try parser.parse(args5))
        XCTAssertThrowsError(try parser.parse(args6))
    }

    func testGoParsing() throws {
        let args = ["go", "path"]
        let args1 = ["go"]
        let args2 = ["go", "-help"]
        let args3 = ["go", "path", "-help"]
        let args4 = ["run", "-proj"]
        let args5 = ["run", "-xver"]
    
        XCTAssertEqual(try parser.parse(args)[0].type, .go)
        XCTAssertNoThrow(try parser.parse(args1))
        XCTAssertNoThrow(try parser.parse(args2))
        XCTAssertNoThrow(try parser.parse(args3))
        XCTAssertThrowsError(try parser.parse(args4))
        XCTAssertThrowsError(try parser.parse(args5))
    }

    func testSaveParsing() throws {
        let args = ["save"]
        let args1 = ["save", "-help"]
        let args2 = ["save", "-proj", "path"]
        let args3 = ["save", "-xver", "version"]
        let args4 = ["save", "-proj"]
        let args5 = ["save", "-xver"]
        let args6 = ["save", "random"]
    
        let cmd = MockCommandRegister(commands: [.save]).get()

        XCTAssertEqual(try parser.parse(args), cmd)
        XCTAssertNoThrow(try parser.parse(args1))
        XCTAssertEqual(try parser.parse(args2)[0].options[0].arguments, ["path"])
        XCTAssertEqual(try parser.parse(args3)[0].options[0].arguments, ["version"])
        XCTAssertThrowsError(try parser.parse(args4))
        XCTAssertThrowsError(try parser.parse(args5))
        XCTAssertThrowsError(try parser.parse(args6))
    }
}
