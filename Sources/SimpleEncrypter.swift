//
//  Encrypter.swift
//
//  Created by Alfred Gao on 2016/10/28.
//  Copyright © 2016年 Alfred Gao. All rights reserved.
//

import Foundation
import CryptoSwift
import Compression

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
    private var algorithm: compression_algorithm
    private var bufferSize: Int
    
    /// - parameter with:
    ///     - 压缩算法
    ///     - compress algorithm
    ///     - "lz4"|"lzma"|zlib"|"lzfse", lzfse is the default
    required public init(with key: String) {
        self.key = key.lowercased()
        
        switch key {
        case "lz4":
                algorithm = COMPRESSION_LZ4
        case "lzma":
                algorithm = COMPRESSION_LZMA
        case "zlib":
                algorithm = COMPRESSION_ZLIB
        case "lzfse":
                algorithm = COMPRESSION_LZFSE
        default:
                algorithm = COMPRESSION_LZFSE
        }
        
        bufferSize = 0x20000
    }
    
    override public var description: String {
        return "EncrypterCompress: " + key
    }
    
    private func processData(inputData: Data, compress: Bool) -> Data? {
        guard inputData.count > 0 else { return nil }
        
        var stream = UnsafeMutablePointer<compression_stream>.allocate(capacity: 1).pointee
        
        let initStatus = compression_stream_init(&stream, compress ? COMPRESSION_STREAM_ENCODE : COMPRESSION_STREAM_DECODE, algorithm)
        guard initStatus != COMPRESSION_STATUS_ERROR else {
            print("[Compression] \(compress ? "Compression" : "Decompression") with \(algorithm) failed to init stream with status \(initStatus).")
            return nil
        }
        
        defer {
            compression_stream_destroy(&stream)
        }
        
        stream.src_ptr = UnsafePointer<UInt8>(inputData.bytes)
        stream.src_size = inputData.count
        
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: bufferSize)
        stream.dst_ptr = buffer
        stream.dst_size = bufferSize
        var outputData = Data()
        
        while true {
            let status = compression_stream_process(&stream, Int32(compress ? COMPRESSION_STREAM_FINALIZE.rawValue : 0))
            if status == COMPRESSION_STATUS_OK {
                guard stream.dst_size == 0 else { continue }
                outputData.append(buffer, count: bufferSize)
                stream.dst_ptr = buffer
                stream.dst_size = bufferSize
            } else if status == COMPRESSION_STATUS_END {
                guard stream.dst_ptr > buffer else { continue }
                outputData.append(buffer, count: stream.dst_ptr - buffer)
                return outputData
            } else if status == COMPRESSION_STATUS_ERROR {
                print("[Compression] \(compress ? "Compression" : "Decompression") with \(algorithm) failed with status \(status).")
                return nil
            }
        }
    }
    
    public func encrypt(_ plaintext: Data) -> Data {
        var cyphertext = Data()
        
        cyphertext = processData(inputData: plaintext, compress: true)!
        
        return cyphertext
    }
    public func decrypt(_ cyphertext: Data) -> Data {
        var plaintext = Data()
        
        plaintext = processData(inputData: cyphertext, compress: false)!
        
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
        let keymd5 = key.md5()
        iv = String(keymd5[..<keymd5.index(keymd5.startIndex, offsetBy: 16)])
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
