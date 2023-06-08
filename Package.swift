// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "SwiftUIProgrammaticNavigation",platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "SwiftUIProgrammaticNavigation",
            targets: ["SwiftUIProgrammaticNavigation"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "SwiftUIProgrammaticNavigation",
            dependencies: [],
            path: "Sources/SwiftUIProgrammaticNavigation/"
        ),
    ]
)
