//
//  Сompounds.swift
//  Algorithms_HW_clt
//
//  Created by Serhii Haponov on 24.10.2022.
//

import Foundation
//Заняття 17
//https://www.notion.so/c67ab66abe794a48980994976e74601a?v=d8957524583745569bee00be5ef8b7bc&p=07fce494b14440e3bf2dda309500e9d2&pm=s

//C = n!/k!(n-k)!  (for n = 5, k = 3 -> 120/12 -> C = 10 )
//
//[12345] k = 3
//123
//124
//125
//134
//135
//145
//234
//235
//245
//345

struct Сompounds {
    
    func gen(n: Int, k: Int, prefix: String = "") {
        
        if prefix.count == k {
            print(prefix)
            return
        }
        
        for i in 1...n {
            
        }
        
        if n > k {
            gen(n: n - 1, k: k, prefix: prefix + "0")
        }
        
        if k > 0 {
            gen(n: n - 1, k: k - 1, prefix: prefix + "1")
        }
    }
}
