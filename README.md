# SoundDeviceKit (binary)

Connect iOS and macOS apps to Bluetooth sound devices: SPL meters (Benetech dB-Tester protocol, Jansen SmartBird)
and Zoom recorders (H3-VR with BTA-1: REC/STOP in sync, status, Mic Position, menu, Finder), plus importing
recordings over USB.

This repository distributes SoundDeviceKit as a precompiled, single-module `SoundDeviceKit.xcframework`
(iOS 15+, iOS Simulator, macOS 12+). Current version: **0.1.0**.

© 2026 MadeFX. Free for noncommercial use under [PolyForm Noncommercial 1.0.0](LICENSE). **Commercial use
requires a signed license from MadeFX** ([LICENSE-COMMERCIAL.md](LICENSE-COMMERCIAL.md)).

## 1. Get access

This repository is private. MadeFX adds your developers' GitHub accounts (read access). Each developer and each CI
machine then needs a GitHub token so Swift Package Manager can download the binary:

1. Create a token at <https://github.com/settings/tokens>: a **fine-grained** token with read-only *Contents* access
   to `madefx/SoundDeviceKit-Binary`, or a classic token with the `repo` scope.
2. Add it to `~/.netrc` (create the file if needed, then `chmod 600 ~/.netrc`):
   ```
   machine api.github.com
     login YOUR_GITHUB_USERNAME
     password YOUR_TOKEN
   ```
   Xcode and `swift build` read this file when downloading the binary. On CI, write the same file from a secret.
3. Make sure Git can clone the repository: sign in under **Xcode › Settings › Accounts › GitHub**, or use SSH.

## 2. Add the package

Xcode: **File › Add Package Dependencies…**, enter `https://github.com/madefx/SoundDeviceKit-Binary.git`, choose
**Up to Next Minor Version** from `0.1.0`, and add the `SoundDeviceKit` product to your app target.

Or in `Package.swift`:

```swift
.package(url: "https://github.com/madefx/SoundDeviceKit-Binary.git", .upToNextMinor(from: "0.1.0")),
// target dependency:
.product(name: "SoundDeviceKit", package: "SoundDeviceKit-Binary"),
```

Before 1.0, minor versions (0.1 → 0.2) may change the API; patch versions never do.

If the download fails with a 404 or "invalid archive", the token is missing, expired, or can't read this
repository.

## 3. Configure the app

- Add `NSBluetoothAlwaysUsageDescription` to Info.plist.
- For background connections, enable the `bluetooth-central` background mode and create the manager with
  `DeviceManager(central: BLECentral(restoreIdentifier: "…"))`.

```swift
import SoundDeviceKit

let manager = DeviceManager()
for await result in try await manager.scan(onlySupported: true) {
    let device = try await manager.connect(result)
    if let meter = device as? SoundLevelMeter {
        for await reading in meter.readings() { print(reading.decibels) }
    }
    break
}
```

## Documentation

Each [release](https://github.com/madefx/SoundDeviceKit-Binary/releases) has `SoundDeviceKit-<version>.doccarchive.zip`:
unzip it and double-click the archive to open the full API reference and the guides (installation, getting
started, Zoom H3-VR, USB import, licensing) in Xcode.

The release notes name the Xcode version used to build the binary. Use that Xcode or a newer one.
