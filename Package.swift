// swift-tools-version: 6.3.3

import PackageDescription

let package = Package(
    name: "swift-http-cookies",
    platforms: [
        .macOS("27"),
        .iOS("27"),
        .tvOS("27"),
        .watchOS("27"),
        .visionOS("27"),
    ],
    products: [
        .library(
            name: "HTTP Cookies",
            targets: ["HTTP Cookies"]
        )
    ],
    targets: [
        .target(name: "HTTP Cookies"),
        .testTarget(
            name: "HTTP Cookies Tests",
            dependencies: ["HTTP Cookies"]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    target.swiftSettings =
        (target.swiftSettings ?? []) + [
            .strictMemorySafety(),
            .enableUpcomingFeature("ExistentialAny"),
            .enableUpcomingFeature("InternalImportsByDefault"),
            .enableUpcomingFeature("MemberImportVisibility"),
            .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
            .enableExperimentalFeature("LifetimeDependence"),
            .enableExperimentalFeature("Lifetimes"),
            .enableExperimentalFeature("SuppressedAssociatedTypes"),
            .enableUpcomingFeature("InferIsolatedConformances"),
        ]
}
