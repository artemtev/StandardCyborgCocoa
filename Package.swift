// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "StandardCyborgCocoa",
    platforms: [
        .iOS(.v16), .macOS(.v12)
    ],
    products: [
        .library(
            name: "StandardCyborgFusion",
            type: .dynamic,
            targets: ["StandardCyborgFusion"]
        ),
        .library(
            name: "StandardCyborgUI",
            type: .dynamic,
            targets: ["StandardCyborgUI"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/ZipArchive/ZipArchive.git", from: "2.6.0"),
    ],
    targets: [
        // MARK: - StandardCyborgFusion
        .target(
            name: "StandardCyborgFusion",
            dependencies: [
                "json",
                "standard_cyborg",
                "PoissonRecon",
                .product(name: "ZipArchive", package: "ZipArchive"),
            ],
            path: "StandardCyborgFusion/Sources",
            publicHeadersPath: "include",
            cxxSettings: [
                .unsafeFlags(["-fobjc-arc", "-Os", "-fno-math-errno", "-ffast-math", "-std=c++17"]),
                .headerSearchPath("."),
                .headerSearchPath("../EigenInclude"),
                .headerSearchPath("../libigl/include"),
                .headerSearchPath("StandardCyborgFusion/Algorithm"),
                .headerSearchPath("StandardCyborgFusion/DataStructures"),
                .headerSearchPath("StandardCyborgFusion/EarLandmarking"),
                .headerSearchPath("StandardCyborgFusion/Helpers"),
                .headerSearchPath("StandardCyborgFusion/IO"),
                .headerSearchPath("StandardCyborgFusion/MetalDepthProcessor"),
                .headerSearchPath("StandardCyborgFusion/Private"),
                .headerSearchPath("include/StandardCyborgFusion"),
            ]
        ),

        // MARK: - StandardCyborgUI
        .target(
            name: "StandardCyborgUI",
            dependencies: [
                "StandardCyborgFusion",
            ],
            path: "StandardCyborgUI/StandardCyborgUI",
            sources: ["Sources"],
            resources: [
                .process("Resources")
            ],
            linkerSettings: [
                .linkedFramework("ARKit"),
                .linkedFramework("QuartzCore"),
                .linkedFramework("CoreVideo"),
            ]
        ),

        // MARK: - scsdk
        .target(
            name: "standard_cyborg",
            dependencies: [
                "happly", "json", "nanoflann", "PoissonRecon", "SparseICP", "stb", "tinygltf",
            ],
            path: "scsdk/Sources/standard_cyborg",
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

        // MARK: - CppDependencies
        .target(
            name: "json",
            path: "CppDependencies/json",
            publicHeadersPath: "include"
        ),
        .target(
            name: "happly",
            path: "CppDependencies/happly",
            publicHeadersPath: "include"
        ),
        .target(
            name: "nanoflann",
            path: "CppDependencies/nanoflann",
            publicHeadersPath: "include"
        ),
        .target(
            name: "SparseICP",
            path: "CppDependencies/SparseICP",
            publicHeadersPath: "include"
        ),
        .target(
            name: "stb",
            path: "CppDependencies/stb",
            publicHeadersPath: "include"
        ),
        .target(
            name: "tinygltf",
            path: "CppDependencies/tinygltf",
            publicHeadersPath: "include"
        ),
        .target(
            name: "PoissonRecon",
            path: "CppDependencies/PoissonRecon/Sources",
            publicHeadersPath: "include",
            cxxSettings: [
                .define("STD_LIB_FLAG"),
            ],
            linkerSettings: [
                .linkedFramework("Foundation"),
            ]
        ),
    ],
    swiftLanguageModes: [.v5],
    cxxLanguageStandard: .cxx17
)
