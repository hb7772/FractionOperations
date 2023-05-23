//
//  FractionOperations.swift
//  FractionOperations
//
//  Created by Bence Hupp
//

import Foundation

class FractionOperations {
    var consoleIO: ConsolIOProtocol

    init(consoleIO: ConsolIOProtocol) {
        self.consoleIO = consoleIO
    }

    func staticMode() {
        consoleIO.printUsage()
    }

    func interactiveMode() {
        consoleIO.writeMessage("\nWelcome to Fraction Operations. This command line tool performs basic operations '+', '-, '*' and '/' on fractions as input, in interactive mode (continuously), and produces a fractional result. The user can quit the program by typing 'exit' and hitting enter. Have fun :)")

        var shouldQuit = false
        while !shouldQuit {
            let input = consoleIO.getInput()

            if input == "exit" {
                shouldQuit = true
                break
            }
            let calculator = FractionCalculator(consoleIO: consoleIO)

            guard let postfixInput = calculator.convertInfixToPostFix(input) else {
                consoleIO.writeMessage("So converting infix operations to postfix failed.", to: .error)
                continue
            }
            //consoleIO.writeMessage("\nThe result of the conversion: \(String(describing: postfixInput))")

            guard let decimalResult = calculator.calculateRPNResult(postfixInput) else {
                consoleIO.writeMessage("So calculating result from the Reverse Polish Notation array failed.", to: .error)
                continue
            }
            //consoleIO.writeMessage("\nThe result of the calculation decimal: \(String(describing: decimalResult))")

            let fractionResult = FractionConverter.calculateDecimalToFraction(decimalResult)
            consoleIO.writeMessage("\nThe result of the calculation decimal: \(String(describing: fractionResult))")
        }
    }
}
