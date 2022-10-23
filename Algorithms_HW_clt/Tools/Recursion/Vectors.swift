//
//  Vectors.swift
//  Algorithms_HW_clt
//
//  Created by Serhii Haponov on 20.10.2022.
//

import Foundation

//Combinatorics
//[0, 0, 0]
//[0, 0, 1]
//[0, 1, 0]
//[0, 1, 1]
//[1, 0, 0]
//[1, 0, 1]
//[1, 1, 0]
//[1, 1, 1]

struct Vectors {
    let n: Int
    
    func gen(prefix: [Int]) {
        if prefix.count == n {
            print(prefix)
            return
        }
        gen(prefix: prefix + [0])
        gen(prefix: prefix + [1])
    }
}
