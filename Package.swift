// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Naqqash",
    products: [
        .library(
            name: "Naqqash",
            targets: ["Naqqash"]),
    ],
    targets: [
        .target(
            name: "Naqqash",
            dependencies: []),
        .testTarget(
            name: "NaqqashTests",
            dependencies: ["Naqqash"]),
    ]
)
