//
//  InputValidatorTests.swift
//  FractionOperationsTests
//
//  Created by Bence Hupp
//

import XCTest

final class InputValidatorTests: XCTestCase {

    // MARK: validateInputDirectlyFromUser tests
    func testValidateInputDirectlyFromUserWhenInputIsEmpty() {
        // Arrange

        // Act & Assert
        XCTAssertThrowsError(try InputValidator.validateInputDirectlyFromUser("")) { error in
            XCTAssertEqual(error as! FractionOperationsErrors, FractionOperationsErrors.emptyInput, "Test failed, because expected error type differs from the actual")
        }
    }

    func testValidateInputDirectlyFromUserWhenInputContainsWhiteSpaces() throws {
        // Arrange

        // Act
        let result = try InputValidator.validateInputDirectlyFromUser("    1  / 2 + 4 *    3+2     ")

        //Assert
        XCTAssertEqual("1/2+4*3+2", result)
    }

    func testValidateInputDirectlyFromUserWhenInputContainsAdditionOperatorInTheEnd() {
        // Arrange

        // Act & Assert
        XCTAssertThrowsError(try InputValidator.validateInputDirectlyFromUser("3+3+")) { error in
            XCTAssertEqual(error as! FractionOperationsErrors, FractionOperationsErrors.inputOnlyContainedOperatorsAsLastCharacter, "Test failed, because expected error type differs from the actual")
        }
    }

    func testValidateInputDirectlyFromUserWhenInputContainsSubtractionOperatorInTheEnd() {
        // Arrange

        // Act & Assert
        XCTAssertThrowsError(try InputValidator.validateInputDirectlyFromUser("3+3-")) { error in
            XCTAssertEqual(error as! FractionOperationsErrors, FractionOperationsErrors.inputOnlyContainedOperatorsAsLastCharacter, "Test failed, because expected error type differs from the actual")
        }
    }

    func testValidateInputDirectlyFromUserWhenInputContainsMultiplicationOperatorInTheEnd() {
        // Arrange

        // Act & Assert
        XCTAssertThrowsError(try InputValidator.validateInputDirectlyFromUser("3+3*")) { error in
            XCTAssertEqual(error as! FractionOperationsErrors, FractionOperationsErrors.inputOnlyContainedOperatorsAsLastCharacter, "Test failed, because expected error type differs from the actual")
        }
    }

    func testValidateInputDirectlyFromUserWhenInputContainsDivisionOperatorInTheEnd() {
        // Arrange

        // Act & Assert
        XCTAssertThrowsError(try InputValidator.validateInputDirectlyFromUser("3+3/")) { error in
            XCTAssertEqual(error as! FractionOperationsErrors, FractionOperationsErrors.inputOnlyContainedOperatorsAsLastCharacter, "Test failed, because expected error type differs from the actual")
        }
    }

    func testValidateInputDirectlyFromUserWhenInputContainsAndCharacterOperatorInTheEnd() {
        // Arrange

        // Act & Assert
        XCTAssertThrowsError(try InputValidator.validateInputDirectlyFromUser("3+3&")) { error in
            XCTAssertEqual(error as! FractionOperationsErrors, FractionOperationsErrors.inputOnlyContainedOperatorsAsLastCharacter, "Test failed, because expected error type differs from the actual")
        }
    }

    func testValidateInputDirectlyFromUserWhenInputContainsAdditionSignInTheBeginning() throws {
        // Arrange

        // Act
        let result = try InputValidator.validateInputDirectlyFromUser("+4*5")

        //Assert
        XCTAssertEqual("0+4*5", result)
    }

    func testValidateInputDirectlyFromUserWhenInputContainsSubtractionSignInTheBeginning() throws {
        // Arrange

        // Act
        let result = try InputValidator.validateInputDirectlyFromUser("-6+7")

        //Assert
        XCTAssertEqual("0-6+7", result)
    }

    // MARK: validateRPNArray test
    func testValidateRPNArrayWhenInputContainsOnlyValidNumbersAndOperators() {
        // Arrange

        // Act
        let result = InputValidator.validateRPNArray(["4", "5", "+", "2", "&", "/", "8", "*", "-", "3", "-"])

        //Assert
        XCTAssertTrue(result)
    }

    func testValidateRPNArrayWhenInputContainsInvalidCharacter() {
        // Arrange

        // Act
        let result = InputValidator.validateRPNArray(["4", "f", "+", "2", "1", "/", "8", "*", "-", "3", "-"])

        //Assert
        XCTAssertFalse(result)
    }

    // MARK: validateOperatorAndOperand test
    func testValidateOperatorAndOperandWhenInputContainsOnlyValidNumber4() {
        // Arrange

        // Act
        let result = InputValidator.validateOperatorAndOperand("4")

        //Assert
        XCTAssertTrue(result)
    }

    func testValidateOperatorAndOperandWhenInputContainsOnlyValidNumber7() {
        // Arrange

        // Act
        let result = InputValidator.validateOperatorAndOperand("7")

        //Assert
        XCTAssertTrue(result)
    }

    func testValidateOperatorAndOperandWhenInputContainsOnlyValidNumber0() {
        // Arrange

        // Act
        let result = InputValidator.validateOperatorAndOperand("0")

        //Assert
        XCTAssertTrue(result)
    }

    func testValidateOperatorAndOperandWhenInputContainsOnlyValidAdditionOperand() {
        // Arrange

        // Act
        let result = InputValidator.validateOperatorAndOperand("+")

        //Assert
        XCTAssertTrue(result)
    }

    func testValidateOperatorAndOperandWhenInputContainsOnlyValidSubtactionOperand() {
        // Arrange

        // Act
        let result = InputValidator.validateOperatorAndOperand("-")

        //Assert
        XCTAssertTrue(result)
    }

    func testValidateOperatorAndOperandWhenInputContainsOnlyValidMultiplicationOperand() {
        // Arrange

        // Act
        let result = InputValidator.validateOperatorAndOperand("*")

        //Assert
        XCTAssertTrue(result)
    }

    func testValidateOperatorAndOperandWhenInputContainsOnlyValidDivisionOperand() {
        // Arrange

        // Act
        let result = InputValidator.validateOperatorAndOperand("/")

        //Assert
        XCTAssertTrue(result)
    }

    func testValidateOperatorAndOperandWhenInputContainsOnlyValidAndOperand() {
        // Arrange

        // Act
        let result = InputValidator.validateOperatorAndOperand("&")

        //Assert
        XCTAssertTrue(result)
    }

    func testValidateOperatorAndOperandWhenInputContainsOnlyInvalidChar() {
        // Arrange

        // Act
        let result = InputValidator.validateOperatorAndOperand("t")

        //Assert
        XCTAssertFalse(result)
    }

    func testValidateOperatorAndOperandWhenInputContainsOnlyInvalidCharDotDotDot() {
        // Arrange

        // Act
        let result = InputValidator.validateOperatorAndOperand("…")

        //Assert
        XCTAssertFalse(result)
    }

    func testValidateOperatorAndOperandWhenInputContainsOnlyAnotherInvalidCharCharet() {
        // Arrange

        // Act
        let result = InputValidator.validateOperatorAndOperand("^")

        //Assert
        XCTAssertFalse(result)
    }
}
