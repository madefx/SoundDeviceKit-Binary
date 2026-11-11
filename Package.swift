// swift-tools-version: 5.9
// SoundDeviceKit 0.1.1 — binary distribution. © 2026 MadeFX; see LICENSE and LICENSE-COMMERCIAL.md.
import PackageDescription

let package = Package(
    name: "SoundDeviceKit",
    platforms: [.iOS(.v15), .macOS(.v12)],
    products: [.library(name: "SoundDeviceKit", targets: ["SoundDeviceKit"])],
    targets: [
        .binaryTarget(
            name: "SoundDeviceKit",
            url: "https://api.github.com/repos/madefx/SoundDeviceKit-Binary/releases/assets/733803166.zip",
            checksum: "c59679277e05d73e8bf0a8b5916dba55c835ca50155c97640e291b86c1110b88"
        ),
    ]
)
