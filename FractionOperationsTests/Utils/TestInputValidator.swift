//
//  TestInputValidator.swift
//  FractionOperations
//
//  Created by Bence Hupp
//

import Foundation

final class TestInputValidator: InputValidatorProtocol {
    // Stubs
    static var stub_validateInputDirectlyFromUser: (String) throws -> String = { _ in return "" }
    static var stub_validateRPNArray: ([String]) -> Bool = { _ in return true }
    static var stub_validateOperatorAndOperand: (String) -> Bool = { _ in return true }

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

    static func validateInputDirectlyFromUser(_ input: String) throws -> String {
        return try stub_validateInputDirectlyFromUser(input)
    }

    static func validateRPNArray(_ input: [String]) -> Bool {
        return stub_validateRPNArray(input)
    }

    static func validateOperatorAndOperand(_ input: String) -> Bool {
        return stub_validateOperatorAndOperand(input)
    }
}
