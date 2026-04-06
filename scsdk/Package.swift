// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "scsdk",
    platforms: [.iOS(.v16), .macOS(.v12)],
    products: [
        .library(
            name: "scsdk",
            targets: ["standard_cyborg"]
        ),
    ],
    dependencies: [
        .package(path: "../CppDependencies/json"),
        .package(path: "../CppDependencies/happly"),
        .package(path: "../CppDependencies/nanoflann"),
        .package(path: "../CppDependencies/SparseICP"),
        .package(path: "../CppDependencies/PoissonRecon"),
        .package(path: "../CppDependencies/stb"),
        .package(path: "../CppDependencies/tinygltf"),
    ],
    targets: [
        .target(
            name: "standard_cyborg",
            dependencies: [
                "happly", "json", "nanoflann", "PoissonRecon", "SparseICP", "stb", "tinygltf"
            ],
            path: "Sources/standard_cyborg",
            publicHeadersPath: "include",
            cxxSettings: [
                .unsafeFlags(["-fobjc-arc", "-Os", "-fno-math-errno", "-ffast-math", "-std=c++17"]),
                .define("FMT_HEADER_ONLY", to: "1", .when(platforms: [.iOS, .macOS])),
                .define("HAVE_CONFIG_H", to: "1", .when(platforms: [.iOS, .macOS])),
                .define("HAVE_PTHREAD", to: "1", .when(platforms: [.iOS, .macOS])),
                .define("GUID_LIBUUID", .when(platforms: [.iOS, .macOS])),
                .headerSearchPath("../../EigenInclude"),
            ]
        ),
    ],
    cxxLanguageStandard: .cxx17
)
