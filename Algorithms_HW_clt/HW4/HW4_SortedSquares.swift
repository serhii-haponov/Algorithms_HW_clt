//
//  HW4_SortedSquares.swift
//  Algorithms_HW_clt
//
//  Created by Serhii Haponov on 14.09.2022.
//

import Foundation

struct HW4_SortedSquares {
    //    [-4,-1,0,3,10]
    func sortedSquares(_ nums: [Int]) -> [Int] { //O(N)
        var array: [Int] = nums
        var j = nums.count - 1
        
        for i in 0..<nums.count {
            guard j - i >= 0 else { return array }
            let ii = nums[i] * nums[i]
            var jj = nums[j] * nums[j]
            while  jj > ii {
                array[j - i] = jj
                j -= 1
                jj = nums[j] * nums[j]
            }
            array[j - i] = ii
        }
        
        return array
    }
}

