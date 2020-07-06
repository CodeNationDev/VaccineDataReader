// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "VaccineDataReader",
    platforms: [
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
            dependencies: ["Kanna"],
            exclude: [
                "WebScavenging/*",
                "Sources/VaccineDataReader/VaccineData.h"
            ]
        )
    ]
)
