//
//  ViewController.swift
//  Calculator Layout iOS13
//
//  Created by Angela Yu on 01/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    var firstNumberText = ""
    var secondNumberText = ""
    var op = ""
    var isFirstNumber = true
    var hasOp = false
    var canClear = true
    var numOverZero = false
    var resultTemp = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // Here is where we will drag
    @IBAction func handleButtonPress(_ sender: UIButton) {
       if canClear {
           resultLabel.text = ""
           canClear = false
       }
       let currentText = resultLabel.text!
       let textLabel = sender.titleLabel?.text
       if let text = textLabel {
           switch text {
           case "+", "*", "/", "-":
               if hasOp {
                   return
               }
               op = text
               isFirstNumber = false
               hasOp = true
               resultLabel.text = "\(currentText) \(op) "
               break
           case "=":
               isFirstNumber = true
               hasOp = false
               canClear = true
               let result = calculate()
               if result > 0 {
                 numOverZero = true
               }
               resultTemp = "\(result)"
               resultLabel.text = "\(result)"
               break
           case "AC":
               resultLabel.text = "0"
               canClear = true
               break;
           case "+/-":
               // Handle putting + - depending on the result
               if numOverZero == true {
                // add - to the result
                 let tempResult = "-" + resultTemp
                 resultLabel.text = tempResult
               }
               else {
                 let tempResult = resultTemp
                 resultLabel.text = tempResult
               }
               break
           case ".":
                let resultDot = "."
                resultLabel.text = "\(0)" + resultDot
                firstNumberText = "\(0)" + resultDot + "\(firstNumberText)"
                break
           default:
               if isFirstNumber {
                   firstNumberText = "\(firstNumberText)\(text)"
               } else {
                   secondNumberText = "\(secondNumberText)\(text)"
               }
               resultLabel.text = "\(currentText)\(text)"
               break;
           }
       }
    }
    func calculate() -> Double {
        let firstNumber = Double(firstNumberText)!
        let secondNumber = Double(secondNumberText)!
        firstNumberText = ""
        secondNumberText = ""
        switch op {
        case "+":
            return firstNumber + secondNumber
        case "-":
            return firstNumber - secondNumber
        case "*":
            return firstNumber * secondNumber
        case "/":
            return firstNumber / secondNumber
        default:
            return 0
        }
    }
}

