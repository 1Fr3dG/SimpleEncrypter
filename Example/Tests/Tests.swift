import UIKit
import XCTest
import SimpleEncrypter

class Tests: XCTestCase {
    
    /// time of encrypter runs for performance evaluation
    static let perfTimes = 5
    /// length of test data
    static let count: Int = 1024 * 128  // 128kb is the normal size for my file
    /// password/key for test encryption
    static let pwd: String = "passwordpassword"
    
    /// test data
    static var data = Data()
    /// temp var between encryption and decryption
    static var tmpdata = Data()
    
    override class func setUp() {
        data = Data(count: count)
        print("NOTE: This is for performance testing. If you need test compress ratio, remember that radom data CANNOT be compressed, you should change the data to what you have")
        data.withUnsafeMutableBytes { (buf: UnsafeMutablePointer<UInt8>) -> Void in
            arc4random_buf(buf, count)
        }
        print("Generating data for testing : [\(data)]")
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPerformanceEncrypterNone() {
        let encrypter = EncrypterNone(with: Tests.pwd)
        var _data = Data()
        self.measure {
            for _ in 0 ..< Tests.perfTimes {
                _data = encrypter.encrypt(Tests.data)
            
                _ = encrypter.decrypt(_data)
            }
        }
    }
    
    func testPerformanceEncrypterAES() {
        let encrypter = EncrypterAES(with: Tests.pwd)
        self.measure {
            for _ in 0 ..< Tests.perfTimes {
                Tests.tmpdata = encrypter.encrypt(Tests.data)
            }
        }
        print("[\(encrypter)] encrypted \(Tests.data) to \(Tests.tmpdata)")
    }
    
    func testPerformanceEncrypterAESDecrypt() {
        let encrypter = EncrypterAES(with: Tests.pwd)
        var _data = Data()
        self.measure {
            for _ in 0 ..< Tests.perfTimes {
                _data = encrypter.decrypt(Tests.tmpdata)
            }
        }
        print("[\(encrypter)] decrypted \(Tests.tmpdata) to \(_data)")
        
        XCTAssert(Tests.data.count == _data.count, "Decrypted data should be same size with original one")
        XCTAssert(Tests.data.bytes[2] == _data.bytes[2])
    }
    
    func testPerformanceEncrypterXor() {
        let encrypter = EncrypterXor(with: Tests.pwd)
        self.measure {
            for _ in 0 ..< Tests.perfTimes {
                Tests.tmpdata = encrypter.encrypt(Tests.data)
            }
        }
        print("[\(encrypter)] encrypted \(Tests.data) to \(Tests.tmpdata)")
    }
    
    func testPerformanceEncrypterXorDecrypt() {
        let encrypter = EncrypterXor(with: Tests.pwd)
        var _data = Data()
        self.measure {
            for _ in 0 ..< Tests.perfTimes {
                _data = encrypter.decrypt(Tests.tmpdata)
            }
        }
        print("[\(encrypter)] decrypted \(Tests.tmpdata) to \(_data)")
        
        XCTAssert(Tests.data.count == _data.count, "Decrypted data should be same size with original one")
        XCTAssert(Tests.data.bytes[2] == _data.bytes[2])
    }
    
    func testPerformanceCompressLZFSE() {
        let encrypter = EncrypterCompress(with: "lzfse")
        self.measure {
            for _ in 0 ..< Tests.perfTimes {
                Tests.tmpdata = encrypter.encrypt(Tests.data)
            }
        }
        print("[\(encrypter)] compressed \(Tests.data) to \(Tests.tmpdata)")
    }
    
    func testPerformanceCompressLZFSE_() {
        let encrypter = EncrypterCompress(with: "lzfse")
        var _data = Data()
        self.measure {
            for _ in 0 ..< Tests.perfTimes {
                _data = encrypter.decrypt(Tests.tmpdata)
            }
        }
        print("[\(encrypter)] decompressed \(Tests.tmpdata) to \(_data)")
        
        XCTAssert(Tests.data.count == _data.count, "Decompressed data should be same size with original one")
        XCTAssert(Tests.data.bytes[2] == _data.bytes[2])
    }
    
    func testPerformanceCompressLZ4() {
        let encrypter = EncrypterCompress(with: "lz4")
        self.measure {
            for _ in 0 ..< Tests.perfTimes {
                Tests.tmpdata = encrypter.encrypt(Tests.data)
            }
        }
        print("[\(encrypter)] compressed \(Tests.data) to \(Tests.tmpdata)")
    }
    
    func testPerformanceCompressLZ4_() {
        let encrypter = EncrypterCompress(with: "lz4")
        var _data = Data()
        self.measure {
            for _ in 0 ..< Tests.perfTimes {
                _data = encrypter.decrypt(Tests.tmpdata)
            }
        }
        print("[\(encrypter)] decompressed \(Tests.tmpdata) to \(_data)")
        
        XCTAssert(Tests.data.count == _data.count, "Decompressed data should be same size with original one")
        XCTAssert(Tests.data.bytes[2] == _data.bytes[2])
    }
    
    func testPerformanceCompressLZMA() {
        let encrypter = EncrypterCompress(with: "lzma")
        self.measure {
            for _ in 0 ..< Tests.perfTimes {
                Tests.tmpdata = encrypter.encrypt(Tests.data)
            }
        }
        print("[\(encrypter)] compressed \(Tests.data) to \(Tests.tmpdata)")
    }
    
    func testPerformanceCompressLZMA_() {
        let encrypter = EncrypterCompress(with: "lzma")
        var _data = Data()
        self.measure {
            for _ in 0 ..< Tests.perfTimes {
                _data = encrypter.decrypt(Tests.tmpdata)
            }
        }
        print("[\(encrypter)] decompressed \(Tests.tmpdata) to \(_data)")
        
        XCTAssert(Tests.data.count == _data.count, "Decompressed data should be same size with original one")
        XCTAssert(Tests.data.bytes[2] == _data.bytes[2])
    }
    
    func testPerformanceCompressZLIB() {
        let encrypter = EncrypterCompress(with: "zlib")
        self.measure {
            for _ in 0 ..< Tests.perfTimes {
                Tests.tmpdata = encrypter.encrypt(Tests.data)
            }
        }
        print("[\(encrypter)] compressed \(Tests.data) to \(Tests.tmpdata)")
    }
    
    func testPerformanceCompressZLIB_() {
        let encrypter = EncrypterCompress(with: "zlib")
        var _data = Data()
        self.measure {
            for _ in 0 ..< Tests.perfTimes {
                _data = encrypter.decrypt(Tests.tmpdata)
            }
        }
        print("[\(encrypter)] decompressed \(Tests.tmpdata) to \(_data)")
        
        XCTAssert(Tests.data.count == _data.count, "Decompressed data should be same size with original one")
        XCTAssert(Tests.data.bytes[2] == _data.bytes[2])
    }
}
