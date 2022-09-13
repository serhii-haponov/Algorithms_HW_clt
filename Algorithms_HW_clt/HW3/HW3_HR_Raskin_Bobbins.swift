//
//  HW3_HR_Raskin_Bobbins.swift
//  Algorithms_HW_clt
//
//  Created by Serhii Haponov on 24.08.2022.
//

import Foundation

//https://www.hackerrank.com/contests/projector-algo-base-7-hw-2-123/challenges/raskin-bobbins

//Each time Sunny and Johnny take a trip to the Raskin Bobbins, they pool together  dollars for ice cream. On any given day, the Raskin Bobbins offers a line of  flavors. Each flavor, , is numbered sequentially with a unique ID number from  to  and has a cost, , associated with it.
//
//Given the value of  and the cost of each flavor for  trips to the Raskin Bobbins, help Sunny and Johnny choose two flavors such that they spend their entire pool of money () during each visit. For each trip to the Raskin Bobbins, print the ID numbers for the two types of ice cream that Sunny and Johnny purchase as two space-separated integers on a new line. You must print the smaller ID first and the larger ID second.
//
//Note: Two ice creams having unique IDs  and  may have the same cost (i.e.,  ).
//
//Input Format
//
//The first line contains an integer,  , denoting the number of trips to the Raskin Bobbins. The subsequent lines describe all of Sunny and Johnny's trips to the Raskin Bobbins; each trip is described as follows:
//
//The first line contains .
//The second line contains .
//The third line contains  space-separated integers denoting the cost of each respective flavor. The  integer corresponding to the cost, , for the ice cream with ID number  (where ).
//
//Constraints
//
//
//
//
//, where
//It is guaranteed that there will always be a unique solution. The sum of all -s in the input file will not exceed .
//
//Output Format
//
//Print two space-separated integers denoting the respective ID numbers for the flavors they choose to purchase, where the smaller ID is printed first and the larger ID is printed second. Recall that each ice cream flavor has a unique ID number in the inclusive range from  to .
//
//Sample Input 0
//
//2
//4
//5
//1 4 5 3 2
//4
//4
//2 2 4 3
//Sample Output 0
//
//1 4
//1 2

struct HW3_HR_Raskin_Bobbins {
    
    private func readRuskinInput1() -> [(m: Int, costs: [Int])] {
        let size = Int(readLine() ?? "") ?? 0

        var trips = [(m: Int, costs: [Int])]()
        for _ in 0..<size {
            let money = Int(readLine() ?? "") ?? 0
            let _ = Int(readLine() ?? "") ?? 0
            let items = (readLine() ?? "")
                .split(separator: " ")
                .compactMap({ Int($0) })

            trips.append((m: money, costs: items))
        }
        return trips
    }
    
    func find(m: Int, costs: [Int]) {
        let costs = costs.sorted { $0 < $1 }
        for i in 0..<costs.count {
            for j in i+1..<costs.count {
                if costs[i] + costs[j] == m {
                    i < j ?
                    print("\(i + 1) \(j + 1)") :
                    print("\(j + 1) \(i + 1)")
                }
            }
        }
    }
    
    
    func start2() {
        let datasourse = readRuskinInput1()
        for day in datasourse {
            find(m: day.m, costs: day.costs)
        }
    }
    
    
    func start() {
        print("Input")
        let datasourse = readRuskinInput1()
    
     for day in datasourse {
     outerLoop: for (i, iIceCost) in day.costs.enumerated() {
                for (j, jIceCost) in day.costs.enumerated() where j > i {
                    if iIceCost + jIceCost == day.m {
                        if i - j < 0 {
                            print("\(i + 1) \(j + 1)")
                            break outerLoop
                        } else {
                            print("\(j + 1) \(i + 1)")
                            break outerLoop
                        }
                    }
                }
                
            }
        }
    }
}

//2
//4
//5
//1 4 5 3 2
//4
//4
//2 2 4 3

// Max version
struct RaskinBobbins {
    struct Icecream {
        let id: Int
        var price: Int
    }

    let money: Int
    let prices: [Icecream]

    func purchaseIDs() -> [Int] {
        fast_v2()
    }

//    func fast_v1() -> [Int] {
//        let arr = prices.sorted(by: { $0.price < $1.price }) // N*logN
//
//        var bad = 0
//        var good = arr.count
//        let half = Int((Double(money) / 2).rounded(.up)) // m/2
//        // find first index more than half Money
//        while good - bad > 1 { // logN
//            let m = (good + bad) / 2
//            if arr[m].price >= half {
//                good = m
//            } else {
//                bad = m
//            }
//        }
//
//        let minIndex = good // more or equal to M/2
//        var i = minIndex
//        while i < arr.count, arr[i].price < money {
//            let firstPrice = money - arr[i].price
//            var bad = minIndex
//            var good = -1
//            while bad - good > 1 {
//                let m = (good + bad) / 2
//                if arr[m].price == firstPrice {
//                    return [ // result
//                        min(arr[m].id, arr[i].id),
//                        max(arr[m].id, arr[i].id)
//                    ]
//                } else if arr[m].price < firstPrice {
//                    good = m
//                } else {
//                    bad = m
//                }
//            }
//            i += 1
//        }
//
//        return []
//    }

    func fast_v2() -> [Int] {

        func findMoreOrEqual(price: Int, in arr: [Icecream],
                             badIndex: Int, goodIndex: Int) -> Int {
            var bad = badIndex
            var good = goodIndex
            // find first index more than half Money
            while good - bad > 1 { // logN
                let m = (good + bad) / 2
                if arr[m].price >= price {
                    good = m
                } else {
                    bad = m
                }
            }
            return good
        }

        let arr = prices.sorted(by: { $0.price < $1.price }) // N*logN
        let half = Int((Double(money) / 2).rounded(.up)) // m/2
        // find first index more than half Money
        // can't use i as minIndex because of corner case 2 equal half: [1, 2, 10, 10, 12]
        var i = findMoreOrEqual(price: half, in: arr,
                                badIndex: -1, goodIndex: arr.count)
        while i < arr.count, arr[i].price < money {
            let firstPrice = money - arr[i].price

            let matchIndex = findMoreOrEqual(price: firstPrice, in: arr,
                                             badIndex: -1, goodIndex: i)
            if matchIndex != i, arr[matchIndex].price == firstPrice {
                return [ // result
                    min(arr[matchIndex].id, arr[i].id),
                    max(arr[matchIndex].id, arr[i].id)
                ]
            }

            i += 1
        }

        return []
    }

    func slow() -> [[Int]] {
        var options = [[Int]]()
        for i in 0..<prices.count {
            for j in i+1..<prices.count {
                if prices[i].price + prices[j].price == money {
                    let result = [ // result
                        min(prices[i].id, prices[j].id),
                        max(prices[i].id, prices[j].id),
                    ]
                    options.append(result)
                }
            }
        }

        return options
    }
}

private func readRuskinInput() -> [RaskinBobbins] {
    let size = Int(readLine() ?? "") ?? 0

    var trips = [RaskinBobbins]()
    for _ in 0..<size {
        let money = Int(readLine() ?? "") ?? 0
        let _ = Int(readLine() ?? "") ?? 0
        let items = (readLine() ?? "")
            .split(separator: " ")
            .compactMap { Int($0) }
            .enumerated()
            .map({ RaskinBobbins.Icecream(id: $0.offset + 1, price: $0.element) })

        trips.append(RaskinBobbins(money: money, prices: items))
    }

    return trips
}
