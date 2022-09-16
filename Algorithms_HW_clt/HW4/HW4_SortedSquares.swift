//
//  HW4_SortedSquares.swift
//  Algorithms_HW_clt
//
//  Created by Serhii Haponov on 14.09.2022.
//

import Foundation

//https://leetcode.com/problems/squares-of-a-sorted-array/submissions/
//Given an integer array nums sorted in non-decreasing order, return an array of the squares of each number sorted in non-decreasing order.
//
//
//
//Example 1:
//
//Input: nums = [-4,-1,0,3,10]
//Output: [0,1,9,16,100]
//Explanation: After squaring, the array becomes [16,1,0,9,100].
//After sorting, it becomes [0,1,9,16,100].
//Example 2:
//
//Input: nums = [-7,-3,2,3,11]
//Output: [4,9,9,49,121]
//
//
//Constraints:
//
//1 <= nums.length <= 104
//-104 <= nums[i] <= 104
//nums is sorted in non-decreasing order.
//
//
//Follow up: Squaring each element and sorting the new array is very trivial, could you find an O(n) solution using a different approach?

struct HW4_SortedSquares {
    //    [-4,-1,0,3,10]
    func start(_ nums: [Int]) -> [Int] { //O(N)
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

