//
//  HW6_BitStrings.swift
//  Algorithms_HW_clt
//
//  Created by Serhii Haponov on 25.10.2022.
//

import Foundation

//https://www.hackerrank.com/contests/projector-algo-base-7-hw-4-yfff/challenges/bit-strings
//https://www.hackerrank.com/projector-algo-base-7-hw-4-yfff

//Дан список битовых строк (т.е. строк, состоящих только из 0 и 1). В вашем распоряжении имеется несколько нулей и единиц. Найдите максимальное количество битовых строк из этого списка, которые вы можете создать, используя имеющиеся нули и единицы. Когда вы используете нолик или единичку, вы не можете использовать их снова.
//
//Input Format
//
//Первая строка входного файла содержит три целых числа n – количество строк, hasZeroes — количество доступных нулей, и hasOnes — количество доступных единиц. Cледущие n строк содержат строки Si из списка.
//
//Constraints
//
//1 ≤ n ≤ 20
//0 ≤ hasZeroes ≤ 500
//0 ≤ hasOnes ≤ 500
//1 ≤ length(Si) ≤ 50
//Si состоит только из символов 0 и 1
//Output Format
//
//Выведите максимальное количество строк в списке, которые можно создать используя имеющиеся нули и единицы.
//
//Sample Input 0
//
//3 3 1
//1
//00
//100
//Sample Output 0
//
//2
//Explanation 0
//
//Здесь у вас есть три нолика и одна единичка. Лучшее, что можно сделать — создать две первые две строки. Обратите внимание, что если вы создадите третью строку, то больше ничего не сможете создать потому что оставшихся символов будет недостаточно.
//
//Sample Input 1
//
//3 2 4
//00
//110
//101
//Sample Output 1
//
//2
//Explanation 1
//
//В этом случае у вас есть 2 нолика и 4 единички. Если вы создадите первую строку, то у вас закончатся нолики и больше вы ничего не сможете создать. Лучше создать вторую и третью строки.
//
//Sample Input 2
//
//20 500 500
//10101010101010101010101010101010101010101010101010
//10101010101010101010101010101010101010101010101010
//10101010101010101010101010101010101010101010101010
//10101010101010101010101010101010101010101010101010
//10101010101010101010101010101010101010101010101010
//10101010101010101010101010101010101010101010101010
//10101010101010101010101010101010101010101010101010
//10101010101010101010101010101010101010101010101010
//10101010101010101010101010101010101010101010101010
//10101010101010101010101010101010101010101010101010
//10101010101010101010101010101010101010101010101010
//10101010101010101010101010101010101010101010101010
//10101010101010101010101010101010101010101010101010
//10101010101010101010101010101010101010101010101010
//10101010101010101010101010101010101010101010101010
//10101010101010101010101010101010101010101010101010
//10101010101010101010101010101010101010101010101010
//10101010101010101010101010101010101010101010101010
//10101010101010101010101010101010101010101010101010
//10101010101010101010101010101010101010101010101010
//Sample Output 2
//
//20

//MARK: - Start
struct HW6_BitStrings {
    
    func start() {
        let input = getInput()
        print(calculate(a: input.a, i: 0, hasZeroes: input.hasZeroes, hasOnes: input.hasOnes))
    }
}

//MARK: - Input
private extension HW6_BitStrings {
    func getInput() -> (a: [String], hasZeroes: Int, hasOnes: Int) {
        let firstLine = readLine()?.split(separator: " ").compactMap { Int($0) } ?? []
        let n = firstLine[0]
        let hasZeroes = firstLine[1]
        let hasOnes = firstLine[2]
        var a: [String] = []
        for _ in 0..<n {
            let line = readLine() ?? ""
            a.append(line)
        }
        return (a: a, hasZeroes: hasZeroes, hasOnes: hasOnes)
    }
}

//MARK: - Execution
private extension HW6_BitStrings {
    
    func calculate(a: [String], i: Int, hasZeroes: Int, hasOnes: Int) -> Int {
        
        if a.count == i {
            return 0
        }
        
        let z = a[i].count(of: "0")
        let o = a[i].count(of: "1")
        
        var take = 0
        
        if hasZeroes >= z, hasOnes >= 0 {
            take = 1 + calculate(a: a, i: i + 1, hasZeroes: hasZeroes - z, hasOnes: hasOnes - o)
        }
        let skip = calculate(a: a, i: i + 1, hasZeroes: hasZeroes, hasOnes: hasOnes)
        return max(take, skip)
    }
}

extension String {
    func count(of needle: Character) -> Int {
        return reduce(0) {
            $1 == needle ? $0 + 1 : $0
        }
    }
}
