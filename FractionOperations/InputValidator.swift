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

    static func validatingInput(_ input: String) throws -> String
}

class InputValidator: InputValidatorProtocol {
    static let validOperatorsArray = ["+", "-", "*", "&", "/"]
    static let validNumbersArray = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]

    static func validatingInput(_ input: String) throws -> String {
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
}
