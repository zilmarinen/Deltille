// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Deltille",
    platforms: [.macOS(.v15),
                .iOS(.v17)],
    products: [
        .library(name: "Deltille",
                 targets: ["Deltille"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-collections.git",
                 branch: "main"),
        .package(url: "https://github.com/nicklockwood/Euclid.git",
                 branch: "main"),
    ],
    targets: [
        .target(name: "Deltille",
                dependencies: [.product(name: "Collections",
                                        package: "swift-collections"),
                               "Euclid"]),
        .testTarget(name: "DeltilleTests",
                    dependencies: [.product(name: "Collections",
                                            package: "swift-collections"),
                                   "Deltille",
                                   "Euclid"]),
    ]
)
