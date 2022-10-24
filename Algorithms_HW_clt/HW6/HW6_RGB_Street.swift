//
//  HW6_RGB_Street.swift
//  Algorithms_HW_clt
//
//  Created by Serhii Haponov on 19.10.2022.
//

//https://www.hackerrank.com/contests/projector-algo-base-7-hw-4-yfff/challenges/rgb-street
//https://www.hackerrank.com/projector-algo-base-7-hw-4-yfff

//RGB Street

//The people of RGB Street have decided to paint each of their houses red, green, or blue. They've also decided that no two neighboring houses will be painted the same color. The neighbors of house i are houses i-1 and i+1. The first and last houses are not neighbors.
//
//You will be given three integer sequences R, G and B. Ri, Gi and Bi are the costs of painting the i-th house red, green, and blue, respectively.
//
//Find the minimal total cost required to perform the work.
//
//Input Format
//
//First line of input contains a single integer n — the number of houses. Each of the following n lines contains three integers Ri, Gi and Bi each.
//
//Constraints
//
//1 ≤ n ≤ 20
//1 ≤ Ri ≤ 1000
//1 ≤ Gi ≤ 1000
//1 ≤ Bi ≤ 1000
//Output Format
//
//Print a sigle number — the minimal total cost required to perform the work.
//
//Sample Input 0
//
//3
//1 100 100
//100 1 100
//100 100 1
//Sample Output 0
//
//3
//Explanation 0
//
//"RGB" is the best choice, and the total cost of the work is equal to 3.
//
//Sample Input 1
//
//3
//1 100 100
//100 100 100
//1 100 100
//Sample Output 1
//
//102
//Explanation 1
//
//The minimum possible cost is 102, and there are two solutions that result in that cost: "RGR" and "RBR".
//
//Sample Input 2
//
//3
//26 40 83
//49 60 57
//13 89 99
//Sample Output 2
//
//96
//Sample Input 3
//
//6
//30 19 5
//64 77 64
//15 19 97
//4 71 57
//90 86 84
//93 32 91
//Sample Output 3
//
//208
//Sample Input 4
//
//8
//71 39 44  32 83 55  51 37 63  89 29 100  83 58 11
//32 83 55
//51 37 63
//89 29 100
//83 58 11
//65 13 15
//47 25 29
//60 66 19
//Sample Output 4
//
//253

//1-2-1  1 0 0  0 1 0  1 0 0
//1-2-3  1 0 0  0 1 0  0 0 1
//1-3-1  1 0 0  0 0 1  1 0 0
//1-3-2  1 0 0  0 0 1  0 1 0

//2-1-2  0 1 0  1 0 0  0 1 0
//2-1-3  0 1 0  1 0 0  0 0 1
//2-3-1  0 1 0  0 0 1  1 0 0
//2-3-2  0 1 0  0 0 1  0 1 0

//3-1-2  0 0 1  1 0 0  0 1 0
//3-1-3  0 0 1  1 0 0  0 0 1
//3-2-1  0 0 1  0 1 0  1 0 0
//3-2-3  0 0 1  0 1 0  0 0 1

import Foundation

//MARK: - Start
class HW6_RGB_Street {
    
    private var n: Int!
    private var bestPrice: Int = Int.max
    private var rgbPricces: [Int] = []
    
    func start() {
        getInput()
        gen(prefix: [])
        print(bestPrice)
    }
}

//MARK: - Input
private extension HW6_RGB_Street {
   func getInput() {
        let numberOfLines = Int(readLine()!)!
        n = numberOfLines * 3
        
        var rgbPrices: [Int] = []
        for _ in 0..<numberOfLines {
            let houseRGBPrice = readLine()?.split(separator: " ").compactMap { Int($0) } ?? []
            rgbPrices.append(contentsOf: houseRGBPrice)
        }
       self.rgbPricces = rgbPrices
    }
}

//MARK: - Execution
private extension HW6_RGB_Street {
    
    func gen(prefix: [Int]) {
        if prefix.count == n {
            print(prefix)
//            precess(prefix: (prefix))
            return
        }

        let count = prefix.count
        if !(count % 3 == 2 && prefix.last == 0 && prefix[count - 2] == 0) {
            gen(prefix: prefix + [0])
        }

        if !(
            (count % 3 == 1 && prefix.last == 1) ||
            (count % 3 == 2 && (prefix.last == 1 || prefix[count - 2] == 1)) ||
            (count > 2 && prefix[count - 3] == 1)
        ) {
            gen(prefix: prefix + [1])
        }
    }
    
//    func gen(prefix: [Int]) {
//        if prefix.count == n {
//            print(prefix)
////            precess(prefix: (prefix))
//            return
//        }
//
//        let count = prefix.count
//        let palaceInSection = count % 3
//        let lastSectionStart = count - palaceInSection
//
//        if !(count % 3 == 2 && prefix.last == 0 && prefix[count - 2] == 0) {
//            gen(prefix: prefix + [0])
//        }
//
//        if !(prefix[lastSectionStart..<count].contains(1) || (count > 3 && prefix[count - 3] == 1)) {
//            gen(prefix: prefix + [1])
//        }
//    }
    
    
    func precess(prefix: [Int]) {
        var price = 0
        
        for i in 0..<prefix.count {
            if prefix[i] == 1 {
                price += rgbPricces[i]
            }
        }
        
        if price < bestPrice {
            bestPrice = price
        }
    }
}
