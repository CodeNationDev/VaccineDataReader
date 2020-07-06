// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VaccineDataReader",
    platforms: [
           // Add support for all platforms starting from a specific version.
        .iOS(.v12),
       ],
    products: [
        .library(
            name: "VaccineDataReader",
            targets: ["VaccineDataReader"]),
    ],
    dependencies: [
    .package(url: "https://github.com/tid-kijyun/Kanna.git", from: "5.2.2")
    ],
    targets: [
        .target(
            name: "VaccineDataReader",
            dependencies: ["Kanna"])
    ]
)
