import Foundation
import Base58Swift

func accSign(privateKey: String, operation: [String: Any]) -> [String: Any] {
    let networkID = "mitum"
    let now = TimeStamp()

    // operation 딕셔너리에서 필요한 값 추출
    guard let factHashBase58 = (operation["fact"] as? [String: Any])?["hash"] as? String,
          let factHashData = Base58.base58Decode(factHashBase58) else {
        fatalError("Invalid operation data")
    }

    let privateKeyTrimmed = String(privateKey.prefix(privateKey.count - 3))

    let msgData = Data(networkID.utf8) + Data(factHashData) + Data(now.UTC().utf8)

    let signResult = ethSign(privateKeyHex: privateKeyTrimmed, msg: msgData)
    // publickey, 서명 생성
    let encodedSignature = Base58.base58Encode([UInt8] (signResult.sigBuffer))
    let publicKey = signResult.publickey

    var updatedOperation = operation
    updatedOperation["signs"] = [
        [
            "signer": publicKey,
            "signature": encodedSignature,
            "signed_at": now.ISO()
        ]
    ]
    
    guard let decodedSignature = Base58.base58Decode(encodedSignature) else {
        fatalError("Failed to decode signature")
    }
    let decodedSignatureData = Data(decodedSignature)

    // factSigns 계산
    let factSigns = Data(publicKey.utf8) + Data(decodedSignatureData) + Data(now.UTC().utf8)

    // msg 계산
    let msg = Data(factHashData) + factSigns

    // hash 계산
    let operationHash = Base58.base58Encode([UInt8] (sha3_256(data: msg)))
    updatedOperation["hash"] = operationHash

    return updatedOperation
}
