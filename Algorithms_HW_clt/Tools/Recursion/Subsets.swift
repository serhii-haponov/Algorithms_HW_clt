//
//  Subsets.swift
//  Algorithms_HW_clt
//
//  Created by Serhii Haponov on 24.10.2022.
//

import Foundation
//множества
struct Subsets {
    let n: Int // n = prefix.count by default

    func gen(prefix: [Int]) {
        if prefix.count == n {
            print(prefix)
            return
        }
                
        gen(prefix: prefix + [0])
        gen(prefix: prefix + [1])
    }
}
