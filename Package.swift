// swift-tools-version: 5.9
// SoundDeviceKit 0.2.0 — binary distribution. © 2026 MadeFX; see LICENSE and LICENSE-COMMERCIAL.md.
import PackageDescription

let package = Package(
    name: "SoundDeviceKit",
    platforms: [.iOS(.v15), .macOS(.v12)],
    products: [.library(name: "SoundDeviceKit", targets: ["SoundDeviceKit"])],
    targets: [
        .binaryTarget(
            name: "SoundDeviceKit",
            url: "https://github.com/madefx/SoundDeviceKit-Binary/releases/download/0.2.0/SoundDeviceKit-0.2.0.xcframework.zip",
            checksum: "508be9d7df1ab852a9117bd8f4a5733d49af7efebdeb5367cd6dbc504ccd7e75"
        ),
    ]
)
