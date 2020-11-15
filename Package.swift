// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Chunky",
    platforms: [
        .iOS( "13.4" ),
        .macOS( "10.15.4" )
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Chunky",
            targets: ["Chunky"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Chunky",
            dependencies: []),
        .testTarget(
            name: "ChunkyTests",
            dependencies: ["Chunky"]),
    ]
)
