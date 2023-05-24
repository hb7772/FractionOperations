//
//  FractionConverter.swift
//  FractionOperations
//
//  Created by Bence Hupp
//

import Foundation

class DecimalToFractionConverter {
    static let precision: Int64 = 1000000000

    static func greatestCommonDivider(_ num1: Int64, _ num2: Int64) -> Int64 {
        if num1 == 0 {
            return num2
        } else if num2 == 0 {
            return num1
        }

        if num1 < num2 {
            return greatestCommonDivider(num1, num2 % num1)
        } else {
            return greatestCommonDivider(num2, num1 % num2)
        }
    }

    static func calculateDecimalToFraction(_ decimal: Double) -> String {
        // copy the input to be able to modify it if necessary
        var number = decimal

        // negative numbers' floor and so fraction part are not calculated properly hence we need to handle the absolute value. negative sign will be put before the result later in this method
        if number < 0 {
            number *= -1
        }

        let integralPart = floor(number)
        let fractionPart = number - integralPart

        //if the user entered positive/negative integer values earlier or the calculation result has no fraction part
        if fractionPart == 0 { return decimal < 0 ? "-".appending(String(Int64(integralPart))) : String(Int64(integralPart)) }

        let integralEquivalentOfFraction = fractionPart * (Double(precision))
        let roundedIntegralEquivalent = integralEquivalentOfFraction.rounded()
        let convertedIntegralEquivalent = Int64(roundedIntegralEquivalent)

        let gcd = greatestCommonDivider(convertedIntegralEquivalent, precision)

        let num = convertedIntegralEquivalent / gcd
        let deno = precision / gcd

        // formatting the result in negative case or if the integral part is 0
        var resultString = ""
        if decimal < 0 { resultString.append("-") }
        if integralPart == 0 {
            resultString.append("\(num)/\(deno)")
        } else {
            resultString.append("\(Int64(integralPart))&\(num)/\(deno)")
        }

        return resultString
    }
}
