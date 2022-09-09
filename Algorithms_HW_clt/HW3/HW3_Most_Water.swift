//
//  HW3_Most_Water.swift
//  Algorithms_HW_clt
//
//  Created by Serhii Haponov on 22.08.2022.
//

import Foundation

//https://leetcode.com/problems/container-with-most-water/

//You are given an integer array height of length n. There are n vertical lines drawn such that the two endpoints of the ith line are (i, 0) and (i, height[i]).
//
//Find two lines that together with the x-axis form a container, such that the container contains the most water.
//
//Return the maximum amount of water a container can store.
//
//Notice that you may not slant the container.
//
//
//
//Example 1:
//
//
//Input: height = [1,8,6,2,5,4,8,3,7]
//Output: 49
//Explanation: The above vertical lines are represented by array [1,8,6,2,5,4,8,3,7]. In this case, the max area of water (blue section) the container can contain is 49.
//Example 2:
//
//Input: height = [1,1]
//Output: 1
//
//
//Constraints:
//
//n == height.length
//2 <= n <= 105
//0 <= height[i] <= 104



struct HW3_Most_Water {
    
    func maxArea1(_ height: [Int]) -> Int {
        var result = 0
        
        for (i, hl) in height.enumerated() {
            for j in (i + 1)..<height.count {
                let hr = height[j]
                let minH = min(hr, hl)
                let width = j - i
                result = max(result, minH * width)
            }
        }
        
        return result
    }
    
    func maxArea2(_ height: [Int]) -> Int {
        let lenth = height.count
        var L = 0
        var R = lenth - 1
        
        var maxArea = min(height[L], height[R]) * (lenth - 1)
//        [2,3,4,5,18,17,6] 17
//        [4,3,2,1,4] 16
        while L < R {
            
            let RMaxArea = min(height[R], height[L]) * (R - L)
            if RMaxArea > maxArea {
                maxArea = RMaxArea
            }
            
            if height[L] < height[R] {
                L += 1
            } else {
                R -= 1
            }
        }
        return maxArea
    }
    
    func start() {
        print("Enter array of int to calculate bigest area")
        let input = readLine()
        let intArray = parseIntArrayFrom(input!)
        print("Answer:")
        print(maxArea2(intArray))
    }
}


