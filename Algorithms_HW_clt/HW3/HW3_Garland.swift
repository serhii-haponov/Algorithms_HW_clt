//
//  HW3_Garland.swift
//  Algorithms_HW_clt
//
//  Created by Serhii Haponov on 09.09.2022.
//

import Foundation

//https://www.hackerrank.com/contests/projector-algo-base-7-hw-2-123/challenges/garland

//The New Year garland consists of  lamps attached to a common wire that hangs down on the ends to which outermost lamps are affixed. The wire sags under the weight of lamp in a particular way: each lamp is hanging at the height that is  millimeter lower than the average height of the two adjacent lamps.
//
//The leftmost lamp is hanging at the height of  millimeters above the ground. You have to determine the lowest height  of the rightmost lamp so that no lamp in the garland lies on the ground though some of them may touch the ground.
//
//You shall neglect the lamp's size in this problem. By numbering the lamps with integers from  to and denoting the  lamp height in millimeters as  we derive the following equations:
//
//
//The sample garland with 8 lamps that is shown on the picture has  and .
//
//image
//
//Input Format
//
//The input consists of a single line with two numbers  and  separated by a space.  is an integer representing the number of lamps in the garland,  is a real number representing the height of the leftmost lamp above the ground in millimeters.

//Output Format
//
//Write to the output the single number  representing the lowest possible height of the rightmost lamp. Your answer must be within  absolute error of the actual result.
//
//Sample Input 0
//
//8 15
//Sample Output 0
//
//9.75
//Sample Input 1
//
//692 532.81
//Sample Output 1
//
//446113.344348

//MARK: - Start
struct HW3_Garland {
    
    func start() {
        let input = getInput()
        print(calculateLastLampHeight(lamps: input.lamps, startHaight: input.startHaight))
    }
}

//MARK: - Input
private extension HW3_Garland {
    func getInput() -> (lamps: Int, startHaight: Double) {
        print("Set imput for HW3_Garland:")
        let firstLine = readLine()?.split(separator: " ") ?? []
        let lamps = Int(firstLine[0]) ?? 0
        let startHaight = Double(firstLine[1]) ?? 0.0
        return (lamps, startHaight)
    }
}

//MARK: - Execution
private extension HW3_Garland {
    
    //        h[i] = (h[i - 1] + h[i + 1]) / 2 - 1
    //        h[i] = h[i - 1]/2 + h[i + 1]/2 - 1
    //       - h[i + 1]/2 = h[i - 1]/2 - h[i]  - 1
    //        h[i + 1] = 2h[i] - h[i - 1] + 2
    
    func calculateLastLampHeight(lamps: Int, startHaight: Double) -> Double {
        var minRange = 0.0
        var maxRange = startHaight
        var middle = (minRange + maxRange) / 2
        
        var minFinishHaight = 0.0
        
        while maxRange != middle, minRange != middle {
            var firstHeight = startHaight
            var secondHeight = middle
            var thirdHaight = 0.0
            
            for i in 3...lamps {
                thirdHaight = 2 * secondHeight - firstHeight + 2
                print("-----\(i)-------")
                print(firstHeight, secondHeight)
                print(thirdHaight)
                if thirdHaight < 0 { break }
                firstHeight = secondHeight
                secondHeight = thirdHaight
            }
            
            if thirdHaight > firstHeight {
                minFinishHaight = thirdHaight
                maxRange = middle
            } else {
                minRange = middle
            }
                        
            middle = (minRange + maxRange) / 2
        }
        
        return minFinishHaight
    }
}
