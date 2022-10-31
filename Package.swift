// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "XCodeRunner",
    platforms: [
        .macOS(.v12),
    ],
    products: [
        .executable(name: "xrunner", targets: ["XCodeRunner"])
    ],
    dependencies: [
        .package(url: "https://github.com/castlele/CLArgumentsParser.git", branch: "master")
    ],
    targets: [
        .executableTarget(name: "XCodeRunner", dependencies: ["CLArgumentsParser"]),
        .testTarget(name: "XCodeRunnerTests", dependencies: ["XCodeRunner"]),
    ]
)
