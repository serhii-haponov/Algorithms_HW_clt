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
        executeCommands(input.baseStations, input.commands)
        
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
}
