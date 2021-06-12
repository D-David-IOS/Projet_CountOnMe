//
//  priority.swift
//  CountOnMe
//
//  Created by Debehogne David on 01/06/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation
import UIKit

class SimpleCalc {

    // contains the current expression
    var text = "1+1=2"
    
    // create an array with the current expression
    // exemple "1 + 1" create an array like ["1"],["+"] ["1"]
    var elements: [String] {
        return text.split(separator: " ").map { "\($0)" }
    }

    // return a boolean
    // the expression must not finsihed by an operator
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/" && elements.last != "="
    }
    
    // return True if the last operator is /
    var lastOperatorIsDivision: Bool {
        return elements.last == "/"
    }
    
    // return True if the expression have at least 3 elements
    // exemple "1 + " is not correct
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    // evalue if the user can add an operator
    // return False if the last element is an operator
    // same if textView is empty or has a result
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/" && elements.last != "=" && !expressionHaveResult && text != ""
    }

    // return True if the last element is "="
    var expressionHaveResult: Bool {
        return text.firstIndex(of: "=") != nil
    }

    // addition with 2 numbers
    func addition(number1: Double, number2: Double) -> Double {
        return number1 + number2
    }
    
    // subtraction with 2 numbers
    func substraction(number1: Double, number2: Double) -> Double {
        return number1 - number2
    }
    
    // multiplication with 2 numbers
    func multiplication(number1: Double, number2: Double) -> Double {
        return number1 * number2
    }
    
    // division with 2 numbers
    func division(number1: Double, number2: Double) -> Double {
        return number1 / number2
    }
    
    // when the user tap egal this function is called
    // first, the function will start at the end of the array
    // transform ["1"]["+"]["1"]["x"]["3"] into ["1"]["+"]["3"]
    // secondly transform ["1"]["+"]["3"] into ["4"]
    func reduceToResult(array: [String]) -> [String]{
        var operationsToReduce = array
        
        // starts at the end of the array
        // transform all multiplication and divide into a result
        // delete the index, and the right number in the array
        // and insert the result in the left number
        for index in stride(from: operationsToReduce.count-2, to: 0, by: -1){
            if operationsToReduce[index] == "x" || operationsToReduce[index] == "/"{
                
                let left = Double(operationsToReduce[index-1])!
                let operand = operationsToReduce[index]
                let right = Double(operationsToReduce[index+1])!
                
                let result: Double
                switch operand {
                case "x": result = multiplication(number1: left, number2: right)
                case "/": result = division(number1: left, number2: right)
                default: fatalError("Unknown operator !")
                }

                operationsToReduce.remove(at: index+1)
                operationsToReduce.remove(at: index)
                operationsToReduce.remove(at: index-1)
                operationsToReduce.insert("\(result)", at: index-1)

            }
        }
        
        // the second step transform all addition and substraction into a result
        while operationsToReduce.count > 1 {
            let left = Double(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Double(operationsToReduce[2])!
            
            let result: Double
            switch operand {
            case "+": result = addition(number1: left, number2: right)
            case "-": result = substraction(number1: left, number2: right)
            default: fatalError("Unknown operator !")
            }
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
        let around = Double(operationsToReduce[0])!
        operationsToReduce[0] = "\(Double(round(1000*around)/1000))"
        return operationsToReduce
    }
}
