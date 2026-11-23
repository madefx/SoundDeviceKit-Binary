# SoundDeviceKit (binary)

Connect iOS, macOS and Android apps to Bluetooth sound devices: SPL meters (Benetech dB-Tester protocol, Jansen
SmartBird; UNI-T UT353BT) and Zoom recorders (H3-VR with BTA-1: REC/STOP in sync, status, Mic Position, menu, Finder), plus
importing recordings over USB.

This repository distributes SoundDeviceKit for Apple platforms as a precompiled, single-module
`SoundDeviceKit.xcframework` (iOS 15+, iOS Simulator, macOS 12+), and for Android as Maven packages in its GitHub
Packages registry (Android 8.0+, see [Android](#android)). Current version: **0.2.0**.

© 2026 MadeFX. Free for noncommercial use under [PolyForm Noncommercial 1.0.0](LICENSE). **Commercial use
requires a signed license from MadeFX** ([LICENSE-COMMERCIAL.md](LICENSE-COMMERCIAL.md)), including use in free apps
published by a company. Downloading it is open to everyone; the license decides how you may use it.

## 1. Add the package

Xcode: **File › Add Package Dependencies…**, enter `https://github.com/madefx/SoundDeviceKit-Binary.git`, choose
**Up to Next Minor Version** from `0.2.0`, and add the `SoundDeviceKit` product to your app target.

Or in `Package.swift`:

```swift
.package(url: "https://github.com/madefx/SoundDeviceKit-Binary.git", .upToNextMinor(from: "0.2.0")),
// target dependency:
.product(name: "SoundDeviceKit", package: "SoundDeviceKit-Binary"),
```

Before 1.0, minor versions (0.1 → 0.2) may change the API; patch versions never do.

## 2. Configure the app

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

## Android

The Kotlin SDK has the same drivers and the same version number. Android 8.0+ (API 26), Kotlin 2.1, coroutines
and Flow.

1. **Token.** GitHub's Maven registry needs a token for every download, even of public packages. Create a
   **classic** token at <https://github.com/settings/tokens/new> with the `read:packages` scope and put it in
   `~/.gradle/gradle.properties` (never in the project):
   ```properties
   gpr.user=your-github-username
   gpr.key=ghp_…
   ```
2. **Registry**, in `settings.gradle.kts`:
   ```kotlin
   dependencyResolutionManagement {
       repositories {
           google()
           mavenCentral()
           maven {
               url = uri("https://maven.pkg.github.com/madefx/SoundDeviceKit-Binary")
               credentials {
                   username = providers.gradleProperty("gpr.user").get()
                   password = providers.gradleProperty("gpr.key").get()
               }
           }
       }
   }
   ```
3. **Dependency**, pinned to the exact version (before 1.0 a minor version may change the API):
   ```kotlin
   implementation("com.madefx.sounddevicekit:sounddevicekit:0.2.0")
   ```
   The app's `gradle.properties` needs `android.useAndroidX=true` (Android Studio projects have it already).

The SDK's manifest declares the Bluetooth permissions. At runtime, ask for `BLUETOOTH_SCAN` and
`BLUETOOTH_CONNECT` on Android 12+, or `ACCESS_FINE_LOCATION` on 8–11; `BLEPermissions.missing(context)` lists
the ones still missing. Everything is `suspend` or a `Flow`:

```kotlin
val manager = DeviceManager(context)
val result = manager.scan(onlySupported = true).first()
val device = manager.connect(result)
if (device is SoundLevelMeter) {
    device.readings().collect { println("${it.decibels} dB") }
}
```

`sounddevicekit` brings in every module; each is also its own package (`sounddevicekit-core`, `-ble`,
`-drivers-benetech`, `-drivers-unit`, `-drivers-zoom`, `-drivers-orb`, `-recording-import`, `-mock`). Each package ships its sources, so Android
Studio shows the API documentation, and carries `LICENSE` and `LICENSE-COMMERCIAL.md` under
`META-INF/<package>/`. The same license applies as for the Swift binary.
