// swift-tools-version:6.1

import PackageDescription

let package = Package(
    name: "OpenAPIClient",
    platforms: [
        .iOS(.v18),
        .macOS(.v15),
        .tvOS(.v18),
        .watchOS(.v11),
        .visionOS(.v2),
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "legoAPIClient",
            targets: ["legoAPIClient"]
        )
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "legoAPIClient",
            dependencies: [],
            path: "Sources/legoAPIClient"
        )
    ],
    swiftLanguageModes: [.v6]
)
