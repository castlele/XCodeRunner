public enum ANSIAttribute: CodeRepresentable {
    case color(ANSIColor)
    case decorator(ANSIDecorator)
    case custom(CodeRepresentable)

    public var code: String {
        switch self {
            case let .color(color):
                return color.code

            case let .decorator(decorator):
                return decorator.code

            case let .custom(attribute):
                return attribute.code
        }
    }
}

