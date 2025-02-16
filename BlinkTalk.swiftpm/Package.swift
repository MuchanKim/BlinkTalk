// swift-tools-version: 6.0

// WARNING:
// This file is automatically generated.
// Do not edit it by hand because the contents will be replaced.

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "BlinkTalk",
    platforms: [
        .iOS("16.0")
    ],
    products: [
        .iOSApplication(
            name: "BlinkTalk",
            targets: ["AppModule"],
            bundleIdentifier: "com.moo.BlinkTalk",
            teamIdentifier: "F7T7NU8578",
            displayVersion: "1.0",
            bundleVersion: "1",
            appIcon: .placeholder(icon: .boat),
            accentColor: .presetColor(.cyan),
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
