// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "ExtentionsPlus",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .watchOS(.v8),
        .tvOS(.v15)
    ],
    products: [
        .library(
            name: "ExtentionsPlus",
            targets: ["ExtentionsPlus"]
        ),
    ],
    targets: [
        .target(
            name: "ExtentionsPlus",
            path: "Sources/ExtentionsPlus"
        ),
    ]
)
