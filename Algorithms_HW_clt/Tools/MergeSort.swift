//
//  MergeSort.swift
//  Algorithms_HW_clt
//
//  Created by Serhii Haponov on 13.09.2022.
//

import Foundation

struct MergeSort {
    
    static func mergeSort(a: inout [Int]) {
        return sort(a: &a, l: 0, r: a.count)
    }
}

private extension MergeSort {
    
   static func merge(a: inout [Int], l: Int, m: Int, r: Int) {
        var c: [Int] = []
        for i in l..<m {
            c.append(a[i])
        }
        
        var i = 0
        var j = m
        var k = l
    
        while i < c.count || j < r {
            
            if j == r || (i < c.count && c[i] < a[j]) {
                a[k] = c[i]
                i += 1
            } else {
                a[k] = a[j]
                j += 1
            }
            k += 1
        }
    }
    
   static func sort(a: inout [Int], l: Int, r: Int) {
       print(a, l, r)
        if r - l < 2 {
            return
        }
        
        let m = (l + r) / 2
        
        sort(a: &a, l: l, r: m)
        sort(a: &a, l: m, r: r)
        merge(a: &a, l: l, m: m, r: r)
    }
}
//var array = [0, -10, 1, 4, 5, -123123123123]
