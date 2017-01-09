import PackageDescription

let package = Package(
    name: "SimpleEncrypter",
    dependencies: [
        //.Package(url: "https://cocoapods.org/pods/SwiftCompressor", majorVersion: 0),
        .Package(url: "https://github.com/1024jp/GzipSwift", majorVersion: 3),
        .Package(url: "https://github.com/krzyzanowskim/CryptoSwift.git", majorVersion: 0)
    ]
)
