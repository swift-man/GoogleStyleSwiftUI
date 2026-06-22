// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "GoogleStyleSwiftUI",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "GoogleStyleSwiftUI",
            targets: ["GoogleStyleSwiftUI"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/swift-man/LimitLengthTextField", from: "0.7.0")
    ],
    targets: [
        .target(
            name: "GoogleStyleSwiftUI",
            dependencies: [
                .product(name: "LimitLengthTextField", package: "LimitLengthTextField")
            ],
            path: "Sources/GoogleStyleSwiftUI"
        ),
        .testTarget(
            name: "GoogleStyleSwiftUITests",
            dependencies: [
                "GoogleStyleSwiftUI"
            ],
            path: "Tests/GoogleStyleSwiftUITests"
        )
    ]
)
