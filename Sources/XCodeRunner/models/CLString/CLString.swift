public struct CLString {
    
    static let resetCode = "\u{001b}[0m"

    public var string: String

    public init(string: String = "") {
        self.string = string
    }

    // TODO: Update to apply array of attributes to make an algorithm more efficient
    mutating func set(attribute: CodeRepresentable, forRange range: ClosedRange<Int>) {
        let lower = range.lowerBound < 0 || range.lowerBound > (string.count - 1) 
            ? 0 
            : range.lowerBound
        let upper = (range.upperBound > (string.count - 1) ? string.count : range.upperBound) + 2
        
        var array = string.map { String($0) }

        array.insert(attribute.code, at: lower)
        array.insert(CLString.resetCode, at: upper)

        string = array.joined()
    }
}
