// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "naveridlogin-sdk-ios",
    products: [ .library(name: "naveridlogin-sdk-ios", targets: ["naveridlogin-sdk-ios"]), ],
    dependencies: [],
    targets: [
        .target(name: "naveridlogin-sdk-ios", dependencies: ["NaverThirdPartyLogin"]),
        .binaryTarget(name: "NaverThirdPartyLogin", path: "NaverThirdPartyLogin.xcframework"),
        .testTarget( name: "naveridlogin-sdk-iosTests", dependencies: ["naveridlogin-sdk-ios"] ),
    ]
)
