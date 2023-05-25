//
//  InputValidatorTests.swift
//  FractionOperationsTests
//
//  Created by Bence Hupp on 2023. 05. 25..
//

import XCTest

final class InputValidatorTests: XCTestCase {

    func testInputValidatorWhenInputIsEmpty() {
        // Arrange

        // Act & Assert
        XCTAssertThrowsError(try InputValidator.validatingInput("")) { error in
            XCTAssertEqual(error as! FractionOperationsErrors, FractionOperationsErrors.emptyInput, "Test failed, because expected error type differs from the actual")
        }
    }

    func testInputValidatorWhenInputContainsWhiteSpaces() throws {
        // Arrange

        // Act
        let result = try InputValidator.validatingInput("    1  / 2 + 4 *    3+2     ")

        //Assert
        XCTAssertEqual("1/2+4*3+2", result)
    }

    func testInputValidatorWhenInputContainsAdditionOperatorInTheEnd() {
        // Arrange

        // Act & Assert
        XCTAssertThrowsError(try InputValidator.validatingInput("3+3+")) { error in
            XCTAssertEqual(error as! FractionOperationsErrors, FractionOperationsErrors.inputOnlyContainedOperatorsAsLastCharacter, "Test failed, because expected error type differs from the actual")
        }
    }

    func testInputValidatorWhenInputContainsSubtractionOperatorInTheEnd() {
        // Arrange

        // Act & Assert
        XCTAssertThrowsError(try InputValidator.validatingInput("3+3-")) { error in
            XCTAssertEqual(error as! FractionOperationsErrors, FractionOperationsErrors.inputOnlyContainedOperatorsAsLastCharacter, "Test failed, because expected error type differs from the actual")
        }
    }

    func testInputValidatorWhenInputContainsMultiplicationOperatorInTheEnd() {
        // Arrange

        // Act & Assert
        XCTAssertThrowsError(try InputValidator.validatingInput("3+3*")) { error in
            XCTAssertEqual(error as! FractionOperationsErrors, FractionOperationsErrors.inputOnlyContainedOperatorsAsLastCharacter, "Test failed, because expected error type differs from the actual")
        }
    }

    func testInputValidatorWhenInputContainsDivisionOperatorInTheEnd() {
        // Arrange

        // Act & Assert
        XCTAssertThrowsError(try InputValidator.validatingInput("3+3*")) { error in
            XCTAssertEqual(error as! FractionOperationsErrors, FractionOperationsErrors.inputOnlyContainedOperatorsAsLastCharacter, "Test failed, because expected error type differs from the actual")
        }
    }

    func testInputValidatorWhenInputContainsAndCharacterOperatorInTheEnd() {
        // Arrange

        // Act & Assert
        XCTAssertThrowsError(try InputValidator.validatingInput("3+3&")) { error in
            XCTAssertEqual(error as! FractionOperationsErrors, FractionOperationsErrors.inputOnlyContainedOperatorsAsLastCharacter, "Test failed, because expected error type differs from the actual")
        }
    }

    func testInputValidatorWhenInputContainsAdditionSignInTheBeginning() throws {
        // Arrange

        // Act
        let result = try InputValidator.validatingInput("+4*5")

        //Assert
        XCTAssertEqual("0+4*5", result)
    }

    func testInputValidatorWhenInputContainsSubtractionSignInTheBeginning() throws {
        // Arrange

        // Act
        let result = try InputValidator.validatingInput("-6+7")

        //Assert
        XCTAssertEqual("0-6+7", result)
    }
}
