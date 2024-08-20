import Foundation

let privatekey = "27a4771cfd9c8fb25a8c261d912b83ee78315d4f9c980e68b1039cb51d496194fpr"
let jsonString = """
{
    "_hint": "mitum-currency-transfer-operation-v0.0.1",
    "fact": {
        "_hint": "mitum-currency-transfer-operation-fact-v0.0.1",
        "hash": "Cx7U7L8kPHnjFSMWaxS65jqxgp5RDc6tnY8pKikDTy33",
        "token": "MjAyNC0wOC0yMCAwNTo0MDo0Ny42MTQgKzAwMDAgVVRD",
        "sender": "0xa88fD796EE13ac305f376C54bdfe3270b883643cfca",
        "items": [
            {
                "_hint": "mitum-currency-transfer-item-multi-amounts-v0.0.1",
                "amounts": [
                    {
                        "_hint": "mitum-currency-amount-v0.0.1",
                        "currency": "FACT",
                        "amount": "10"
                    }
                ],
                "receiver": "0xe4bFD55fA9defd8b147Fdc18a55B43292f020C30fca"
            }
        ]
    },
    "hash": "",
    "signs": []
}
"""

// The escaped strings below are also valid.
// let jsonString = "{\"_hint\":\"mitum-currency-transfer-operation-v0.0.1\",\"fact\":{\"_hint\":\"mitum-currency-transfer-operation-fact-v0.0.1\",\"hash\":\"9opP1QQgrHNiuWPVXQf4SwAABrE4dA6XhEXTZWbz1sc4\",\"token\":\"MjAyNC0wOC0yMCAwNTo0OTozNS4wMzMgKzAwMDAgVVRD\",\"sender\":\"0xa88fD796EE13ac305f376C54bdfe3270b883643cfca\",\"items\":[{\"_hint\":\"mitum-currency-transfer-item-multi-amounts-v0.0.1\",\"amounts\":[{\"_hint\":\"mitum-currency-amount-v0.0.1\",\"currency\":\"FACT\",\"amount\":\"10\"}],\"receiver\":\"0x0A1D01167193Ac7f3E7b0a6Bb5ef92F6FCF5eC0ffca\"}]},\"hash\":\"\",\"signs\":[]}"

// JSON 문자열을 Data로 변환
guard let jsonData = jsonString.data(using: .utf8) else {
    fatalError("Failed to convert JSON string to Data")
}

do {
    if let operation = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
        let signedOperation = accSign(privateKey: privatekey, operation: operation)

        // 결과를 JSON 문자열로 변환
        let resultData = try JSONSerialization.data(withJSONObject: signedOperation, options: .prettyPrinted)
        if let resultString = String(data: resultData, encoding: .utf8) {
            print(resultString)
        } else {
            print("Failed to convert result Data to String")
        }
    } else {
        print("Failed to convert JSON Data to Dictionary")
    }
} catch {
    print("Error processing JSON: \(error)")
}