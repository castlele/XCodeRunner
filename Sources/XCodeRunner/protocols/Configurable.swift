public protocol Configurable {
    associatedtype Model

    func configure(with _: Model)
}
