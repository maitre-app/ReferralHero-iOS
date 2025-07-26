// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ReferralHero-iOS",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "ReferralHero-iOS",
            targets: ["ReferralHero-iOS"]),
    ],
    dependencies: [
        .package(url: "https://github.com/BranchMetrics/ios-branch-deep-linking-attribution.git", from: "2.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "ReferralHero-iOS",
            dependencies: [.product(name: "BranchSDK", package: "ios-branch-deep-linking-attribution")]),
    ]
)
