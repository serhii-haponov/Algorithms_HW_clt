//
//  Hanoi.swift
//  Algorithms_HW_clt
//
//  Created by Serhii Haponov on 20.10.2022.
//

import Foundation
 
struct Hanoi {
    
    func gen(n: Int, from: Int, to: Int) {
        if n > 0 {
            gen(n: n - 1, from: from, to: 6 - from - to)
            print("\(n) move \(from) -> \(to)")
            gen(n: n - 1, from: 6 - from - to, to: to)
        }
    }
}
