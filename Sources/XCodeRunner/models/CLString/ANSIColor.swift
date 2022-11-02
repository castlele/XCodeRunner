public struct ANSIColor: CodeRepresentable {
    
    public static let black = ANSIColor(code: "\u{001b}[30m")
    public static let red = ANSIColor(code: "\u{001b}[31m")
    public static let green = ANSIColor(code: "\u{001b}[32m")
    public static let yellow = ANSIColor(code: "\u{001b}[33m")
    public static let blue = ANSIColor(code: "\u{001b}[34m")
    public static let magenta = ANSIColor(code: "\u{001b}[35m")
    public static let cyan = ANSIColor(code: "\u{001b}[36m")
    public static let white = ANSIColor(code: "\u{001b}[37m")

    public static let blackBackground = ANSIColor(code: "\u{001b}[40m")
    public static let redBackground = ANSIColor(code: "\u{001b}[41m")
    public static let greenBackground = ANSIColor(code: "\u{001b}[42m")
    public static let yelloBackgroundw = ANSIColor(code: "\u{001b}[43m")
    public static let blueBackground = ANSIColor(code: "\u{001b}[44m")
    public static let magenBackgroundta = ANSIColor(code: "\u{001b}[45m")
    public static let cyanBackground = ANSIColor(code: "\u{001b}[46m")
    public static let whiteBackground = ANSIColor(code: "\u{001b}[47m")

    public let code: String

    public init(code: String) {
        self.code = code
    }

    func withLight() -> ANSIColor {
        if code.last == "m" {
            let color = code[code.startIndex ..< code.index(before: code.endIndex)]
            let lighterColorCode = color + ";1m"
            return .init(code: String(lighterColorCode))
        }

        return .init(code: code + ";1m")
    }
}
