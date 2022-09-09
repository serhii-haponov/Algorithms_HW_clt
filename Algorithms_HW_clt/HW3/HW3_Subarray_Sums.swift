//
//  HW3_Subarray_Sums.swift
//  Algorithms_HW_clt
//
//  Created by Serhii Haponov on 23.08.2022.
//

import Foundation

//https://cses.fi/problemset/task/1660

//Given an array of n
//n
// positive integers, your task is to count the number of subarrays having sum x
//x
//.
//
//Input
//
//The first input line has two integers n
//n
// and x
//x
//: the size of the array and the target sum x
//x
//.
//
//The next line has n
//n
// integers a1,a2,…,an
//a
//1
//,
//a
//2
//,
//…
//,
//a
//n
//: the contents of the array.
//
//Output
//
//Print one integer: the required number of subarrays.
//
//Constraints
//1≤n≤2⋅105
//1
//≤
//n
//≤
//2
//⋅
//10
//5
//
//1≤x,ai≤109
//1
//≤
//x
//,
//a
//i
//≤
//10
//9
//
//Example
//
//Input:
//5 7
//2 4 1 2 7
//
//Output:
//3

struct HW3_Subarray_Sums {
    
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
