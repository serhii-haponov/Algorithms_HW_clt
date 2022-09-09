//
//  HW3_HR_1_10_100.swift
//  Algorithms_HW_clt
//
//  Created by Serhii Haponov on 28.08.2022.
//

import Foundation

//https://www.hackerrank.com/contests/projector-algo-base-7-hw-2-123/challenges/1-10-100-1000-1

//Let's consider an infinite sequence of digits constructed of ascending powers of 10 written one after another. Here is the beginning of the sequence:  You are to find out what digit is located at the definite position of the sequence.
//
//Input Format
//
//There is the only integer  in the first line . The -th of  left lines contains the integer  — the number of position in the sequence.

//Output Format
//
//You are to output  digits  or  separated with a space. More precisely, the -th digit of output is to be equal to the -th digit of the sequence described above.
//
//Sample Input 0
//
//4
//3
//14
//7
//6
//Sample Output 0
//
//0 0 1 0

struct HW3_HR_1_10_100 {
    
    func start() {
        let positions = read1_10_100Input()
        //        brudSolution(positions: positions)
        //        cleanSolution(positions: positions)
        saveProgressSolution(positions: positions)
    }
    
    private func read1_10_100Input() -> [Int] {
        print("Set imput:")
        let size = Int(readLine() ?? "") ?? 0
        
        var positions = [Int]()
        for _ in 0..<size {
            let p = Int(readLine() ?? "") ?? 0
            positions.append(p)
        }
        return positions
    }
    
    private func brudSolution(positions: [Int]) {
        var incrementingNum: Int = 1
        var endlessStr = ""
        var resultStr = ""
        
        for p in positions {
            while endlessStr.count < p  {
                endlessStr += String(incrementingNum)
                incrementingNum *= 10
                print(endlessStr)
            }
            
            let element = endlessStr[endlessStr.index(endlessStr.startIndex, offsetBy: p - 1)]
            resultStr += String(element) + " "
        }
        print(resultStr)
    }
    
    private func cleanSolution(positions: [Int]) {
        //        1 2   4    7     11     16      22
        //        1 1 0 1 00 1 000 1 0000 1 00000 1
        
        var trueArray: [Int] = [1, 2]
        
        //        var lastValue = 1
        //        var lastDiff = 0
        //
        //        for p in positions {
        //
        //            while lastValue
        //
        //
        //        }
        
        for p in positions {
            
            while trueArray.last! < p {
                let lastElement = trueArray[trueArray.count - 1]
                let preLastElement = trueArray[trueArray.count - 2]
                let diff = lastElement - preLastElement
                let nextElement = lastElement + diff + 1
                trueArray.append(nextElement)
            }
            let isTrue = trueArray.contains(p)
            print((isTrue ? 1 : 0), terminator: " ")
        }
    }
    
    private func binarySearchSolution(positions: [Int]) {
        //        1 2   4    7     11     16      22
        //        1 1 0 1 00 1 000 1 0000 1 00000 1
        
        var trueArray: [Int] = [1, 2]
        
        //        var lastValue = 1
        //        var lastDiff = 0
        //
        //        for p in positions {
        //
        //            while lastValue
        //
        //
        //        }
        for p in positions {
            
            while trueArray.last! < p {
                let lastElement = trueArray[trueArray.count - 1]
                let preLastElement = trueArray[trueArray.count - 2]
                let diff = lastElement - preLastElement
                let nextElement = lastElement + diff + 1
                trueArray.append(nextElement)
            }
            //
            //binary search
            var i = (trueArray.count - 1) / 2
            while true {
                if p < trueArray[i] {
                    if p > trueArray[i - 1] {
                        print(0, terminator: " ")
                        break
                    }
                    i /= 2
                } else if p > trueArray[i] {
                    if p < trueArray[i + 1]  {
                        print(0, terminator: " ")
                        break
                    }
                    i = ((trueArray.count - 1) + i) / 2
                } else {
                    print(1, terminator: " ")
                    break
                }
            }
        }
    }
    
    private func saveProgressSolution(positions: [Int]) {
        //        1 2   4    7     11     16      22
        //        1 1 0 1 00 1 000 1 0000 1 00000 1
        
        var trueSet: Set = [1]
        var lastValue = 1
        var diff = 0
        
        for p in positions {
            while lastValue < p {
                diff += 1
                lastValue += diff
                trueSet.insert(lastValue)
            }
            
            let isTrue = trueSet.contains(p)
            print((isTrue ? 1 : 0), terminator: " ")
        }
    }
    
}
