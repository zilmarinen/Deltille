// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Deltille",
    platforms: [.macOS(.v12),
                .iOS(.v15)],
    products: [
        .library(
            name: "Deltille",
            targets: ["Deltille"]),
    ],
    dependencies: [
        .package(url: "git@github.com:nicklockwood/Euclid.git", branch: "main"),
    ],
    targets: [
        .target(
            name: "Deltille",
            dependencies: ["Euclid"]),
        .testTarget(
            name: "DeltilleTests",
            dependencies: ["Deltille"]),
    ]
)
