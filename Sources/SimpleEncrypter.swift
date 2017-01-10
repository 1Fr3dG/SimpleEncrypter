//
//  Encrypter.swift
//
//  Created by Alfred Gao on 2016/10/28.
//  Copyright © 2016年 Alfred Gao. All rights reserved.
//

import Foundation
import CryptoSwift
import SwiftCompressor
import Gzip

/// 数据加密协议
///
/// a simple protocol
public protocol SimpleEncrypter {
    var key: String { get }
    var description: String { get }
    init(with key: String)
    func encrypt(_ plaintext: Data) -> Data
    func decrypt(_ cyphertext: Data) -> Data
}

/// 不加密，此类主要用做占位符
///
/// do nothing, this class used for a spaceholder
public class EncrypterNone: NSObject, SimpleEncrypter {
    
    public let key: String
    required public init(with key: String) {
        self.key = key
    }
    
    override public var description: String {
        return "EncrypterNone"
    }
    
    public func encrypt(_ plaintext: Data) -> Data {
        return plaintext
    }
    public func decrypt(_ cyphertext: Data) -> Data {
        return cyphertext
    }
}

/// 压缩
///
/// Compress (not entrypt) data with same protocol
public class EncrypterCompress: NSObject, SimpleEncrypter {
    
    public var key: String
    
    /// - parameter with:
    ///     - 压缩算法
    ///     - compress algorithm
    ///     - "lz4"|"lzma"|zlib"|"lzfse"|"gzip", gzip is the default
    required public init(with key: String) {
        self.key = key.lowercased()
        if #available(iOS 9.0, OSX 10.11, watchOS 2.0, tvOS 9.0, *) {
            
        } else {
            if self.key != "gzip" {
                print("low version build system support gzip only")
                self.key = "gzip"
            }
        }
    }
    
    override public var description: String {
        return "EncrypterCompress: " + key
    }
    
    public func encrypt(_ plaintext: Data) -> Data {
        var cyphertext = Data()
        
        switch key {
        case "lz4":
            do {
                cyphertext = try plaintext.compress(algorithm: .lz4)!
            } catch {
            }
        case "lzma":
            do {
                cyphertext = try plaintext.compress(algorithm: .lzma)!
            } catch {
            }
        case "zlib":
            do {
                cyphertext = try plaintext.compress(algorithm: .zlib)!
            } catch {
            }
        case "lzfse":
            do {
                cyphertext = try plaintext.compress(algorithm: .lzfse)!
            } catch {
            }
        case "gzip":
            do {
                cyphertext = try plaintext.gzipped()
            } catch {
            }
        default:
            do {
                cyphertext = try plaintext.gzipped()
            } catch {
            }
        }
        
        return cyphertext
    }
    public func decrypt(_ cyphertext: Data) -> Data {
        var plaintext = Data()
        
        switch key {
        case "lz4":
            do {
                plaintext = try cyphertext.decompress(algorithm: .lz4)!
            } catch {
            }
        case "lzma":
            do {
                plaintext = try cyphertext.decompress(algorithm: .lzma)!
            } catch {
            }
        case "zlib":
            do {
                plaintext = try cyphertext.decompress(algorithm: .zlib)!
            } catch {
            }
        case "lzfse":
            do {
                plaintext = try cyphertext.decompress(algorithm: .lzfse)!
            } catch {
            }
        case "gzip":
            do {
                plaintext = try cyphertext.gunzipped()
            } catch {
            }
        default:
            do {
                plaintext = try cyphertext.gunzipped()
            } catch {
            }
        }
        
        return plaintext
    }
}

/// AES
public class EncrypterAES: NSObject, SimpleEncrypter {
    public let key: String
    
    override public var description: String {
        return "EncrypterAES"
    }
    
    let iv: String
    required public init(with key: String) {
        self.key = key
        iv = key.md5().substring(to: key.index(key.startIndex, offsetBy: 16))
    }
    
    public func encrypt(_ plaintext: Data) -> Data {
        var cyphertext = Data()
        do {
            cyphertext = try plaintext.encrypt(cipher: AES(key: key, iv: iv))
        } catch {
        }
        return cyphertext
    }
    public func decrypt(_ cyphertext: Data) -> Data {
        var plaintext = Data()
        do {
            plaintext = try cyphertext.decrypt(cipher: AES(key: key, iv: iv))
        } catch {
        }
        return plaintext
    }
}

/// XOR
///
/// 加密能力很弱，效果更像“混淆”。不过速度很快
///
/// Fast
public class EncrypterXor: NSObject, SimpleEncrypter {
    public let key: String
    
    override public var description: String {
        return "EncrypterXor"
    }
    
    let binarykey: Data
    required public init(with key: String) {
        self.key = key
        self.binarykey = key.data(using: .utf8)!.md5()
        super.init()
    }
    
    private func xor(inData: Data) -> Data {
        var xorData = inData
        
        xorData.withUnsafeMutableBytes { (start: UnsafeMutablePointer<UInt8>) -> Void in
            binarykey.withUnsafeBytes { (keyStart: UnsafePointer<UInt8>) -> Void in
                let b = UnsafeMutableBufferPointer<UInt8>(start: start, count: xorData.count)
                let k = UnsafeBufferPointer<UInt8>(start: keyStart, count: binarykey.count)
                let length = binarykey.count
                
                for i in 0..<xorData.count {
                    b[i] ^= k[i % length]
                }
            }
        }
        
        return xorData
    }
    
    public func encrypt(_ plaintext: Data) -> Data {
        return xor(inData: plaintext)
    }
    public func decrypt(_ cyphertext: Data) -> Data {
        return xor(inData: cyphertext)
    }
}
