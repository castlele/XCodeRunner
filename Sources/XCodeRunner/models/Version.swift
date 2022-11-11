public struct Version: Codable, Equatable {
    public let major: Int
    public let minor: Int
    public let patch: Int

    public var asString: String {
        [major, minor, patch]
            .map { String($0) }
            .joined(separator: ".")
    }
}

public extension Version {
    static func makeVersion(fromString str: String) -> Version? {
        let components = str.split(separator: ".")
        let intComponents = components.compactMap { Int($0) }

        switch intComponents.count {
            case 1:
                return Version(major: intComponents[0], minor: .zero, patch: .zero)

            case 2:
                return Version(major: intComponents[0], minor: intComponents[1], patch: .zero)

            case 3:
                return Version(major: intComponents[0], minor: intComponents[1], patch: intComponents[2])

            default:
                return nil
        }
    }
}
