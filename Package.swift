// swift-tools-version: 5.9
// SoundDeviceKit 0.1.2 — binary distribution. © 2026 MadeFX; see LICENSE and LICENSE-COMMERCIAL.md.
import PackageDescription

let package = Package(
    name: "SoundDeviceKit",
    platforms: [.iOS(.v15), .macOS(.v12)],
    products: [.library(name: "SoundDeviceKit", targets: ["SoundDeviceKit"])],
    targets: [
        .binaryTarget(
            name: "SoundDeviceKit",
            url: "https://api.github.com/repos/madefx/SoundDeviceKit-Binary/releases/assets/735493363.zip",
            checksum: "1131a3d2514887bafced5f60b38002cafc6677ddefed297615cd16a94efdb470"
        ),
    ]
)
