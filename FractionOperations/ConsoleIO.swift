//
//  ConsoleIO.swift
//  FractionOperations
//
//  Created by Bence Hupp
//

import Foundation

enum OutputType {
  case error
  case standard
}

protocol ConsolIOProtocol {
    func writeMessage(_ message: String, to: OutputType)
    func printUsage()
    func getInput() -> String
}

extension ConsolIOProtocol {
    func writeMessage(_ message: String, to: OutputType = .standard) {
      switch to {
      case .standard:
          print("\u{001B}[;m\(message)")
      case .error:
          fputs("\u{001B}[0;31m\(message)\n", stderr)
      }
    }
}

class ConsoleIO: ConsolIOProtocol {
    func printUsage() {

      let executableName = (CommandLine.arguments[0] as NSString).lastPathComponent

      writeMessage("\nUSAGE:")
      writeMessage("-Type ./\(executableName) without an option to enter interactive mode\n-Then enter fractions, where the whole part is separated from the fraction part with the '&'\n-Legal operations: '+', '-', '*', '/' \n-Operands and operators shall be separated by one or more spaces\n-Improper fractions, whole numbers, and negative numbers are allowed as operands\n-If you want to quite type 'exit'")
    }

    func getInput() -> String {
      let keyboard = FileHandle.standardInput
      let inputData = keyboard.availableData
      let strData = String(data: inputData, encoding: String.Encoding.utf8)!
        return strData.trimmingCharacters(in: CharacterSet.newlines)
    }
}

