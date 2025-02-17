// swift-tools-version: 6.0

// WARNING:
// This file is automatically generated.
// Do not edit it by hand because the contents will be replaced.

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "Blinky",
    platforms: [
        .iOS("16.0")
    ],
    products: [
        .iOSApplication(
            name: "Blinky",
            targets: ["AppModule"],
            bundleIdentifier: "com.moo.Blinky",
            teamIdentifier: "F7T7NU8578",
            displayVersion: "1.0",
            bundleVersion: "1",
            appIcon: .placeholder(icon: .sun),
            accentColor: .presetColor(.teal),
            supportedDeviceFamilies: [
                .pad,
                .phone
            ],
            supportedInterfaceOrientations: [
                .portrait,
                .landscapeRight,
                .landscapeLeft,
                .portraitUpsideDown(.when(deviceFamilies: [.pad]))
            ]
        )
    ],
    targets: [
        .executableTarget(
            name: "AppModule",
            path: "."
        )
    ],
    swiftLanguageVersions: [.v6]
)
