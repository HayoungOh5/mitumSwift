import CryptoSwift
import Foundation

// SHA3-256 해시 함수
func sha3_256(data: Data) -> Data {
    let sha3 = SHA3(variant: .sha256)
    let hashArray = sha3.calculate(for: Array(data))
    return Data(hashArray)  // Array<UInt8>을 Data로 변환
}