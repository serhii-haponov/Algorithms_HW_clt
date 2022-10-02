//
//  InsertionSort.swift
//  Algorithms_HW_clt
//
//  Created by Serhii Haponov on 02.10.2022.
//

import Foundation

struct InsertionSort {
    
    func sort(a: [Int]) -> [Int] {
        var a = a
        for i in 1..<a.count {
            // a[0...i-1] is sorted
            // a[i] put in proper place
            var j = i
            let t = a[j]
            while j > 0, a[j-1] > t {
               a[j] = a[j - 1]
                j -= 1
            }
            a[j] = t
        }
        return a
    }
 }
