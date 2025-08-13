// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "KinovaCore",
    platforms: [
        .iOS("26.0"),
        .macOS("26.0"),
        .visionOS("26.0")
    ],
    products: [
        .library(
            name: "MoviesFeature",
            targets: ["MoviesFeature"]
        ),
    ],
    dependencies: [
      .package(
        url: "https://github.com/igorcamilo/tmdb-swift.git",
        from: "1.0.0"
      ),
      .package(
        url: "https://github.com/pointfreeco/swift-composable-architecture.git",
        from: "1.0.0"
      ),
    ],
    targets: [
        .target(
            name: "MoviesFeature",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                .product(name: "TMDB", package: "tmdb-swift")
            ],
        ),
        .testTarget(
            name: "MoviesFeatureTests",
            dependencies: ["MoviesFeature"]
        ),
    ]
)
