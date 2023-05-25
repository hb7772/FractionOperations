//
//  FractionOperationsTests.swift
//  FractionOperationsTests
//
//  Created by Bence Hupp
//

import XCTest

final class FractionOperationsTests: XCTestCase {

    var consoleIO: TestConsoleIO!
    var fractionOperations: FractionOperations!

    override func setUp() {
        consoleIO = TestConsoleIO()
        fractionOperations = FractionOperations(consoleIO: consoleIO)
    }

    override func tearDown() {
        consoleIO = nil
        fractionOperations = nil
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
        let expectation = XCTestExpectation(description: "consoleIO.printUsage() is called when staticMode is invoked")
        consoleIO.stub_getInput = {
            expectation.fulfill()
            return "exit"
        }

        // Act
        fractionOperations.interactiveMode()

        // Assert
        wait(for: [expectation], timeout: 2)
    }

    func testGetInputIsCalledWhenInteractiveModeIsInvoked() {
        // Arrange
        let expectation = XCTestExpectation(description: "consoleIO.printUsage() is called when staticMode is invoked")
        consoleIO.stub_getInput = {
            expectation.fulfill()
            return "result"
        }

        // Act
        fractionOperations.interactiveMode()

        // Assert
        self.wait(for: [expectation], timeout: 2)

    }
}
