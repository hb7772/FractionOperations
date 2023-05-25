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

    // MARK: - convertInfixToPostFix negative tests
    func testConvertInfixToPostFixThrowsErrorIfInputValidatorThrowsError() {
        // Arrange
        TestInputValidator.stub_validatingInput = { _ in throw FractionOperationsErrors.inputOnlyContainedOperatorsAsLastCharacter }

        // Act & Assert
        XCTAssertThrowsError(try calculator.convertInfixToPostFix("3 + q")) { error in
            XCTAssertEqual(error as! FractionOperationsErrors, FractionOperationsErrors.inputOnlyContainedOperatorsAsLastCharacter, "Test failed, because expected error type differs from the actual")
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

    // MARK: - convertInfixToPostFix positive tests
    func testConvertInfixToPostFixSucceedsIfItHasValidInputWithOnlyAddition() throws {
        // Arrange
        TestInputValidator.stub_validatingInput = { _ in return "1+2" }

        // Act
        let result = try calculator.convertInfixToPostFix("1+2")

        // Assert
        XCTAssertEqual(result, ["1", "2", "+"])
    }

    func testConvertInfixToPostFixSucceedsIfItHasValidInputWithMixedOperators() throws {
        // Arrange
        TestInputValidator.stub_validatingInput = { _ in return "1+2*4/3-9" }

        // Act
        let result = try calculator.convertInfixToPostFix("1+2*4/3-9")

        // Assert
        XCTAssertEqual(result, ["1", "2", "4", "*", "3", "/", "+", "9", "-"])
    }

    func testConvertInfixToPostFixSucceedsIfItHasValidInputWithMixedOperatorsAndTheSpecialOperator() throws {
        // Arrange
        TestInputValidator.stub_validatingInput = { _ in return "2/6+1&4/3-2" }

        // Act
        let result = try calculator.convertInfixToPostFix("2/6+1&4/3-2")

        // Assert
        XCTAssertEqual(result, ["2", "6", "/", "1", "4", "3", "/", "&", "+", "2", "-"])
    }

    func testConvertInfixToPostFixSucceedsIfItHasValidInputWithZeroInTheBeginning() throws {
        // Arrange
        TestInputValidator.stub_validatingInput = { _ in return "0-7/8+4&2/9" }

        // Act
        let result = try calculator.convertInfixToPostFix("0-7/8+4&2/9")

        // Assert
        XCTAssertEqual(result, ["0", "7", "8", "/", "-", "4", "2", "9", "/", "&", "+"])
    }

    // MARK: - calculateRPNResult tests
    func testcalculateRPNResultIfItHasBasicOperators() throws {
        // Arrange

        // Act
        let result = try calculator.calculateRPNResult(["3", "4", "+", "1", "2", "/", "9", "*", "-", "3", "-"])

        // Assert
        XCTAssertEqual(result, -0.5)
    }

    func testcalculateRPNResultIfItHasBasicAndSpecialOperators() throws {
        // Arrange

        // Act
        let result = try calculator.calculateRPNResult(["4", "7", "8", "/", "&", "5", "1", "2", "/", "&", "*", "9", "3", "6", "/", "&", "-", "3", "1", "4", "/", "&", "+"])

        // Assert
        XCTAssertEqual(result, 20.5625)
    }
}
