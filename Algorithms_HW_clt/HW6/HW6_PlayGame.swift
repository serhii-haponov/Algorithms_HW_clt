//
//  HW6_PlayGame.swift
//  Algorithms_HW_clt
//
//  Created by Serhii Haponov on 23.10.2022.
//

import Foundation

//https://www.hackerrank.com/contests/projector-algo-base-7-hw-4-yfff/challenges/play-game-1

//Play Game
//Problem
//Submissions
//You are playing a computer game and a big fight is planned between two armies. You and your computer opponent will line up your respective units in two rows, with each of your units facing exactly one of your opponent's units and vice versa. Then, each pair of units, who face each other will fight and the stronger one will be victorious, while the weaker one will be captured. If two opposing units are equally strong, your unit will lose and be captured. You know how the computer will arrange its units, and must decide how to line up yours. You want to maximize the sum of the strengths of your units that are not captured during the battle.
//
//You are given a two sequences you[i] and computer[i] that specify the strengths of the units that you and the computer have, respectively. Find the maximum total strength of your units that are not captured.
//
//Input Format
//
//First line contains a single number n — number of units. Second line contains n numbers you[1], you[2], ..., you[n]. Third line contains n numbers computer[1], computer[2], ..., computer[n].
//
//Constraints
//
//1 ≤ n ≤ 50
//1 ≤ you[i] ≤ 1000
//1 ≤ computer[i] ≤ 1000
//Output Format
//
//Print the maximum total strength of your units that can be saved.
//
//Sample Input 0
//
//5
//5 15 100 1 5
//5 15 100 1 5
//Sample Output 0
//
//120
//Explanation 0
//
//Your units with strengths of 100 and 15, along with one of your strength 5 units, can avoid capture.
//
//Sample Input 1
//
//50
//1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000
//1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000
//Sample Output 1
//
//0
//Explanation 1
//
//All units are equally strong, so all your units are captured.
//
//Sample Input 2
//
//10
//1 3 5 7 9 11 13 15 17 19
//2 4 6 8 10 12 14 16 18 20
//Sample Output 2
//
//99
//Explanation 2
//
//You assign your weakest unit to the computer's strongest unit. Then you assign all your other units in such a way that each of your units has a strength one higher than the opposing unit. So all your units except the weakest one avoid capture.
//
//Sample Input 3
//
//10
//2 3 4 5 6 7 8 9 10 11
//10 9 8 7 6 5 4 3 2 1
//Sample Output 3
//
//65
//Explanation 3
//
//All your units can win.
//
//Sample Input 4
//
//50
//651 321 106 503 227 290 915 549 660 115 491 378 495 789 507 381 685 530 603 394 7 704 101 620 859 490 744 495 379 781 550 356 950 628 177 373 132 740 946 609 29 329 57 636 132 843 860 594 718 849
//16 127 704 614 218 67 169 621 340 319 366 658 798 803 524 608 794 896 145 627 401 253 137 851 67 426 571 302 546 225 311 111 804 135 284 784 890 786 740 612 360 852 228 859 229 249 540 979 55 82
//Sample Output 4
//
//25084

//MARK: - Start
struct HW6_PlayGame {
    
    func start() {
        let input = getInput()
        calculate(input: input)
    }
}

//MARK: - Input
private extension HW6_PlayGame {
    func getInput() -> ([Int], [Int]) {
        let _ = readLine()
        let secondLine = readLine()?.split(separator: " ").compactMap { Int($0) } ?? []
        let thirdLine = readLine()?.split(separator: " ").compactMap { Int($0) } ?? []
        
        return (secondLine, thirdLine)
    }
}

//MARK: - Execution
private extension HW6_PlayGame {
    
    func calculate(input: ([Int], [Int])) {
        let mySorted = input.0.sorted { $0 < $1 }
        let computersSorted = input.1.sorted { $0 < $1 }
        
        var result = 0
        var defeatable = mySorted.count - 1
        
        for i in stride(from: mySorted.count - 1, through: 0, by: -1) {
            if computersSorted[i] < mySorted[defeatable] {
                result += mySorted[defeatable]
                defeatable -= 1
            }
        }
        
        print(result)
    }
}
