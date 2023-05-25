//
//  TestInputValidator.swift
//  FractionOperations
//
//  Created by Bence Hupp
//

import Foundation

final class TestInputValidator: InputValidatorProtocol {
    // Stubs
    static var stub_validatingInput: (String) throws -> String = { _ in return "" }

    // Protocol implementation
    static var validOperatorsArray: [String] = ["+", "-", "*", "&", "/"]
    static var validNumbersArray: [String] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    static let precedence = ["+" : 0,
                             "-" : 0,
                             "*" : 1,
                             "/" : 1]
    static let precedenceWith_and_sign = ["+" : 0,
                                          "-" : 0,
                                          "*" : 1,
                                          "&" : 2,
                                          "/" : 3]

    static func validatingInput(_ input: String) throws -> String {
        return try stub_validatingInput(input)
    }

    
}
