//
//  HW3_CF_DNonSecretCypher.swift
//  Algorithms_HW_clt
//
//  Created by Serhii Haponov on 04.09.2022.
//

import Foundation

//D. Non-Secret Cypher
//time limit per test3 seconds
//memory limit per test256 megabytes
//inputstandard input
//outputstandard output
//Berland starts to seize the initiative on the war with Flatland. To drive the enemy from their native land, the berlanders need to know exactly how many more flatland soldiers are left in the enemy's reserve. Fortunately, the scouts captured an enemy in the morning, who had a secret encrypted message with the information the berlanders needed so much.
//
//The captured enemy had an array of positive integers. Berland intelligence have long been aware of the flatland code: to convey the message, which contained a number m, the enemies use an array of integers a. The number of its subarrays, in which there are at least k equal numbers, equals m. The number k has long been known in the Berland army so General Touristov has once again asked Corporal Vasya to perform a simple task: to decipher the flatlanders' message.
//
//Help Vasya, given an array of integers a and number k, find the number of subarrays of the array of numbers a, which has at least k equal numbers.
//
//Subarray a[i... j] (1 ≤ i ≤ j ≤ n) of array a = (a1, a2, ..., an) is an array, made from its consecutive elements, starting from the i-th one and ending with the j-th one: a[i... j] = (ai, ai + 1, ..., aj).
//
//Input
//The first line contains two space-separated integers n, k (1 ≤ k ≤ n ≤ 4·105), showing how many numbers an array has and how many equal numbers the subarrays are required to have, correspondingly.
//
//The second line contains n space-separated integers ai (1 ≤ ai ≤ 109) — elements of the array.
//
//Output
//Print the single number — the number of such subarrays of array a, that they have at least k equal integers.
//
//Please do not use the %lld specifier to read or write 64-bit integers in С++. In is preferred to use the cin, cout streams or the %I64d specifier.
//
//Examples
//inputCopy
//4 2
//1 2 1 2
//outputCopy
//3
//inputCopy
//5 3
//1 2 1 1 3
//outputCopy
//2
//inputCopy
//3 1
//1 1 1
//outputCopy
//6
//Note
//In the first sample are three subarrays, containing at least two equal numbers: (1,2,1), (2,1,2) and (1,2,1,2).
//
//In the second sample are two subarrays, containing three equal numbers: (1,2,1,1,3) and (1,2,1,1).
//
//In the third sample any subarray contains at least one 1 number. Overall they are 6: (1), (1), (1), (1,1), (1,1) and (1,1,1).


//MARK: - Start
struct HW3_CF_DNonSecretCypher {
    
    func start() {
        let input = getInput()
        print(getSubArraysWithRepeatNumbers(amount: input.amountOfMutualNumber, array: input.arrayOfIntegers))
    }
}

//MARK: - Input
private extension HW3_CF_DNonSecretCypher {
    func getInput() -> (amountOfMutualNumber: Int, arrayOfIntegers: [Int]) {
        print("Set imput for HW3_CF_DNonSecretCypher:")
        let firstLine = readLine()?.split(separator: " ")
        let amountOfMutualNumber = firstLine?.last.flatMap { Int($0) } ?? 0
        
        let secondLine = readLine()?.split(separator: " ")
        let arrayOfIntegers = secondLine?.map{ Int($0)! } ?? []
        
        return (amountOfMutualNumber, arrayOfIntegers)
    }
}

//MARK: - Execution
private extension HW3_CF_DNonSecretCypher {
    
    func getSubArraysWithRepeatNumbers(amount: Int, array: [Int]) -> Int {
        var repeatAmount = 0

        for l in 0..<array.count {
            var amountOfMetches = 0
            for r in l..<array.count {
                if array[l] == array[r] {
                    amountOfMetches += 1
                }
                
                if amountOfMetches >= amount {
                    repeatAmount += (array.count - r)
                    break
                }
            }
        }
        
        return repeatAmount
    }
    
//  Max solution
    private func fastCalcAmount(k: Int, items: [Int]) -> Int {
        guard k > 0 else { return 0 }
        var l = 0
        var total = 0
        var numbers = [Int: Int]()
        for r in 0..<items.count {
            let value = items[r]
            
            numbers[value, default: 0] += 1
            
            while (numbers[value] ?? 0) >= k {
                total += items.count - r
                numbers[items[l], default: 0] -= 1
                l += 1
            }
        }
        return total
    }
}
