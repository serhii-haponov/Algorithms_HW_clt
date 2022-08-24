//
//  HW3_T2.swift
//  Algorithms_HW_clt
//
//  Created by Serhii Haponov on 23.08.2022.
//

import Foundation

struct HW3_T2 {
    
    func amountOfSubArraysFor(sum: Int, in array: [Int]) -> Int {
        var counter: Int = 0
        
        var L = 0
        var R = 1

        while R < (array.count - 1) {
            if array[L] + array[R] == sum {
                counter += 1
                L += 1
                R += 1
            } else if array[L] + array[R] < sum {
                R += 1
            } else {
                L += 1
            }
        }
        return counter
    }
}
