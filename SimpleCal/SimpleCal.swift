//
//  SimpleCal.swift
//  SimpleCal
//
//  Created by Debehogne David on 01/06/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class SimpleCal: XCTestCase {

    var simple = SimpleCalc()

    func testAddition(){
        XCTAssertEqual(8, simple.addition(number1: 3, number2: 5))
    }
    
    func testSubstrate(){
        XCTAssertEqual(-2, simple.substraction(number1: 3, number2: 5))
    }
    
    func testMultiplication(){
        XCTAssertEqual(24, simple.multiplication(number1: 3, number2: 8))
    }
    
}

class FunctionTest : XCTestCase {
    
    var simple = SimpleCalc()
    
    func testReduce(){
        simple.textView = "2 + 1 - 1 + 2"
        let result = simple.reduceToResult(array: simple.elements)
        print(result)
        XCTAssertEqual("4", result[0])
    }
    
    var simple2 = SimpleCalc()
    
    func testPriority(){
        simple2.textView = "2 + 1 x 2 + 2 x 3"
        let result = simple2.priorityResult(array: simple2.elements)
        print(result)
        let final = simple2.reduceToResult(array: result)
        XCTAssertEqual("10", final[0])
    }
}
