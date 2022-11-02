public enum ANSIDecorator: String, CodeRepresentable {
    case bold = "\u{001b}[1m"
    case underline = "\u{001b}[4m"
    case reversed = "\u{001b}[7m"

    public var code: String {
        self.rawValue 
    }
}
