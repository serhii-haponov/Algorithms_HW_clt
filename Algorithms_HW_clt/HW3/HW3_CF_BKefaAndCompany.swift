//
//  HW3_CF_BKefaAndCompany.swift
//  Algorithms_HW_clt
//
//  Created by Serhii Haponov on 03.09.2022.
//

import Foundation

//https://codeforces.com/problemset/problem/580/B?locale=en

//B. Kefa and Company
//time limit per test2 seconds
//memory limit per test256 megabytes
//inputstandard input
//outputstandard output
//Kefa wants to celebrate his first big salary by going to restaurant. However, he needs company.
//
//Kefa has n friends, each friend will agree to go to the restaurant if Kefa asks. Each friend is characterized by the amount of money he has and the friendship factor in respect to Kefa. The parrot doesn't want any friend to feel poor compared to somebody else in the company (Kefa doesn't count). A friend feels poor if in the company there is someone who has at least d units of money more than he does. Also, Kefa wants the total friendship factor of the members of the company to be maximum. Help him invite an optimal company!
//
//Input
//The first line of the input contains two space-separated integers, n and d (1 ≤ n ≤ 105, ) — the number of Kefa's friends and the minimum difference between the amount of money in order to feel poor, respectively.
//
//Next n lines contain the descriptions of Kefa's friends, the (i + 1)-th line contains the description of the i-th friend of type mi, si (0 ≤ mi, si ≤ 109) — the amount of money and the friendship factor, respectively.
//
//Output
//Print the maximum total friendship factir that can be reached.
//
//Examples
//inputCopy
//4 5
//75 5
//0 100
//150 20
//75 1
//outputCopy
//100
//inputCopy
//5 100
//0 7
//11 32
//99 10
//46 8
//87 54
//outputCopy
//111
//Note
//In the first sample test the most profitable strategy is to form a company from only the second friend. At all other variants the total degree of friendship will be worse.
//
//In the second sample test we can take all the friends.

private struct Friend {
    let money: Int
    let friendshipFactor: Int
}

private struct FriendsChar {
    let diff: Int
    let friends: [Friend]
}

//MARK: - Start
struct HW3_CF_BKefaAndCompany {
    func start() {
      let input = getInput()
      print(calculateFriendAmount(friendsChar: input))
    }
}

//MARK: - Input
private extension HW3_CF_BKefaAndCompany {
    func getInput() -> FriendsChar {
        print("Set imput for HW3_CF_BKefaAndCompany:")
        let firstLine = readLine()?.split(separator: " ")
        let numOfFriends = firstLine?.first.flatMap { Int($0) } ?? 0
        let diffMoney = firstLine?.last.flatMap { Int($0) } ?? 0

        var friends: [Friend] = []
        for _ in 1...numOfFriends {
            let firstLine = readLine()?.split(separator: " ")
            let money = firstLine?.first.flatMap { Int($0) } ?? 0
            let friendshipFactor = firstLine?.last.flatMap { Int($0) } ?? 0
            let friend = Friend(money: money, friendshipFactor: friendshipFactor)
            friends.append(friend)
        }
        
        return FriendsChar(diff: diffMoney, friends: friends)
    }
}

//MARK: - Execution
private extension HW3_CF_BKefaAndCompany {
//    1 2 3 4 5 6 7 8 9
    
    func calculateFriendAmount(friendsChar: FriendsChar) -> Int {
        let sortedByMoney = friendsChar.friends.sorted { $0.money < $1.money }

        var bigestFriendshipFactor = 0
        var currentFriendshipFactor = 0
        var L = 0
        
        for P in 0..<sortedByMoney.count {
            while (sortedByMoney[P].money - sortedByMoney[L].money) >= friendsChar.diff  {
                currentFriendshipFactor -= sortedByMoney[L].friendshipFactor
                L += 1
            }
            currentFriendshipFactor += sortedByMoney[P].friendshipFactor
            bigestFriendshipFactor = max(bigestFriendshipFactor, currentFriendshipFactor)
        }
        
        return bigestFriendshipFactor
    }
}
