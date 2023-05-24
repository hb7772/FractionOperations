//
//  Stack.swift
//  FractionOperations
//
//  Created by Bence Hupp
//

import Foundation

struct Stack<Element> {
    private var storage: [Element] = []

    mutating func push(_ element: Element) {
        storage.append(element)
    }

    mutating func pop() -> Element? {
        return storage.popLast()
    }

    func peek() -> Element? {
        storage.last
    }

    var isEmpty: Bool {
        peek() == nil
    }

    var depth: Int {
        storage.count
    }

}
