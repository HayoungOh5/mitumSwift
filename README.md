# MitumSwift

MitumSwift is a tool for signing Mitum operations (transactions) using ECDSA with a private key. It takes a JSON string as input, signs the operation with the private key, and returns the signed operation in JSON format. Despite the mutable nature of operations, the tool ensures that signing is possible.

## Features

- Sign Mitum operations (transactions) using ECDSA.
- Accepts operations in JSON string format.
- Returns signed operations in JSON format.
- Handles operations with a mutable structure.

## Requirements

- Swift : 5.9 or higher (check command: `swift --version`)
- Xcode : 15.2 or later (check command: `xcodebuild -version`)

## Setup

**Clone the repository:**

```sh
git clone https://github.com/HayoungOh5/mitumSwift.git
cd mitumSwift
```

## Building the Project

To build the project, run:
``` sh
swift build
```

This will compile the code and prepare it for execution.


## Running the Project

```sh
swift run
```

## Example Usage

When you run the program, it will execute `main.swift`. In `main.swift`, you need to provide the following inputs:

- `privatekey`: The private key used to sign the operation. This must correspond to the operation sender's account.
- `jsonString`: The JSON string representing the Mitum operation to be signed. 

    You can provide the jsonString in two formats:
    1. **Formatted with New Lines:**
    ```swift
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
    ```


    2. **Escaped String Format:**
    ```swift
    let jsonString = "{\"_hint\":\"mitum-currency-transfer-operation-v0.0.1\",\"fact\":{\"_hint\":\"mitum-currency-transfer-operation-fact-v0.0.1\",\"hash\":\"Cx7U7L8kPHnjFSMWaxS65jqxgp5RDc6tnY8pKikDTy33\",\"token\":\"MjAyNC0wOC0yMCAwNTo0MDo0Ny42MTQgKzAwMDAgVVRD\",\"sender\":\"0xa88fD796EE13ac305f376C54bdfe3270b883643cfca\",\"items\":[{\"_hint\":\"mitum-currency-transfer-item-multi-amounts-v0.0.1\",\"amounts\":[{\"_hint\":\"mitum-currency-amount-v0.0.1\",\"currency\":\"FACT\",\"amount\":\"10\"}],\"receiver\":\"0xe4bFD55fA9defd8b147Fdc18a55B43292f020C30fca\"}]},\"hash\":\"\",\"signs\":[]}"
    ```

### Important Notes

- Ensure that the `privatekey` is valid for account of sender of operation you provide. The program does not perform validation to check if the privatekey is correct.