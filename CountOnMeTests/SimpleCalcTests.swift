//
//  SimpleCalcTests.swift
//  SimpleCalcTests
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class SimpleCalcTests: XCTestCase {

    var simpleCal = SimpleCalc()
    
    func testGivenEntier_WhenAddition_thenResult() {
        simpleCal.textView = "1+2="
        let result = simpleCal.reduceToResult(array: simpleCal.elements)
        XCTAssert(result[0] == "3")
    }

}
