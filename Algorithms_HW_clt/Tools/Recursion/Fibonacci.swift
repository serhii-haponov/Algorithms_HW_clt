//
//  Fibonacci.swift
//  Algorithms_HW_clt
//
//  Created by Serhii Haponov on 20.10.2022.
//

import Foundation

struct Fibonacci {
    func gen(n: Int) -> Int {
        if n == 1 {
            return 1
        }
      return  gen(n: n - 1) + n
    }
}
