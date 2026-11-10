// swift-tools-version: 5.9
// SoundDeviceKit 0.1.0 — binary distribution. © 2026 MadeFX; see LICENSE and LICENSE-COMMERCIAL.md.
import PackageDescription

let package = Package(
    name: "SoundDeviceKit",
    platforms: [.iOS(.v15), .macOS(.v12)],
    products: [.library(name: "SoundDeviceKit", targets: ["SoundDeviceKit"])],
    targets: [
        .binaryTarget(
            name: "SoundDeviceKit",
            url: "https://api.github.com/repos/madefx/SoundDeviceKit-Binary/releases/assets/733216203.zip",
            checksum: "3f5b180888587ad2cf3d36e9be315e7eeb176dfe88a435ef65cb2573f9aeb955"
        ),
    ]
)
