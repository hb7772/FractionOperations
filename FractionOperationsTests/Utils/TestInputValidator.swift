//
//  TestInputValidator.swift
//  FractionOperations
//
//  Created by Bence Hupp on 2023. 05. 24..
//

import Foundation

class TestInputValidator: InputValidatorProtocol {
    // Stubs
    static var stub_validatingInput: (String) throws -> String = { _ in return "" }

    // Protocol implementation
    static var validOperatorsArrayWithPrecendce: [String] = ["+", "-", "*", "&", "/"]

    static var validNumbersArray: [String] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]

    static func validatingInput(_ input: String) throws -> String {
        return try stub_validatingInput(input)
    }

    
}
