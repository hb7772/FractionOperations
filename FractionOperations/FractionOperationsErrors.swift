//
//  FractionOperationsErrors.swift
//  FractionOperations
//
//  Created by Bence Hupp
//

import Foundation

enum FractionOperationsErrors: Error, Equatable {
    case emptyInput
    case inputOnlyContainedOperators
    case invalidCharacters
    case moreThanOneOperatorBetweenOperands
    case moreThanOneDigitNumberProvided
    case reversePolishNotationResultError

    var errorInfo: String {
        switch self {
        case .emptyInput:
            return "Empty input, please provide proper operators and operands"
        case .inputOnlyContainedOperators:
            return "The input only contained operators but not operands"
        case .invalidCharacters:
            return "Invalid characters were provided as input. Please only use decimal, 1 digit numbers and the following operators: '+', '-', '*', '/', '&'"
        case .moreThanOneOperatorBetweenOperands:
            return "More then one operator is given between two operands"
        case .moreThanOneDigitNumberProvided:
            return "More than one digit numbers were provided"
        case .reversePolishNotationResultError:
            return "More than 1 number remained in the result array, so the calculation did not succeed"
        }
    }
}
