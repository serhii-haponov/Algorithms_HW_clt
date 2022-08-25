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
        var S = array[0]
        
        var L = 0
        var R = 1

//        [2, 4, 1, 2, 7] 3
        
        while R <= array.count {
            if S == sum {
                counter += 1
                guard R < array.count else { break }
                S += array[R]
                S -= array[L]
                L += 1
                R += 1
            } else if S < sum {
                S += array[R]
                R += 1
            } else {
                S -= array[L]
                L += 1
            }
        }
        return counter
    }
    
    func amountOfSubArraysFor2(sum: Int, in array: [Int]) -> Int {
        var counter: Int = 0
        
        var L = 0
        var S = 0
        
        for r_element in array {
            S += r_element

            while S > sum {
                S -= array[L]
                L += 1
            }
            
            if S % sum == 0 && S != 0 {
                counter += 1
            }
        }
        
        return counter
    }
}
