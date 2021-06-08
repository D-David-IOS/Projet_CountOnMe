//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    var simpleCal = SimpleCalc()
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        
        if simpleCal.expressionHaveResult {
            simpleCal.textView = ""
            textView.text = ""
        }
        
        if simpleCal.lastOperatorIsDivision && numberText == "0" {
            let alertVC = UIAlertController(title: "Zéro!", message: "Vous ne pouvez pas diviser par 0 !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        } else {
            simpleCal.textView.append(numberText)
            textView.text.append(numberText)
        }
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        if simpleCal.canAddOperator {
            textView.text.append(" + ")
            simpleCal.textView.append(" + ")
        } else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Vous ne pouvez pas ajouter un opérateur!", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        if simpleCal.canAddOperator {
            textView.text.append(" - ")
            simpleCal.textView.append(" - ")
        } else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Vous ne pouvez pas ajouter un opérateur!", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func tappedMultiplication(_ sender: Any) {
        if simpleCal.canAddOperator {
            textView.text.append(" x ")
            simpleCal.textView.append(" x ")
        } else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Vous ne pouvez pas ajouter un opérateur!", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func tappedDivision(_ sender: Any) {
        if simpleCal.canAddOperator {
            textView.text.append(" / ")
            simpleCal.textView.append(" / ")
        } else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Vous ne pouvez pas ajouter un opérateur!", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func tappedAcButton(_ sender: Any) {
        simpleCal.textView = ""
        textView.text = ""
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard simpleCal.expressionIsCorrect && !simpleCal.expressionHaveResult else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        guard simpleCal.expressionHaveEnoughElement else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        
        // Iterate over operations while an operand still here
        let final = simpleCal.reduceToResult(array: simpleCal.elements)
        
        simpleCal.textView.append(" = \(final.first!)")
        textView.text.append(" = \(final.first!)")
    }
}
