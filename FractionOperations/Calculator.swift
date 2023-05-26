//
//  FractionCalculator.swift
//  FractionOperations
//
//  Created by Bence Hupp
//

import Foundation

protocol CalculatorProtocol {
    static func convertInfixToPostFix(_ input: String) throws -> [String]
    static func calculateRPNResult(_ rpnString: [String]) throws -> Double
}

class Calculator<InputValidator: InputValidatorProtocol>: CalculatorProtocol {
    // MARK: - Public methods
    static func convertInfixToPostFix(_ input: String) throws -> [String] {
        var output = [String]()
        var operators = Stack<String>()

        let validatedAndFormattedInput = try InputValidator.validateInputDirectlyFromUser(input)

        for (index, item) in validatedAndFormattedInput.enumerated() {
            // Converting the character iterator type to string for better handling later in this scope
            let itemAsString = item.description

            // handling error: invalid characters, numbers
            guard InputValidator.validateOperatorAndOperand(itemAsString) else {
                throw FractionOperationsErrors.invalidCharacters
            }

            // handling numbers repeating after each other and operators being next to each other
            if index.isMultiple(of: 2) {
                guard InputValidator.validNumbersArray.contains(itemAsString) else {
                    throw FractionOperationsErrors.moreThanOneOperatorBetweenOperands
                }
            } else {
                guard InputValidator.validOperatorsArray.contains(itemAsString) else {
                    throw FractionOperationsErrors.moreThanOneDigitNumberProvided
                }
            }

            // reverse polish notation starts here
            if InputValidator.validNumbersArray.contains(itemAsString) {
                output.append(itemAsString)
            } else {
                while let peek = operators.peek() {
                    var precedenceOfCurrentOperator: Int
                    var precedenceOfPeekOperatorOnStack: Int

                    // here we need to handle that if '&' character is to be compared, than it has higher precedence than every other operator except the '/', which repserents the fraction.
                    // hence if we deal with '&', I use a different precedence dictionary
                    if itemAsString == "&"  ||
                        peek == "&" {
                        precedenceOfCurrentOperator = InputValidator.precedenceWith_and_sign[itemAsString]!
                        precedenceOfPeekOperatorOnStack = InputValidator.precedenceWith_and_sign[peek]!
                    } else {
                        precedenceOfCurrentOperator = InputValidator.precedence[itemAsString]!
                        precedenceOfPeekOperatorOnStack = InputValidator.precedence[peek]!
                    }

                    if precedenceOfCurrentOperator <= precedenceOfPeekOperatorOnStack {
                        // force cast can be safely performed here, because we earlier checked the stack with peek()
                        let tmp = operators.pop()!
                        output.append(tmp)
                    } else {
                        break
                    }
                }
                operators.push(itemAsString)
            }
        }

        // here we just went through the input, and moved lower precedence operators into the output array, now we need to empty the operator stack and move them to the output array
        while !operators.isEmpty {
            let tmp = operators.pop()!
            output.append(tmp)
        }
        return output
    }

    static func calculateRPNResult(_ rpnString: [String]) throws -> Double {
        // handling invalid input characters here as well, if this method does not get a pre-validated input from convertInfixToPostFix
        guard InputValidator.validateRPNArray(rpnString) else {
            throw FractionOperationsErrors.invalidCharacters
        }

        var result = 0.0
        var resultArray = rpnString

        for char in resultArray {
            // we should start calculation when we find an operator. If we find operand, then we continue with iteration
            if InputValidator.validOperatorsArray.contains(char) {
                // prepare the operands
                // here we can use force unwrap because we can be sure the current value being held by the iterator is contained in the array
                let indexOfCurrentChar = resultArray.firstIndex(of: char)!
                let leftHandOperand = resultArray[indexOfCurrentChar - 2]
                let rightHandOperand = resultArray[indexOfCurrentChar - 1]

                let leftHand = Double(leftHandOperand)!
                let rightHand = Double(rightHandOperand)!

                // prepare and perform the operations
                switch char {
                case "+", "&":
                    result = leftHand + rightHand
                    break
                case "-":
                    result = leftHand - rightHand
                    break
                case "*":
                    result = leftHand * rightHand
                    break
                case "/":
                    result = leftHand / rightHand
                    break
                default:
                    // here we just break, because we already checked above whether the current character is a valid operator
                    break
                }
                // removing the 2 used operands and the operator from the array
                resultArray.removeSubrange(indexOfCurrentChar-2..<indexOfCurrentChar+1)

                // place the operation result into the array to the place where the leftHand operator was
                resultArray.insert(String(result), at: indexOfCurrentChar - 2)
            }
        }
        
        guard resultArray.count == 1,
              let result = Double(resultArray[0]) else {
            throw FractionOperationsErrors.reversePolishNotationResultError
        }

        return result
    }
}
