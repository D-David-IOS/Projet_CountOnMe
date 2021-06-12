//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // the text displayed on the view
    @IBOutlet weak var textView: UITextView!
    
    // all button with a number 0 ... 9
    @IBOutlet var numberButtons: [UIButton]!
    
    var simpleCal = SimpleCalc()
    
    func scrollTextViewToBottom(textView: UITextView) {
        if textView.text.count > 0 {
            let location = textView.text.count - 1
            let bottom = NSMakeRange(location, 1)
            textView.scrollRangeToVisible(bottom)
        }
    }
    
    // add a number to textView
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        
        // if textView has a result, the text is reset
        if simpleCal.expressionHaveResult {
            simpleCal.text = ""
            textView.text = ""
        }
        
        // forbidden to divide by zero
        // if the last operator is divide the user can't enter zero
        if simpleCal.lastOperatorIsDivision && numberText == "0" {
            let alertVC = UIAlertController(title: "Zéro!", message: "Vous ne pouvez pas diviser par 0 !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        } else {
            simpleCal.text.append(numberText)
            textView.text.append(numberText)
            scrollTextViewToBottom(textView: textView)
        }
    }
    
    // add "+" to the textView
    // if an operator is already present, the user can't add a "+"
    // same if the text has no number previously
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        if simpleCal.canAddOperator {
            textView.text.append(" + ")
            simpleCal.text.append(" + ")
            scrollTextViewToBottom(textView: textView)
        } else {
            let alertVC = UIAlertController(title: "Opérateur", message: "Vous ne pouvez pas ajouter un opérateur!", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    // add "-" to the textView
    // if an operator is already present, the user can't add a "-"
    // same if the text has no number previously
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        if simpleCal.canAddOperator {
            textView.text.append(" - ")
            simpleCal.text.append(" - ")
            scrollTextViewToBottom(textView: textView)
        } else {
            let alertVC = UIAlertController(title: "Operateur", message: "Vous ne pouvez pas ajouter un opérateur!", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    // add "x" to the textView
    // if an operator is already present, the user can't add a "x"
    // same if the text has no number previously
    @IBAction func tappedMultiplicationButton(_ sender: Any) {
        if simpleCal.canAddOperator {
            textView.text.append(" x ")
            simpleCal.text.append(" x ")
            scrollTextViewToBottom(textView: textView)
        } else {
            let alertVC = UIAlertController(title: "Operateur", message: "Vous ne pouvez pas ajouter un opérateur!", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    // add "/" to the textView
    // if an operator is already present, the user can't add a "/"
    // same if the text has no number previously
    @IBAction func tappedDivisionButton(_ sender: Any) {
        if simpleCal.canAddOperator {
            textView.text.append(" / ")
            simpleCal.text.append(" / ")
            scrollTextViewToBottom(textView: textView)
        } else {
            let alertVC = UIAlertController(title: "Operateur", message: "Vous ne pouvez pas ajouter un opérateur!", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
        
    }
    
    // this button can reset the text to ""
    @IBAction func tappedAcButton(_ sender: Any) {
        simpleCal.text = ""
        textView.text = ""
    }
    
    // when the user tap egal, the result is shown
    // the expression need to be correct, else an error appears
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        
        // the expression need to be correct
        // and have no result ( the user can't enter "=" 2 times in a row )
        guard simpleCal.expressionIsCorrect else {
            let alertVC = UIAlertController(title: "Expression incorrecte", message: "Entrez une expression correcte !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        // the enter expression need to have 3 elements
        // for exemple "3 + 2" is correct but "3 + " shows an error
        guard simpleCal.expressionHaveEnoughElement && !simpleCal.expressionHaveResult else {
            let alertVC = UIAlertController(title: "Calcul", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        // the function reduceToResult is called
        // transform "2 + 3 x 4" to "12" in an array stocked in the constant final
        let final = simpleCal.reduceToResult(array: simpleCal.elements)
        
        // the result added to textView
        simpleCal.text.append(" = \(final.first!)")
        textView.text.append(" = \(final.first!)")
        scrollTextViewToBottom(textView: textView)
    }
}
