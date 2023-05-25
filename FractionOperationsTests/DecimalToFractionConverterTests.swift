//
//  DecimalToFractionConverterTests.swift
//  FractionOperationsTests
//
//  Created by Bence Hupp
//

import XCTest

final class DecimalToFractionConverterTests: XCTestCase {

    // MARK: - greatestCommonDivider tests
    func testDecimalToFractionConverterWhenOneIsTheGCD() {
        // Arrange

        // Act
        let result = DecimalToFractionConverter.greatestCommonDivider(5, 7)

        // Assert
        XCTAssertEqual(result, 1)
    }

    func testDecimalToFractionConverterWhenNum1IsZero() {
        // Arrange

        // Act
        let result = DecimalToFractionConverter.greatestCommonDivider(0, 20)

        // Assert
        XCTAssertEqual(result, 20)
    }

    func testDecimalToFractionConverterWhenNum2IsZero() {
        // Arrange

        // Act
        let result = DecimalToFractionConverter.greatestCommonDivider(11, 0)

        // Assert
        XCTAssertEqual(result, 11)
    }

    func testDecimalToFractionConverterWhenTheInputsAreEqual() {
        // Arrange

        // Act
        let result = DecimalToFractionConverter.greatestCommonDivider(15, 15)

        // Assert
        XCTAssertEqual(result, 15)
    }

    func testDecimalToFractionConverterWhenNum1IsLessThanNum2() {
        // Arrange

        // Act
        let result = DecimalToFractionConverter.greatestCommonDivider(15, 25)

        // Assert
        XCTAssertEqual(result, 5)
    }

    func testDecimalToFractionConverterWhenNum1IsBiggerThanNum2() {
        // Arrange

        // Act
        let result = DecimalToFractionConverter.greatestCommonDivider(42, 7)

        // Assert
        XCTAssertEqual(result, 7)
    }

    // MARK: - convertDecimalToFraction tests
    func testConvertDecimalToFractionWhenInputIsNegativeDecimal() {
        // Arrange

        // Act
        let result = DecimalToFractionConverter.convertDecimalToFraction(-0.25)

        // Assert
        XCTAssertEqual(result, "-1/4")
    }

    func testConvertDecimalToFractionWhenInputIsPositiveDecimal() {
        // Arrange

        // Act
        let result = DecimalToFractionConverter.convertDecimalToFraction(0.32)

        // Assert
        XCTAssertEqual(result, "8/25")
    }

    func testConvertDecimalToFractionWhenInputIsNegativeInteger() {
        // Arrange

        // Act
        let result = DecimalToFractionConverter.convertDecimalToFraction(-11)

        // Assert
        XCTAssertEqual(result, "-11")
    }

    func testConvertDecimalToFractionWhenInputIsPositiveInteger() {
        // Arrange

        // Act
        let result = DecimalToFractionConverter.convertDecimalToFraction(19)

        // Assert
        XCTAssertEqual(result, "19")
    }

}
