// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FeatureAnalytics",
    platforms: [.iOS(.v16)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "FeatureAnalytics",
            targets: ["FeatureAnalytics"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.9.0"),
        .package(name: "Firebase", url: "https://github.com/firebase/firebase-ios-sdk.git", from: "10.24.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "FeatureAnalytics",
            dependencies: [
                .product(
                    name: "ComposableArchitecture",
                    package: "swift-composable-architecture"
                ),
                .product(name: "FirebaseAnalytics", package: "Firebase")
            ]),
        .testTarget(
            name: "FeatureAnalyticsTests",
            dependencies: ["FeatureAnalytics"]),
    ]
)
