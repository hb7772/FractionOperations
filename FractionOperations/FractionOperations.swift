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
            var input: String
            do {
                input = try consoleIO.getInput()
            } catch let error as FractionOperationsErrors {
                consoleIO.writeMessage("Reading input from the console failed: \(error.errorInfo)", to: .error)
                continue
            } catch {
                consoleIO.writeMessage("Unexpected error occured during reading the input", to: .error)
                continue
            }

            if input == "exit" {
                shouldQuit = true
                break
            }
            let calculator = Calculator<InputValidator>()

            var postfixInput: [String]
            do {
                postfixInput = try calculator.convertInfixToPostFix(input)
            } catch let error as FractionOperationsErrors {
                consoleIO.writeMessage("Converting infix operations to postfix failed: \(error.errorInfo)", to: .error)
                continue
            } catch {
                consoleIO.writeMessage("Unexpected error occured during converting infix to postfix operation", to: .error)
                continue
            }
            //consoleIO.writeMessage("\nThe result of the conversion: \(String(describing: postfixInput))")

            var decimalResult: Double
            do {
                decimalResult = try calculator.calculateRPNResult(postfixInput)
            } catch let error as FractionOperationsErrors {
                consoleIO.writeMessage("Calculating result from the Reverse Polish Notation array failed: \(error.errorInfo)", to: .error)
                continue
            } catch {
                consoleIO.writeMessage("Unexpected error occured during calculating the reverse polish notation result", to: .error)
                continue
            }
            //consoleIO.writeMessage("\nThe result of the calculation decimal: \(String(describing: decimalResult))")

            let fractionResult = DecimalToFractionConverter.calculateDecimalToFraction(decimalResult)
            consoleIO.writeMessage("\nThe result of the calculation decimal: \(String(describing: fractionResult))")
        }
    }
}
