@main
public struct XCodeRunner {
    public private(set) var text = "Hello, World!"

    public static func main() {
        print(XCodeRunner().text)
    }
}
