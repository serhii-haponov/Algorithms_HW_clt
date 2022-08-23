//
//  HW3_T1.swift
//  Algorithms_HW_clt
//
//  Created by Serhii Haponov on 22.08.2022.
//

import Foundation

struct HW3_T1 {
    
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
}
