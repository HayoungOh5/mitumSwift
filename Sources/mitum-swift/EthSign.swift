import Foundation
import secp256k1

func ethSign(privateKeyHex: String, msg: Data) -> (publickey: String, sigBuffer: Data) {
    let privateBytes = try! privateKeyHex.bytes
    let privateKey = try! secp256k1.Signing.PrivateKey(dataRepresentation: privateBytes)

    let signature = try! privateKey.signature(for: msg).dataRepresentation
    let bigEndianData = Data(signature.reversed()) // Reverse to simulate Big-endian

    // signature를 r과 s로 나누기
    let midpoint = bigEndianData.count / 2
    let s = bigEndianData.prefix(midpoint)
    let r = bigEndianData.suffix(midpoint)

    var sigBuffer = Data()
    // // r의 길이를 4 바이트 리틀 엔디안 형식으로 기록합니다.
    var length = UInt32(r.count).littleEndian
    let lengthData = Data(bytes: &length, count: MemoryLayout<UInt32>.size)
    sigBuffer.append(lengthData)
    
    // r과 s를 sigBuffer에 추가합니다.
    sigBuffer.append(r)
    sigBuffer.append(s)

    // generate Public key
    let compressedKey = privateKey.publicKey.dataRepresentation
    let publickey = compressedKey.map { String(format: "%02x", $0) }.joined() + "fpu"
    
    return (publickey, sigBuffer)
}