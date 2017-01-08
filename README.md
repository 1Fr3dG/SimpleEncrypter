# SimpleEncrypter

[![CI Status](http://img.shields.io/travis/1Fr3dG/SimpleEncrypter.svg?style=flat)](https://travis-ci.org/1Fr3dG/SimpleEncrypter)
[![Version](https://img.shields.io/cocoapods/v/SimpleEncrypter.svg?style=flat)](http://cocoapods.org/pods/SimpleEncrypter)
[![License](https://img.shields.io/cocoapods/l/SimpleEncrypter.svg?style=flat)](http://cocoapods.org/pods/SimpleEncrypter)
[![Platform](https://img.shields.io/cocoapods/p/SimpleEncrypter.svg?style=flat)](http://cocoapods.org/pods/SimpleEncrypter)

一个简单的加密接口协议，便于在 app 中切换不同加密方法

a simple protocol for Data->Data encrypter used by my apps

## Example



## Requirements

* iOS 9.0+, OSX 10.11+

## Installation

#### CocoaPods

可通过[CocoaPods](http://cocoapods.org)安装：

SimpleEncrypter is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SimpleEncrypter"
```

#### Swift Package Manager

You can use [Swift Package Manager](https://swift.org/package-manager/) and specify dependency in `Package.swift` by adding this:

```swift
.Package(url: "https://github.com/1Fr3dG/SimpleEncrypter", majorVersion: 1)
```

NOTE: For now (Jan. 2017), swift build forces the osx.target.version to 10.10, so I build a special version to deal with that. This version support only gzip for compress.

```swift
.Package(url: "https://github.com/1Fr3dG/SimpleEncrypter", "0.3.0")
```


## Author

[Alfred Gao](http://alfredg.org), [alfredg@alfredg.cn](mailto:alfredg@alfredg.cn)

## License

SimpleEncrypter is available under the MIT license. See the LICENSE file for more info.
