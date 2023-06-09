//
//  main.swift
//  FractionOperations
//
//  Created by Bence Hupp
//

import Foundation

// Ideally such dependencies should be registered and resolved by a DI framework, but for such a small project like this, it would be overkill
let consoleIO = ConsoleIO()

// static classes are not instantiated, but can be "injected" in swift as generic types
let fractionOperations = FractionOperations<DecimalToFractionConverter,
                                            Calculator<InputValidator>>(consoleIO: consoleIO)

if CommandLine.argc < 2 {
    fractionOperations.interactiveMode()
} else {
    fractionOperations.staticMode()
}

