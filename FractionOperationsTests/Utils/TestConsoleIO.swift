//
//  TestConsoleIO.swift
//  FractionOperationsTests
//
//  Created by Bence Hupp
//

import Foundation

final class TestConsoleIO: ConsolIOProtocol {

    // Stubs
    var stub_printUsage: () -> Void = { return }
    var stub_getInput: () throws -> String = { return "" }
    var stub_writeMessage: (String, OutputType) -> Void = { _, _ in return }

    // Protocol implementation
    func printUsage() {
        return stub_printUsage()
    }

    func getInput() throws -> String {
        return try stub_getInput()
    }

    func writeMessage(_ message: String, to: OutputType) {
        return stub_writeMessage(message, to)
    }
}
