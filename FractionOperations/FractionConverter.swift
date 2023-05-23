//
//  FractionConverter.swift
//  FractionOperations
//
//  Created by Bence Hupp on 2023. 05. 22..
//

import Foundation

class FractionConverter {
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
        // copy the input to be able to modify it when it is negative
        var number = decimal
        if number < 0 {
            number *= -1
        }



        let integralPart = floor(number)
        let fractionPart = number - integralPart

        //handling if the user entered integer calues or the calculation result has no fraction part
        if fractionPart == 0 { return String(Int64(integralPart)) }

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