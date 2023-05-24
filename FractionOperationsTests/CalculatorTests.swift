//
//  CalculatorTests.swift
//
//  Created by Bence Hupp
//

import XCTest

final class CalculatorTests: XCTestCase {

    var calculator: Calculator<TestInputValidator>!


    override func setUp()  {
        calculator = Calculator()
    }

    override func tearDown()  {
        calculator = nil
    }

    // MARK: - Negative tests
    func testConvertInfixToPostFixThrowsErrorIfInputValidatorThrowsError() {
        // Arrange
        TestInputValidator.stub_validatingInput = { _ in throw FractionOperationsErrors.inputOnlyContainedOperators }

        // Act & Assert
        XCTAssertThrowsError(try calculator.convertInfixToPostFix("3 + q")) { error in
            XCTAssertEqual(error as! FractionOperationsErrors, FractionOperationsErrors.inputOnlyContainedOperators, "Test failed, because expected error type differs from the actual")
        }
    }

    func testConvertInfixToPostFixThrowsErrorIfInputIsNotAValidOperator() {
        // Arrange
        TestInputValidator.stub_validatingInput = { _ in return "1q2" }

        // Act & Assert
        XCTAssertThrowsError(try calculator.convertInfixToPostFix("+1q2")) { error in
            XCTAssertEqual(error as! FractionOperationsErrors, FractionOperationsErrors.invalidCharacters, "Test failed, because expected error type differs from the actual")
        }
    }

    func testConvertInfixToPostFixThrowsErrorIfInputIsNotAValidNumber() {
        // Arrange
        TestInputValidator.stub_validatingInput = { _ in return "s+d" }

        // Act & Assert
        XCTAssertThrowsError(try calculator.convertInfixToPostFix("+s+d")) { error in
            XCTAssertEqual(error as! FractionOperationsErrors, FractionOperationsErrors.invalidCharacters, "Test failed, because expected error type differs from the actual")
        }
    }

    func testConvertInfixToPostFixThrowsErrorIfInputHasMoreThenOneDigitNumber() {
        // Arrange
        TestInputValidator.stub_validatingInput = { _ in return "11+2" }

        // Act & Assert
        XCTAssertThrowsError(try calculator.convertInfixToPostFix("+11+2")) { error in
            XCTAssertEqual(error as! FractionOperationsErrors, FractionOperationsErrors.moreThanOneDigitNumberProvided, "Test failed, because expected error type differs from the actual")
        }
    }

    func testConvertInfixToPostFixThrowsErrorIfInputHasMoreThenOneOperatorsNextToEachOther() {
        // Arrange
        TestInputValidator.stub_validatingInput = { _ in return "1++2" }

        // Act & Assert
        XCTAssertThrowsError(try calculator.convertInfixToPostFix("+1++2")) { error in
            XCTAssertEqual(error as! FractionOperationsErrors, FractionOperationsErrors.moreThanOneOperatorBetweenOperands, "Test failed, because expected error type differs from the actual")
        }
    }

    // MARK: - Positive tests
    func testConvertInfixToPostFixSucceedsIfItHasValidInput() throws {
        // Arrange
        TestInputValidator.stub_validatingInput = { _ in return "1+2" }

        // Act
        let result = try calculator.convertInfixToPostFix("1+2")

        // Assert
        XCTAssertEqual(result, ["1", "2", "+"])
    }

    func testConvertInfixToPostFixSucceedsIfItHasAnotherValidInput() throws {
        // Arrange
        TestInputValidator.stub_validatingInput = { _ in return "1+2*4/3-9" }

        // Act
        let result = try calculator.convertInfixToPostFix("1+2")

        // Assert
        XCTAssertEqual(result, ["1", "2", "4", "3", "/", "9", "-", "*", "+"])
    }

}
