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
