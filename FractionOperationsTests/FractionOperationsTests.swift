//
//  FractionOperationsTests.swift
//  FractionOperationsTests
//
//  Created by Bence Hupp
//

import XCTest

final class FractionOperationsTests: XCTestCase {

    var consoleIO: TestConsoleIO!
    var fractionOperations: FractionOperations<TestDecimalToFractionConverter, TestCalculator>!

    override func setUp() {
        consoleIO = TestConsoleIO()
        fractionOperations = FractionOperations(consoleIO: consoleIO)
    }

    override func tearDown() {
        consoleIO = nil
        fractionOperations = nil
        TestConsoleIO.stub_inputCycleCount = 0
    }

    func testPrintUsageIsCalledWhenStaticModeIsInvoked() {
        // Arrange
        let expectation = XCTestExpectation(description: "consoleIO.printUsage() is called when staticMode is invoked")
        consoleIO.stub_printUsage = { expectation.fulfill() }

        // Act
        fractionOperations.staticMode()

        // Assert
        wait(for: [expectation], timeout: 2)
    }

    func testGetInputIsCalledWhenInteractiveModeIsInvokedAndExitEntered() {
        // Arrange
        let expectation = XCTestExpectation(description: "consoleIO.GetInput() is called when interactiveMode() is invoked and the input is 'exit'")
        consoleIO.stub_getInput = {
            expectation.fulfill()
            return "exit"
        }

        // Act
        fractionOperations.interactiveMode()

        // Assert
        wait(for: [expectation], timeout: 2)
    }

    func testGetInputIsCalledWhenInteractiveModeIsInvokedAndValidInputEntered() {
        // Arrange
        let expectation = XCTestExpectation(description: "consoleIO.GetInput() is called when interactiveMode() is invoked and the input is 'exit'")
        consoleIO.stub_getInput = {
            if TestConsoleIO.stub_inputCycleCount < 3 {
                TestConsoleIO.stub_inputCycleCount += 1
                expectation.fulfill()
                return "4*1/2"
            }
            return "exit"
        }

        // Act
        fractionOperations.interactiveMode()

        // Assert
        self.wait(for: [expectation], timeout: 2)
    }

    func testWhenGetInputThrowsThenExitIsEntered() {
        // Arrange
        consoleIO.stub_getInput = {
            if TestConsoleIO.stub_inputCycleCount < 1 {
                TestConsoleIO.stub_inputCycleCount += 1
                throw FractionOperationsErrors.invalidCharacters
            }
            return "exit"
        }

        let convertInfixToPostFixNotCalledExpectation = XCTestExpectation(description: "calculator.convertInfixToPostFix is not invoked")
        convertInfixToPostFixNotCalledExpectation.isInverted = true
        TestCalculator.stub_convertInfixToPostFix = { _ in
            convertInfixToPostFixNotCalledExpectation.fulfill()
            return []
        }

        let calculateRPNResultNotCalledExpectation = XCTestExpectation(description: "calculator.calculateRPNResult is not invoked")
        calculateRPNResultNotCalledExpectation.isInverted = true
        TestCalculator.stub_calculateRPNResult = { _ in
            calculateRPNResultNotCalledExpectation.fulfill()
            return 6
        }

        let convertGreatestCommonDividerNotCalledExpectation = XCTestExpectation(description: "converter.greatestCommonDivider is not invoked")
        convertGreatestCommonDividerNotCalledExpectation.isInverted = true
        TestDecimalToFractionConverter.stub_greatestCommonDivider = { _, _ in
            convertGreatestCommonDividerNotCalledExpectation.fulfill()
            return 4
        }

        let convertDecimalToFractionNotCalledExpectation = XCTestExpectation(description: "converter.convertDecimalToFraction is not invoked")
        convertDecimalToFractionNotCalledExpectation.isInverted = true
        TestDecimalToFractionConverter.stub_convertDecimalToFraction = { _ in
            convertDecimalToFractionNotCalledExpectation.fulfill()
            return "-3"
        }

        // Act
        fractionOperations.interactiveMode()

        // Assert
        self.wait(for: [convertInfixToPostFixNotCalledExpectation, calculateRPNResultNotCalledExpectation, convertGreatestCommonDividerNotCalledExpectation, convertDecimalToFractionNotCalledExpectation], timeout: 2)

    }

