//
//  InputValidator.swift
//  FractionOperations
//
//  Created by Bence Hupp
//

import Foundation

protocol InputValidatorProtocol {
    static var validOperatorsArray: [String] { get }
    static var validNumbersArray: [String] { get }
    static var precedence: [String : Int] { get }
    static var precedenceWith_and_sign: [String : Int] { get }

    static func validateInputDirectlyFromUser(_ input: String) throws -> String
    static func validateRPNArray(_ input: [String]) -> Bool
    static func validateOperatorAndOperand(_ input: String) -> Bool
}

class InputValidator: InputValidatorProtocol {
    static let validOperatorsArray = ["+", "-", "*", "&", "/"]
    static let validNumbersArray = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
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
        // handling error: empty input
        guard input != "" else {
            throw FractionOperationsErrors.emptyInput
        }

        // handling white spaces, no error here, we just "trim" them be it anywhere
        var formattedInput = input.replacingOccurrences(of: "\\s+", with: "", options: .regularExpression)

        // handling error if '+', '-', '*', '&', '/' are in the end of the string
        if Self.validOperatorsArray.contains(formattedInput.last!.description) {
            throw FractionOperationsErrors.inputOnlyContainedOperatorsAsLastCharacter
        }

        // handling negative and positive number in the beginning
        if formattedInput[formattedInput.startIndex] == "-" ||
            formattedInput[formattedInput.startIndex] == "+" {
            formattedInput.insert("0", at: formattedInput.startIndex)
        }

        return formattedInput
    }

    static func validateRPNArray(_ input: [String]) -> Bool {
        for item in input {
            if Self.validateOperatorAndOperand(item) {
                continue
            } else {
                return false
            }
        }
        return true
    }


    static func validateOperatorAndOperand(_ input: String) -> Bool {
        return Self.validOperatorsArray.contains(input) ||
                        Self.validNumbersArray.contains(input)
    }
}
