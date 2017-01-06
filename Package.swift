import PackageDescription

let package = Package(
    name: "SimpleEncrypter",
    dependencies: [
        .Package(url: "https://github.com/1Fr3dG/SwiftCompressor", majorVersion: 0),
        .Package(url: "https://github.com/krzyzanowskim/CryptoSwift.git", majorVersion: 0)
    ]
)
