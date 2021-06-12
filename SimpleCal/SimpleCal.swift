//
//  SimpleCal.swift
//  SimpleCal
//
//  Created by Debehogne David on 01/06/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

var simple = SimpleCalc()

class SimpleCal: XCTestCase {
    
    // test all Operator with 2 randoms numbers
    func testAllOperator(){
        for _ in 0...10 {
            let dRandom1 = Double.random(in: -99999.0...99999.0)
            let dRandom2 = Double.random(in: -99999.0...99999.0)
            
            // test addition
            XCTAssertEqual(dRandom1 + dRandom2, simple.addition(number1: dRandom1, number2: dRandom2))

            // test substraction
            XCTAssertEqual(dRandom1 - dRandom2, simple.substraction(number1: dRandom1, number2: dRandom2))

            // test multiplication
            XCTAssertEqual(dRandom1 * dRandom2, simple.multiplication(number1: dRandom1, number2: dRandom2))

            // test division
            XCTAssertEqual(dRandom1 / dRandom2, simple.division(number1: dRandom1, number2: dRandom2))
        }
    }
    
    // test the function reduceToResult with 2 exemple
    func testTotalReduce() {
        simple.text = "7.0 x 17.0 / 18.0 + 12.0"
        let result = simple.reduceToResult(array: simple.elements)
        let a : Double!
        a = 7.0 * 17.0 / 18.0 + 12.0
        XCTAssertEqual( String(Double(round(1000*(a))/1000)) , result[0])

        simple.text = "7.0 - 17.0 x 18.0 / 12.0"
        let result1 = simple.reduceToResult(array: simple.elements)
        let a1 : Double!
        a1 = 7.0 - 17.0 * 18.0 / 12.0
        XCTAssertEqual( String(Double(round(1000*(a1))/1000)) , result1[0])
    }
    
    func testGivenExpressionFinishedByOperatorOrNothing_whenAddOperator_thenReturnfalse(){
        simple.text = "7.1 + "
        XCTAssertFalse(simple.canAddOperator)
        simple.text = "7.1 - "
        XCTAssertFalse(simple.canAddOperator)
        simple.text = "7.1 x "
        XCTAssertFalse(simple.canAddOperator)
        simple.text = "7.1 / "
        XCTAssertFalse(simple.canAddOperator)
        simple.text = "9.0 + 8.0 ="
        XCTAssertFalse(simple.canAddOperator)
        // Nothing
        simple.text = ""
        XCTAssertFalse(simple.canAddOperator)
    }
    
    func testGivenExpressionNotFinishedByOperator_whenAddOperator_thenReturnTrue(){
        simple.text = "7.1"
        XCTAssertTrue(simple.canAddOperator)
        simple.text = "7.1 - 8.6"
        XCTAssertTrue(simple.canAddOperator)
        simple.text = "7.1 x 8.0"
        XCTAssertTrue(simple.canAddOperator)
        simple.text = "7.1 / 8.9"
        XCTAssertTrue(simple.canAddOperator)
    }
    
    func testGivenCorrectExpression_whenEvalueIfCorrect_thenReturnTrue(){
        simple.text = "7.1"
        XCTAssertTrue(simple.expressionIsCorrect)
        simple.text = "7.1 - 8.6"
        XCTAssertTrue(simple.expressionIsCorrect)
        simple.text = "7.1 x 8.0"
        XCTAssertTrue(simple.expressionIsCorrect)
        simple.text = "7.1 / 8.9 - 7.0 x 8.0 / 7.0"
        XCTAssertTrue(simple.expressionIsCorrect)
    }
    
    func testGivenIncorrectExpression_whenEvalueIfIncorrect_thenReturnFalse(){
        simple.text = "7.1 - "
        XCTAssertFalse(simple.expressionIsCorrect)
        simple.text = "7.1 ="
        XCTAssertFalse(simple.expressionIsCorrect)
        simple.text = "7.1 +"
        XCTAssertFalse(simple.expressionIsCorrect)
        simple.text = "7.1 / 8.9 - 7.0 x "
        XCTAssertFalse(simple.expressionIsCorrect)
    }
    
    func testGivenEnoughExpression_whenEvalueCorrect_thenReturnTrue(){
        simple.text = "7.1 - 8.0"
        XCTAssertTrue(simple.expressionHaveEnoughElement)
        simple.text = "7.1 + 8.0 x 2.0"
        XCTAssertTrue(simple.expressionHaveEnoughElement)
        simple.text = "7.1 + 8.0 x 2.0 - 8.0 x 2.0 / 8.0 x 2.0"
        XCTAssertTrue(simple.expressionHaveEnoughElement)
    }
    
    func testGivenNotEnoughExpression_whenEvalueIncorrect_thenReturnFalse(){
        simple.text = "7.1"
        XCTAssertFalse(simple.expressionHaveEnoughElement)
        simple.text = "7.1 + "
        XCTAssertFalse(simple.expressionHaveEnoughElement)
        simple.text = ""
        XCTAssertFalse(simple.expressionHaveEnoughElement)
    }
    
    func testGivenExpressionFinishByDiv_whenEvalueCorrect_thenReturnTrue(){
        simple.text = "7.1 /"
        XCTAssertTrue(simple.lastOperatorIsDivision)
        simple.text = "7.1 + 8.0 /"
        XCTAssertTrue(simple.lastOperatorIsDivision)
        simple.text = "2.0 + 3.0 x 3.0 /"
        XCTAssertTrue(simple.lastOperatorIsDivision)
    }
    
    func testGivenExpressionNotFinishByDiv_whenEvalueIncorrect_thenReturnFalse(){
        simple.text = "7.1 +"
        XCTAssertFalse(simple.lastOperatorIsDivision)
        simple.text = "7.1 + 8.0"
        XCTAssertFalse(simple.lastOperatorIsDivision)
        simple.text = "2.0 + 3.0 x 3.0 x"
        XCTAssertFalse(simple.lastOperatorIsDivision)
    }

}
