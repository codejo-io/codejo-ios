// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Codejo",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "CodejoAPIService",
            targets: ["CodejoAPIService"]),
        .library(
            name: "CodejoExtensions",
            targets: ["CodejoExtensions"]),
        .library(
            name: "CodejoImageCache",
            targets: ["CodejoImageCache"]),
        .library(
            name: "CodejoKeyboardLayoutConstraint",
            targets: ["CodejoKeyboardLayoutConstraint"]),
        .library(
            name: "CodejoLocalStoreService",
            targets: ["CodejoLocalStoreService"]),
        .library(
            name: "CodejoUIKitExtensions",
            targets: ["CodejoUIKitExtensions"]),
        .library(
            name: "CodejoUISupport",
            targets: ["CodejoUISupport"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "CodejoAPIService",
            dependencies: []),
        .target(
            name: "CodejoExtensions",
            dependencies: []),
        .target(
            name: "CodejoImageCache",
            dependencies: []),
        .target(
            name: "CodejoKeyboardLayoutConstraint",
            dependencies: []),
        .target(
            name: "CodejoLocalStoreService",
            dependencies: []),
        .target(
            name: "CodejoUIKitExtensions",
            dependencies: []),
        .target(
            name: "CodejoUISupport",
            dependencies: []),
        .testTarget(
            name: "CodejoAPIServiceTests",
            dependencies: ["CodejoAPIService"]),
    ]
)
