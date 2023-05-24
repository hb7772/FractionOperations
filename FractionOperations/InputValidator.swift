//
//  InputValidator.swift
//  FractionOperations
//
//  Created by Bence Hupp
//

import Foundation

protocol InputValidatorProtocol {
    static var validOperatorsArrayWithPrecendce: [String] { get }
    static var validNumbersArray: [String] { get }

    static func validatingInput(_ input: String) throws -> String
}

class InputValidator: InputValidatorProtocol {
    static let validOperatorsArrayWithPrecendce = ["+", "-", "*", "&", "/"]
    static let validNumbersArray = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]

    static func validatingInput(_ input: String) throws -> String {
        // handling error: empty input
        guard input != "" else {
            throw FractionOperationsErrors.emptyInput
        }

        // handling white spaces
        var formattedInput = input.replacingOccurrences(of: "\\s+", with: "", options: .regularExpression)

        // removing '+', '-', '*', '&', '/' in the end of the string which makes no sense
        while
            formattedInput.last != nil,
            Self.validOperatorsArrayWithPrecendce.contains(formattedInput.last!.description) {
            formattedInput.removeLast()
        }

        // handling previusly emptied input, in case we only had operators which were completely removed from the input
        guard !formattedInput.isEmpty else {
            throw FractionOperationsErrors.inputOnlyContainedOperators
        }

        // handling negative and positive number in the beginning
        if formattedInput[formattedInput.startIndex] == "-" ||
            formattedInput[formattedInput.startIndex] == "+" {
            formattedInput.insert("0", at: formattedInput.startIndex)
        }

        return formattedInput
    }
}
