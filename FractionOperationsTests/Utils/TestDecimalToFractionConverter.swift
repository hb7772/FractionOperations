//
//  TestDecimalToFractionConverter.swift
//  FractionOperationsTests
//
//  Created by Bence Hupp
//

import Foundation

final class TestDecimalToFractionConverter: DecimalToFractionConverterProtocol {

    // Stubs
    static var stub_greatestCommonDivider: (Int64, Int64) -> Int64 = { _, _ in return 10 }
    static var stub_convertDecimalToFraction: (Double) -> String = { _ in return "result" }

    // Protocol implementation
    static func greatestCommonDivider(_ num1: Int64, _ num2: Int64) -> Int64 {
        return stub_greatestCommonDivider(num1, num2)
    }

    static func convertDecimalToFraction(_ decimal: Double) -> String {
        return stub_convertDecimalToFraction(decimal)
    }
}
