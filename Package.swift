// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Rebrickable-swift",
    platforms: [.macOS(.v15), .iOS(.v18), .tvOS(.v18), .watchOS(.v11), .visionOS(.v2)],
     dependencies: [
         .package(url: "https://github.com/apple/swift-openapi-generator", from: "1.10.0"),
         .package(url: "https://github.com/apple/swift-openapi-runtime", from: "1.8.0"),
         .package(url: "https://github.com/apple/swift-openapi-urlsession", from: "1.1.0"),
     ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "Rebrickable-swift",
            dependencies: [
                            .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                            .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
                        ],
                        plugins: [
                            .plugin(name: "OpenAPIGenerator", package: "swift-openapi-generator"),
                        ]
        ),
        .testTarget(
            name: "Rebrickable-swiftTests",
            dependencies: ["Rebrickable-swift"]
        ),
    ]
)
