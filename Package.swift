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
            targets: ["StandardCyborgFusion"]
        ),
        .library(
            name: "StandardCyborgUI",
            targets: ["StandardCyborgUI"]
        ),
    ],
    dependencies: [],
    targets: [
        // MARK: - StandardCyborgFusion
        .target(
            name: "StandardCyborgFusion",
            dependencies: [
                "json",
                "standard_cyborg",
                "PoissonRecon",
            ],
            path: "StandardCyborgFusion/Sources",
            publicHeadersPath: "include",
            cxxSettings: [
                .unsafeFlags(["-fobjc-arc", "-Os", "-fno-math-errno", "-ffast-math", "-std=c++17"]),
                .headerSearchPath("."),
                .headerSearchPath("../EigenInclude"),
                .headerSearchPath("../libigl/include"),
                .headerSearchPath("../ZipArchiveShim"),
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
        // Each is a header-only C++ library with a dummy .m file to satisfy SPM's
        // requirement for at least one source file. The nested Package.swift (from
        // when these were standalone packages) must be excluded — SPM treats it as a
        // Swift source file, causing a mixed-language error alongside the ObjC .m file.
        .target(
            name: "json",
            path: "CppDependencies/json",
            exclude: ["Package.swift", ".swiftpm"],
            sources: ["spm_hack_generate_object_file.m"],
            publicHeadersPath: "include"
        ),
        .target(
            name: "happly",
            path: "CppDependencies/happly",
            exclude: ["Package.swift", ".swiftpm"],
            sources: ["spm_hack_generate_object_file.m"],
            publicHeadersPath: "include"
        ),
        .target(
            name: "nanoflann",
            path: "CppDependencies/nanoflann",
            exclude: ["Package.swift", ".swiftpm"],
            sources: ["spm_hack_generate_object_file.m"],
            publicHeadersPath: "include"
        ),
        .target(
            name: "SparseICP",
            path: "CppDependencies/SparseICP",
            exclude: ["Package.swift", ".swiftpm"],
            sources: ["spm_hack_generate_object_file.m"],
            publicHeadersPath: "include"
        ),
        .target(
            name: "stb",
            path: "CppDependencies/stb",
            exclude: ["Package.swift", ".swiftpm"],
            sources: ["spm_hack_generate_object_file.m"],
            publicHeadersPath: "include"
        ),
        .target(
            name: "tinygltf",
            path: "CppDependencies/tinygltf",
            exclude: ["Package.swift", ".swiftpm"],
            sources: ["spm_hack_generate_object_file.m"],
            publicHeadersPath: "include"
        ),
        .target(
            name: "PoissonRecon",
            path: "CppDependencies/PoissonRecon/Sources",
            exclude: ["src/PlyFile.cpp"],
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
