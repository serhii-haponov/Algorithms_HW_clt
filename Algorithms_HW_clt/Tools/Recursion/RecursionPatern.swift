//
//  RecursionPatern.swift
//  Algorithms_HW_clt
//
//  Created by Serhii Haponov on 22.10.2022.
//

import Foundation
// Lection 16-17
struct RecursionPatern {
    let n: Int // n = prefix.count by default

    func gen(prefix: [Int]) {
        if prefix.count == n {
            print(prefix)
            return
        }
        
//        for i in 0..<n {
////            if prefix + [i] correct?
//            gen(prefix: prefix + [i])
//        }
        
        gen(prefix: prefix + [0])
        gen(prefix: prefix + [1])
    }
    
    // обработка комбинаций подмножества (пример gen([1, 3, 4, 5, 6, 6, 7])) находит комбинацию сумма которых максимально приблеженная к "К"
    
    let K = 200
    var best = 0
    mutating func precess(prefix: [Int]) {
        var mass = 0
        for i in 0..<prefix.count {
            if prefix[i] == 1 {
                mass += prefix[i]
            }
        }
        
        if mass > best && mass < K {
            best = mass
        }
    }
}
