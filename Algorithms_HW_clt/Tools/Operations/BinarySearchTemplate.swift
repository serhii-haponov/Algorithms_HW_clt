//
//  BinarySearchTemp.swift
//  Algorithms_HW_clt
//
//  Created by Serhii Haponov on 16.09.2022.
//

import Foundation

//Input: weights = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], days = 5
//Output: 15
//Explanations: A ship capacity of 15 is the minimum to ship all the packeges within 5 days:
//1st - 1, 2, 3, 4, 5
//2nd - 6, 7
//3rd - 8
//4th - 9
//5th - 10

struct BinarySearchTemp {
    func shipWithinDays(weights: [Int], days: Int) -> Int {
        
        func good_enough(copacity: Int) -> Bool {
            var total = 0
            var daysUsed = 0
            
            for w in weights {
                if w > copacity {
                    return false
                } else if total + w > copacity {
                    daysUsed += 1
                    total = w
                } else {
                    total += w
                }
            }
            return daysUsed + 1 <= days
        }
        
        var bad = 0
        var good = weights.reduce(0, +)
        
        while good - bad > 1 {
            let copacity = (good + bad) / 2
            if good_enough(copacity: copacity) {
                good = copacity
            } else {
                bad = copacity
            }
        }

        return good
    }
}
