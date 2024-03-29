// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ReMVVMRxSwift",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "ReMVVMRxSwift",
            targets: ["ReMVVMRxSwift"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(
            url: "https://github.com/ReMVVM/ReMVVM", from: "3.0.0"
        ),
        //.package(path: "../ReMVVM"),
        .package(
            url: "https://github.com/ReactiveX/RxSwift",
            .upToNextMajor(from: "6.0.0")
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "ReMVVMRxSwift",
            dependencies: [
                "RxSwift",
                .product(name: "ReMVVMCore", package: "ReMVVM"),
            ],
            path: "Sources",
            exclude: [])
    ]
)