    func testWhenConvertInfixToPostFixThrowsThenExitIsEntered() {
        // Arrange
        consoleIO.stub_getInput = {
            if TestConsoleIO.stub_inputCycleCount < 1 {
                TestConsoleIO.stub_inputCycleCount += 1
                return "3*4!5"
            }
            return "exit"
        }

        TestCalculator.stub_convertInfixToPostFix = { _ in
            throw FractionOperationsErrors.invalidCharacters
        }

        let calculateRPNResultNotCalledExpectation = XCTestExpectation(description: "calculator.calculateRPNResult is not invoked")
        calculateRPNResultNotCalledExpectation.isInverted = true
        TestCalculator.stub_calculateRPNResult = { _ in
            calculateRPNResultNotCalledExpectation.fulfill()
            return 6
        }

        let convertGreatestCommonDividerNotCalledExpectation = XCTestExpectation(description: "converter.greatestCommonDivider is not invoked")
        convertGreatestCommonDividerNotCalledExpectation.isInverted = true
        TestDecimalToFractionConverter.stub_greatestCommonDivider = { _, _ in
            convertGreatestCommonDividerNotCalledExpectation.fulfill()
            return 4
        }

        let convertDecimalToFractionNotCalledExpectation = XCTestExpectation(description: "converter.convertDecimalToFraction is not invoked")
        convertDecimalToFractionNotCalledExpectation.isInverted = true
        TestDecimalToFractionConverter.stub_convertDecimalToFraction = { _ in
            convertDecimalToFractionNotCalledExpectation.fulfill()
            return "-3"
        }

        // Act
        fractionOperations.interactiveMode()

        // Assert
        self.wait(for: [calculateRPNResultNotCalledExpectation, convertGreatestCommonDividerNotCalledExpectation, convertDecimalToFractionNotCalledExpectation], timeout: 2)

    }

    func testWhenCalculateRPNResultThrowsThenExitIsEntered() {
        // Arrange
        TestCalculator.stub_convertInfixToPostFix = { _ in
            return ["2", "7", "/"]
        }

        TestCalculator.stub_calculateRPNResult = { _ in
            throw FractionOperationsErrors.reversePolishNotationResultError
        }

        let convertGreatestCommonDividerNotCalledExpectation = XCTestExpectation(description: "converter.greatestCommonDivider is not invoked")
        convertGreatestCommonDividerNotCalledExpectation.isInverted = true
        TestDecimalToFractionConverter.stub_greatestCommonDivider = { _, _ in
            convertGreatestCommonDividerNotCalledExpectation.fulfill()
            return 4
        }

        let convertDecimalToFractionNotCalledExpectation = XCTestExpectation(description: "converter.convertDecimalToFraction is not invoked")
        convertDecimalToFractionNotCalledExpectation.isInverted = true
        TestDecimalToFractionConverter.stub_convertDecimalToFraction = { _ in
            convertDecimalToFractionNotCalledExpectation.fulfill()
            return "-3"
        }

        consoleIO.stub_getInput = {
            if TestConsoleIO.stub_inputCycleCount < 1 {
                TestConsoleIO.stub_inputCycleCount += 1
                return "3*4!5"
            }
            return "exit"
        }

        // Act
        fractionOperations.interactiveMode()

        // Assert
        self.wait(for: [convertGreatestCommonDividerNotCalledExpectation, convertDecimalToFractionNotCalledExpectation], timeout: 2)

    }

    // Happy flow test cases
    func testConvertDecimalToFractionInvokedWhenNoMethodThrows() {
        // Arrange
        consoleIO.stub_getInput = {
            if TestConsoleIO.stub_inputCycleCount < 1 {
                TestConsoleIO.stub_inputCycleCount += 1
                return "3*4!5"
            }
            return "exit"
        }

        TestCalculator.stub_convertInfixToPostFix = { _ in
            return ["2", "5", "*"]
        }


        TestCalculator.stub_calculateRPNResult = { _ in
            return 9
        }

        let convertDecimalToFractionNotCalledExpectation = XCTestExpectation(description: "converter.convertDecimalToFraction isinvoked")
        TestDecimalToFractionConverter.stub_convertDecimalToFraction = { _ in
            convertDecimalToFractionNotCalledExpectation.fulfill()
            return "-3"
        }

        // Act
        fractionOperations.interactiveMode()

        // Assert
        self.wait(for: [convertDecimalToFractionNotCalledExpectation], timeout: 2)

    }
}
