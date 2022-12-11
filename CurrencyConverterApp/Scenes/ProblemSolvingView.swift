//
//  ProblemSolvingView.swift
//  CurrencyConverterApp
//
//  Created by Passant Abdelatif on 11/12/2022.
//

import Foundation

//I. Add arithmetic operators (add, subtract, multiply, divide) to make the following expressions
//true. You can use any parentheses you’d like.
//3 1 3 9 = 12

//II. Write a function/method utilizing Swift to determine whether two strings are anagrams or not
//(examples of anagrams: debit card/bad credit, etc.)

//III. Write a method in Swift to generate the nth Fibonacci number (1, 1, 2, 3, 5, 8, 13, 21, 34)
//A. recursive approach
//B. iterative approach

class ProblemSolvingIssues {
    
    func addArithmeticOperatorsIssue() {
        let value = 3 % 1 + 3 + 9
        print(value)
    }
    
    func anagramCheck(stringA: String, stringB: String) -> Bool{

        guard stringA.count == stringB.count else { return false }
        let stringASorted = stringA.lowercased().sorted()
        let stringBSorted = stringB.lowercased().sorted()

        if stringASorted == stringBSorted {
            return true
        }
        return false
    }
    
    func fibonacciByRecursive(_ n: Int) -> Int {
        guard n > 1 else { return n }
        return fibonacciByRecursive(n-1) + fibonacciByRecursive(n-2)
    }
    func fibonacciByIterative(n: Int) {
        var seq: [Int] = n == 0 ? [0] : [1, 1]
        var num = 2
        while num < n {
            seq.append(seq[num - 1] + seq[num - 2])
            num += 1
        }
        print("fibonacci Num = \(seq[n-1])")
    }
    
  
    // returns an array containing the first n Fibonacci numbers
    func fibonacciNumbers(n: Int) -> [Int] {

        assert(n > 1)

        var array = [1, 1]

        while array.count < n {
            array.append(array[array.count - 1] + array[array.count - 2])
        }
        return array
    }
    
}
