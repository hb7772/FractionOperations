//
//  FractionCalculatorTests.swift
//
//  Created by Bence Hupp
//

import XCTest

final class FractionCalculatorTests: XCTestCase {

    var calculator: Calculator<InputValidator>!


    override func setUp()  {
        calculator = Calculator()
    }

    override func tearDown()  {
        calculator = nil
    }

    func testCalc() {
        // Arrange

        // Act
        XCTAssertNoThrow(try calculator.calculateRPNResult(["3", "2", "-"]))
        // Assert
//        XCTAssertEqual(result, 1.0)
    }

}
