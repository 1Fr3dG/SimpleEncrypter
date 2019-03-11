# SimpleEncrypter

一个简单的加密接口协议，便于在 app 中切换不同加密方法

a simple protocol for Data->Data encrypter used by my apps


## Last

[![CI Status](http://img.shields.io/travis/1Fr3dG/SimpleEncrypter.svg?style=flat)](https://travis-ci.org/1Fr3dG/SimpleEncrypter)
[![Version](https://img.shields.io/cocoapods/v/SimpleEncrypter.svg?style=flat)](http://cocoapods.org/pods/SimpleEncrypter)
[![License](https://img.shields.io/cocoapods/l/SimpleEncrypter.svg?style=flat)](http://cocoapods.org/pods/SimpleEncrypter)
[![Platform](https://img.shields.io/cocoapods/p/SimpleEncrypter.svg?style=flat)](http://cocoapods.org/pods/SimpleEncrypter)

* Modified spec to use the old swift_version method, since the new swift_versions really doesn't work. Even with cocoapods itself

~~~
>sudo gem install cocoapods --pre
Successfully installed cocoapods-1.7.0.beta.2
Parsing documentation for cocoapods-1.7.0.beta.2
Done installing documentation for cocoapods after 2 seconds
1 gem installed


>pod lib lint

 -> SimpleEncrypter (1.4.0)
    - WARN  | swift: The validator used Swift `4.0` by default because no Swift version was specified. To specify a Swift version during validation, add the `swift_versions` attribute in your podspec. Note that usage of a `.swift-version` file is now deprecated.
    - NOTE  | xcodebuild:  note: Using new build system
    - NOTE  | xcodebuild:  note: Planning build
    - NOTE  | xcodebuild:  note: Constructing build description
    - NOTE  | [iOS] xcodebuild:  warning: Skipping code signing because the target does not have an Info.plist file. (in target 'App')

[!] SimpleEncrypter did not pass validation, due to 1 warning (but you can use `--allow-warnings` to ignore it).
You can use the `--no-clean` option to inspect any issue.


>pod trunk push

[!] Found podspec `SimpleEncrypter.podspec`
Updating spec repo `master`
Validating podspec
 -> SimpleEncrypter (1.4.0)
    - NOTE  | xcodebuild:  note: Using new build system
    - NOTE  | xcodebuild:  note: Planning build
    - NOTE  | xcodebuild:  note: Constructing build description
    - NOTE  | [iOS] xcodebuild:  warning: Skipping code signing because the target does not have an Info.plist file. (in target 'App')

[!] The Pod Specification did not pass validation.
The following validation failed:
- Warnings: Unrecognized `swift_versions` key.
~~~

## 1.4.0
* upgrade to Swift 4.2

## 1.3
* upgrade to Swift 4
* default compress algorithm changed to LZFSE
* gzip compress algorithm removed

## 1.1.2

* add description definition to protocol

## 1.1.1

* override description

## 0.3.2

* override description

## 1.1.0

* add gzip support

## 0.3.1
* fix bug: used zip() for unzip function

## 1.0.1
* add info about spm

## 0.3.0

* add spm support
* special version build to deal with swift build forces osx target version to 10.10
	* remove native [Data Compression](https://developer.apple.com/reference/compression/1665429-data_compression) support
	* provide only gzip for compress

## 1.0.0
Moved from my last project.