//
//  TestCalculator.swift
//  FractionOperationsTests
//
//  Created by Bence Hupp
//

import Foundation

final class TestCalculator: CalculatorProtocol {

    // Stubs
    static var stub_convertInfixToPostFix: (String) throws -> [String] = { _ in return ["", ""] }
    static var stub_calculateRPNResult: ([String]) throws -> Double = { _ in return 1.0 }

    // Protocol implementation
    static func convertInfixToPostFix(_ input: String) throws -> [String] {
        return try stub_convertInfixToPostFix(input)
    }

    static func calculateRPNResult(_ rpnString: [String]) throws -> Double {
        return try stub_calculateRPNResult(rpnString)
    }

    
}
