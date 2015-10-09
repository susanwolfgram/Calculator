//
//  main.swift
//  SimpleCalc
//
//  Created by Susan Wolfgram on 10/7/15.
//  Copyright © 2015 Susan Wolfgram. All rights reserved.
//

import Foundation

print("$ calc")
print("Enter an expression separated by returns:")

func input() -> String {
    let keyboard = NSFileHandle.fileHandleWithStandardInput()
    let inputData = keyboard.availableData
    let result = NSString(data: inputData, encoding:NSUTF8StringEncoding) as! String
    return result.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
}

func convert(incoming:String) -> Int {
    return NSNumberFormatter().numberFromString(incoming)!.integerValue
}

var numStack = [String]()

func operation(number1 : Int, operand : String, number2 : Int) -> Double {
    let num1 = Double(number1)
    let num2 = Double(number2)
    
    
    switch operand {
        case "+":
            return num1 + num2
        case "-":
            return num1 - num2
        case "*":
            return num1 * num2
        case "/":
            return num1 / num2
        case "%":
            return num1 % num2
        default :
            return 0.0
    }
        
    
}

func multi(numbers: [String], operand : String) -> Double {
    var count = 0.0
    var sum = 0.0
    for number in numbers {
        let num = Double(convert(number))
        sum += num
        count++
    }
    if operand == "count" {
        return count
    } else {
        return sum / count
    }
}

func factorial(number : Int) -> Int {
    var fact = number
    var total = 1
    while fact > 1 {
        fact--
        total += total * fact
    }
    return total
}

var myStringArr = [String]()
func processInput() {
    let x = input()
    let myString = x
    myStringArr = myString.componentsSeparatedByString(" ")
    if myStringArr.count > 1 {
        if myStringArr.last == "count" || myStringArr.last == "avg" {
            let ope = myStringArr.removeLast()
            print(multi(myStringArr, operand: ope))
        } else {
            print(factorial(convert(myStringArr.removeFirst())))
        }
    } else {
        if (!numStack.isEmpty) {
            switch x {
            case "+", "-", "*", "/", "%":
                numStack.append(x)
                processInput()
            default:
                let oper = numStack.removeLast()
                let number1 = convert(numStack.removeLast())
                let result = operation(number1, operand : oper, number2 : convert(x))
                print(result)
            }
        } else {
            numStack.append(x)
            processInput()
        }
    }
}
processInput()


//var number = input()
//var result = processInput()
//print("\(result)")

/*
if numStack.isEmpty && x{
numStack.append(x)
numStack.append(x)
}
else {

*/




