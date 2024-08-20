// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "mitum-swift",
    platforms: [
        .macOS(.v10_15), // 수정된 부분
    ],
    dependencies: [
        .package(url: "https://github.com/krzyzanowskim/CryptoSwift.git", from: "1.8.3"),
        .package(url: "https://github.com/21-DOT-DEV/swift-secp256k1.git", exact: "0.15.0"),
        .package(url: "https://github.com/keefertaylor/Base58Swift.git", from: "2.1.0"),
    ],
    targets: [
        .executableTarget(
            name: "mitum-swift",
            dependencies: [
                .product(name: "Base58Swift", package: "Base58Swift"),
                .product(name: "CryptoSwift", package: "CryptoSwift"),
                .product(name: "secp256k1", package: "swift-secp256k1"),
            ]
        ),
    ]
)
