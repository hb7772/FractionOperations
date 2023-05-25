//
//  FractionCalculator.swift
//  FractionOperations
//
//  Created by Bence Hupp
//

import Foundation

class Calculator<InputValidator: InputValidatorProtocol> {

    private var precedence = ["+" : 0,
                              "-" : 0,
                              "*" : 1,
                              "/" : 1]

    private var precedenceWith_and_sign = ["+" : 0,
                                           "-" : 0,
                                           "*" : 1,
                                           "&" : 2,
                                           "/" : 3]
    // MARK: - Public methods
    func convertInfixToPostFix(_ input: String) throws -> [String] {
        var output = [String]()
        var operators = Stack<String>()

        let validatedAndFormattedInput = try InputValidator.validatingInput(input)

        for (index, item) in validatedAndFormattedInput.enumerated() {
            // Converting the character iterator type to string for better handling later on this scope
            let itemAsString = item.description

            // handling error: invalid characters, numbers
            guard InputValidator.validOperatorsArray.contains(itemAsString) ||
                    InputValidator.validNumbersArray.contains(itemAsString) else {
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
                        precedenceOfCurrentOperator = precedenceWith_and_sign[itemAsString]!
                        precedenceOfPeekOperatorOnStack = precedenceWith_and_sign[peek]!
                    } else {
                        precedenceOfCurrentOperator = precedence[itemAsString]!
                        precedenceOfPeekOperatorOnStack = precedence[peek]!
                    }

                    if precedenceOfCurrentOperator <= precedenceOfPeekOperatorOnStack {
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

    func calculateRPNResult(_ rpnString: [String]) throws -> Double {
        var result = 0.0
        var resultArray = rpnString

        for char in resultArray {
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
