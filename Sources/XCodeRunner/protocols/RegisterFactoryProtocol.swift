public protocol RegisterFactoryProtocol {
    associatedtype Item
    associatedtype ItemType

    var allCases: [ItemType] { get }

    func get() -> [Item]
}
