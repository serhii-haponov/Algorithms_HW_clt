//
//  HW4_Lvivstar.swift
//  Algorithms_HW_clt
//
//  Created by Serhii Haponov on 16.09.2022.
//

import Foundation

//MARK: - Start
struct HW4_Lvivstar {
    
    fileprivate enum CommandsType {
        case COUNT(fromId: Int, toId: Int)
        case ENTER(id: Int)
        case LEAVE(id: Int)
        case unknowed
        
        static func getCommandFromStr(_ line: String) -> CommandsType {
            let data = line.split(separator: " ")
            
            switch data.first {
            case "COUNT":
                let fromId = Int(data[1])!
                let toId = Int(data[2])!
                return COUNT(fromId: fromId, toId: toId)
            case "ENTER":
                let id = Int(data[1])!
                return ENTER(id: id)
            case "LEAVE":
                let id = Int(data[1])!
                return LEAVE(id: id)
            default:
                return .unknowed
            }
        }
    }
    
    func start() {
        let input = getInput()
        executeCommands2(input.baseStations, input.commands)
        
    }
}

//MARK: - Input
private extension HW4_Lvivstar {
    func getInput() -> (baseStations: [Int], commands: [CommandsType]) {
        print("Set imput for HW4_Lvivstar:")
        _ = readLine()?.split(separator: " ")
        let secondLine = readLine()!.split(separator: " ")
        let baseStations = secondLine.map { Int($0)! }
        let thirdLine = readLine()!
        let numberOfComands = Int(thirdLine)!
        
        var commands: [CommandsType] = []
        
        for _ in 0..<numberOfComands {
            let line = readLine()!
            let command = CommandsType.getCommandFromStr(line)
            commands.append(command)
        }
        
        return (baseStations, commands)
    }
}

//MARK: - Execution
private extension HW4_Lvivstar {
    
    //brute_forse
    func executeCommands(_ baseStations: [Int], _ commands: [CommandsType]) {
        var stations = baseStations
        
        for com in commands {
            switch com {
            case .COUNT(let fromId, let toId):
                var counter = 0
                for i in (fromId - 1)..<toId {
                    counter += stations[i]
                }
                print(counter)
            case .ENTER(let id):
                stations[id - 1] += 1
            case .LEAVE(let id):
                stations[id - 1] -= 1
            case .unknowed:
                print("error")
            }
        }
    }
    
    //    2 0 2 3 1
    func executeCommands2(_ baseStations: [Int], _ commands: [CommandsType]) {
        
        let sqrtInterval = Int(sqrt(Double(baseStations.count)))
        var intervals: [Int] = []
        var sum = 0
        
        for i in 0..<baseStations.count {
            if (i % sqrtInterval == 0 && i != 0) {
                intervals.append(sum)
                sum = baseStations[i]
                if i == baseStations.count - 1 {
                    intervals.append(sum)
                }
            } else {
                sum += baseStations[i]
            }
        }
        
        func positionInInterval(for id: Int) -> (intervalId: Int, idPosition: Int) {
            let intervalId = (id + 1) / sqrtInterval - 1
            let idPosition = (id - 1) % sqrtInterval
            return (intervalId, idPosition)
        }
        
        var baseStations = baseStations
        
        for com in commands {
            switch com {
            case .COUNT(let fromId, let toId):
                
                let lowPosition = positionInInterval(for: fromId)
                let upperPosition = positionInInterval(for: toId)
                
                if lowPosition.intervalId != upperPosition.intervalId {
                    
                    var lowSum = intervals[lowPosition.intervalId]
                    for i in 0..<lowPosition.idPosition {
                        lowSum -= (baseStations[fromId - 1 - lowPosition.idPosition + i])
                    }
                    
                    var upperSum = intervals[upperPosition.intervalId]
                    for i in upperPosition.idPosition...sqrtInterval {
                        guard toId + i < baseStations.count else { break }
                        upperSum -= (baseStations[toId + i])
                    }
                    
                    var sum = lowSum + upperSum
                    
                    for i in (lowPosition.intervalId + 1)..<upperPosition.intervalId {
                        sum += intervals[i]
                    }
                    
                    print(sum)
                } else {
                    print("implement one grab solution")
                }
                
                
                //                let lowPositionInterval = (fromId + 1) / sqrtInterval - 1
                //                let positionInInterval =  (fromId - 1) % sqrtInterval
                
                //                var lowSum = intervals[lowPosition.intervalId]
                //                for i in 0..<lowPosition.idPosition {
                //                    lowSum -= (baseStations[fromId - 1 - lowPosition.idPosition + i])
                //                }
                
                //                print(counter)
            case .ENTER(let id):
                print("ENTER")
                baseStations[id - 1] += 1
                let position = positionInInterval(for: id)
                intervals[position.intervalId] += 1
            case .LEAVE(let id):
                print("LEAVE")
                baseStations[id - 1] -= 1
                let position = positionInInterval(for: id)
                intervals[position.intervalId] -= 1
            case .unknowed:
                print("error")
            }
        }
        
    }
}
