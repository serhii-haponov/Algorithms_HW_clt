//
//  HW3_HR_Raskin_Bobbins.swift
//  Algorithms_HW_clt
//
//  Created by Serhii Haponov on 24.08.2022.
//

import Foundation

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
