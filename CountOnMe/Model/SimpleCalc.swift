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

    var textView = "1+1=2"
    
    var elements: [String] {
        return textView.split(separator: " ").map { "\($0)" }
    }

    // Error check computed variables
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x"
    }

    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }

    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x"
    }

    var expressionHaveResult: Bool {
        return textView.firstIndex(of: "=") != nil
    }

    func addition(number1: Int, number2: Int) -> Int {
        return number1 + number2
    }
    
    func substraction(number1: Int, number2: Int) -> Int {
        return number1 - number2
    }
    
    func multiplication(number1: Int, number2: Int) -> Int {
        return number1 * number2
    }
    
    func priorityResult(array : [String]) -> [String] {
        var operationsToReduce = array
        
        for index in stride(from: operationsToReduce.count-2, to: 1, by: -1){
            if operationsToReduce[index] == "x"{
                
                let left = Int(operationsToReduce[index-1])!
                let operand = operationsToReduce[index]
                let right = Int(operationsToReduce[index+1])!
                
                let result: Int
                switch operand {
                case "x": result = multiplication(number1: left, number2: right)
                default: fatalError("Unknown operator !")
                }

                operationsToReduce.remove(at: index+1)
                operationsToReduce.remove(at: index)
                operationsToReduce.remove(at: index-1)
                operationsToReduce.insert("\(result)", at: index-1)

            }
        }
        
        return operationsToReduce
    }
    
    
    
    
    func reduceToResult(array: [String]) -> [String]{
        var operationsToReduce = array
        while operationsToReduce.count > 1 {
            let left = Int(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Int(operationsToReduce[2])!
            
            let result: Int
            switch operand {
            case "+": result = addition(number1: left, number2: right)
            case "-": result = substraction(number1: left, number2: right)
            case "x": result = multiplication(number1: left, number2: right)
            default: fatalError("Unknown operator !")
            }
            
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
        return operationsToReduce
    }
        
    
    
    

}
