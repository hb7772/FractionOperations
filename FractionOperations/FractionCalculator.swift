//
//  FractionCalculator.swift
//  FractionOperations
//
//  Created by Bence Hupp
//

import Foundation

class FractionCalculator {
    private var output = [String]()
    private var operators = Stack<String>()
    private static let validOperatorsArrayWithPrecendce = ["+", "-", "*", "&", "/"]
    private static let validNumbersArray = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    private var consoleIO: ConsolIOProtocol

    init(consoleIO: ConsolIOProtocol) {
        self.consoleIO = consoleIO
    }

    func convertInfixToPostFix(_ input: String) -> [String]? {
        // handling error: empty input
        guard input != "" else { return nil }

        // handling white spaces
        var formattedInput = input.replacingOccurrences(of: "\\s+", with: "", options: .regularExpression)

        // handling '+', '-', '*', '&', '/' in the end of the string which makes no sense
        while formattedInput.last?.isNumber != true {
            if !formattedInput.isEmpty {
                formattedInput.removeLast()
            } else { return nil }
        }

        // handling negative and positive number in the beginning
        if formattedInput[formattedInput.startIndex] == "-" ||
            formattedInput[formattedInput.startIndex] == "+" {
            formattedInput.insert("0", at: formattedInput.startIndex)
        }

        for (index, item) in formattedInput.enumerated() {
            // Converting the character iterator type to string for better handling later on this scope
            let itemAsString = item.description

            // handling error: invalid characters, numbers
            guard Self.validOperatorsArrayWithPrecendce.contains(itemAsString) ||
                    Self.validNumbersArray.contains(itemAsString) else { return nil }

            // handling numbers repeating after each other and operators being next to each other
            if index.isMultiple(of: 2) {
                guard Self.validNumbersArray.contains(itemAsString) else { return nil }
            } else {
                guard Self.validOperatorsArrayWithPrecendce.contains(itemAsString) else { return nil }
            }


            // reverse polush notation starts here
            if Self.validNumbersArray.contains(itemAsString) {
                output.append(itemAsString)
            } else {
                if let peek = operators.peek() {
                    let indexOfCurrentOperator = Self.validOperatorsArrayWithPrecendce
                        .firstIndex(of: itemAsString)!
                        .advanced(by: 0)

                    let indexOfAlreadyStackedOperator = Self.validOperatorsArrayWithPrecendce
                        .firstIndex(of: peek)!
                        .advanced(by: 0)

                    if indexOfCurrentOperator <= indexOfAlreadyStackedOperator {
                        let tmp = operators.pop()!
                        output.append(tmp)
                    }
                }
                operators.push(itemAsString)
            }
        }

        // here we just went through the input, and handled lower precedence operators, now we need to empty the operator stack and move them to the output array
        while !operators.isEmpty {
            let tmp = operators.pop()!
            output.append(tmp)
        }
        return output
    }

    func calculateRPNResult(_ rpnString: [String]) -> Double {
        var result = 0.0
        var resultArray = rpnString

        for char in resultArray {
            if Self.validOperatorsArrayWithPrecendce.contains(char) {
                // prepare the operands
                // (here we can use force unwrap because we can be sure the current iterator is contained in the array
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
        // handle the output elegantly, maybe throwing an exception, or return nil result
        return Double(resultArray[0])!
    }



}
