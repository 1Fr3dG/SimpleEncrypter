# SimpleEncrypter

一个简单的加密接口协议，便于在 app 中切换不同加密方法

a simple protocol for Data->Data encrypter used by my apps


## Last

[![CI Status](http://img.shields.io/travis/1Fr3dG/SimpleEncrypter.svg?style=flat)](https://travis-ci.org/1Fr3dG/SimpleEncrypter)
[![Version](https://img.shields.io/cocoapods/v/SimpleEncrypter.svg?style=flat)](http://cocoapods.org/pods/SimpleEncrypter)
[![License](https://img.shields.io/cocoapods/l/SimpleEncrypter.svg?style=flat)](http://cocoapods.org/pods/SimpleEncrypter)
[![Platform](https://img.shields.io/cocoapods/p/SimpleEncrypter.svg?style=flat)](http://cocoapods.org/pods/SimpleEncrypter)

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