//
//  Reshuffle.swift
//  Algorithms_HW_clt
//
//  Created by Serhii Haponov on 24.10.2022.
//

import Foundation
//перестановки
struct Reshuffle {
    let n: Int // n = prefix.count by default

    func gen(prefix: [Int]) {
        if prefix.count == n {
            print(prefix)
            return
        }
        
        for i in 1...n {
            if !prefix.contains(i) {
                gen(prefix: prefix + [i])
            }
        }
    }
}
