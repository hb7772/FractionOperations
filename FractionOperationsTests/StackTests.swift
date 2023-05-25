//
//  StackTests.swift
//  FractionOperationsTests
//
//  Created by Bence Hupp
//

import XCTest

final class StackTests: XCTestCase {

    var stack: Stack<String>!

    override func setUp() {
        stack = Stack()
    }

    override func tearDown() {
        stack = nil
    }

    func testPushAndPeek() {
        // Arrange

        // Act
        stack.push("test")

        // Assert
        XCTAssertEqual(stack.peek(), "test")
    }

    func testPop() {
        // Arrange

        // Act
        stack.push("123")

        // Assert
        XCTAssertEqual(stack.pop(), "123")
        XCTAssertEqual(stack.peek(), nil)
    }

    func testIsEmpty() {
        // Arrange

        // Act
        stack.push("123")

        // Assert
        XCTAssertFalse(stack.isEmpty)

        _ = stack.pop()
        XCTAssertTrue(stack.isEmpty)
    }

    func testPushingMoreItems() {
        // Arrange

        // Act
        stack.push("123")
        stack.push("test")
        stack.push("anotherElement")

        // Assert
        XCTAssertEqual(stack.pop(), "anotherElement")
        XCTAssertEqual(stack.pop(), "test")
        XCTAssertEqual(stack.pop(), "123")
        XCTAssertTrue(stack.isEmpty)
    }
}
