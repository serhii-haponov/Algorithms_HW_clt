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
                let fromId = Int(data[1])! - 1
                let toId = Int(data[2])! - 1
                return COUNT(fromId: fromId, toId: toId)
            case "ENTER":
                let id = Int(data[1])! - 1
                return ENTER(id: id)
            case "LEAVE":
                let id = Int(data[1])! - 1
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
    // MARK: -  bottleneck using !
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
                for i in fromId..<toId {
                    counter += stations[i]
                }
                print(counter)
            case .ENTER(let id):
                stations[id] += 1
            case .LEAVE(let id):
                stations[id] -= 1
            case .unknowed:
                print("error")
            }
        }
    }
    
    //    2 0 2 3 1
    func executeCommands2(_ baseStations: [Int], _ commands: [CommandsType]) {
        
//        let sqrtInterval = Int(sqrt(Double(baseStations.count)))
//        var intervals: [Int] = []
        
        
           let n = baseStations.count
           let sqrtInterval = Int(sqrt(Double(n)))
           let sizePerChunk = Int((Double(n) / Double(sqrtInterval)).rounded(.up))
           var intervals = Array(repeating: 0, count: sqrtInterval)

           func getChunkIndex(for i: Int) -> Int {
               i / sizePerChunk
           }

           for i in 0..<n {
               let chIndex = getChunkIndex(for: i)
               intervals[chIndex] += baseStations[i]
           }
        
//        var sum = 0
//        var intervalSeparator = sqrtInterval
//        for i in 0..<baseStations.count {
//            if i < intervalSeparator {
//                sum += baseStations[i]
//            } else {
//                intervals.append(sum)
//                sum = baseStations[i]
//                intervalSeparator += sqrtInterval
//            }
//
//            if  i >= baseStations.count - 1 {
//                intervals.append(sum)
//            }
//        }
        
        func positionInInterval(for id: Int) -> (intervalId: Int, idPosition: Int) {
            let intervalId = id / sizePerChunk
            let idPosition = id % sizePerChunk
            return (intervalId, idPosition)
        }
        
        var baseStations = baseStations
        
        var output = ""
        
        for com in commands {
            switch com {
            case .COUNT(let fromId, let toId):
                
                let lowPosition = positionInInterval(for: fromId)
                let upperPosition = positionInInterval(for: toId)
                var sum = 0
                
                if lowPosition.intervalId != upperPosition.intervalId {
                    var lowSum = intervals[lowPosition.intervalId]
                    for i in 0..<lowPosition.idPosition {
                        lowSum -= (baseStations[fromId - lowPosition.idPosition + i])
                    }
                    // MARK: -   bottleneck using For loop instad while
                    var upperSum = 0
                    for i in 0...upperPosition.idPosition {
                        upperSum += baseStations[toId - i]
                    }
                    
                    sum = lowSum + upperSum
                    
                    for i in (lowPosition.intervalId + 1)..<upperPosition.intervalId {
                        sum += intervals[i]
                    }
                } else {
                    for i in fromId...toId {
                        sum += baseStations[i]
                    }
                }
                output += "\(sum)\n"
            case .ENTER(let id):
                baseStations[id] += 1
                let intervalId = id / sizePerChunk
                intervals[intervalId] += 1
            case .LEAVE(let id):
                baseStations[id] -= 1
                let intervalId = id / sizePerChunk
                intervals[intervalId] -= 1
            case .unknowed:
                print("error")
            }
        }
        print(output)
    }
}


// MARK: - MAX SOLUTION
struct Lvivstar {
    enum Command {
        case count(l: Int, r: Int)
        case enter(Int)
        case leave(Int)
    }

    var commands: [Command] = []
    var usersPerStation: [Int] = []

    func execute() {
        var usersPerStation = usersPerStation
        let n = usersPerStation.count
        let chunksAmount = Int(sqrt(Double(n)))
        let sizePerChunk = Int((Double(n) / Double(chunksAmount)).rounded(.up))
        var chunksSums = Array(repeating: 0, count: chunksAmount)

        func getChunkIndex(for i: Int) -> Int {
            i / sizePerChunk
        }

        for i in 0..<n {
            let chIndex = getChunkIndex(for: i)
            chunksSums[chIndex] += usersPerStation[i]
        }

        var output = ""
        for item in commands {
            switch item {
            case let .count(l, r):
                let leftChunkIndex = getChunkIndex(for: l)
                let rightChunkIndex = getChunkIndex(for: r)

                var res = 0
                if leftChunkIndex == rightChunkIndex {
                    for i in l...r {
                        res += usersPerStation[i]
                    }
                } else {
                    var i = leftChunkIndex + 1
                    while i < rightChunkIndex {
                        res += chunksSums[i]
                        i += 1
                    }

                    i = l
                    let max = (leftChunkIndex + 1) * sizePerChunk
                    while i < max {
                        res += usersPerStation[i]
                        i += 1
                    }

                    i = rightChunkIndex * sizePerChunk
                    while i <= r {
                        res += usersPerStation[i]
                        i += 1
                    }
                }
                output += "\(res)\n"
            case .enter(let i):
                let chIndex = getChunkIndex(for: i)
                chunksSums[chIndex] += 1
                usersPerStation[i] += 1
            case .leave(let i):
                let chIndex = getChunkIndex(for: i)
                chunksSums[chIndex] -= 1
                usersPerStation[i] -= 1
            }
        }
        print(output)
    }
    
    func readInput() -> Lvivstar {
        let _ = Int(readLine() ?? "") ?? 0
        let users = (readLine() ?? "")
            .split(separator: " ")
            .compactMap({ Int($0) })
        let q = Int(readLine() ?? "") ?? 0

        var commands: [Lvivstar.Command] = []
        for _ in 0..<q {
            let commandStr = (readLine() ?? "")
                .split(separator: " ")

            switch commandStr[0] {
            case "COUNT":
                let l = (Int(commandStr[1]) ?? 0) - 1
                let r = (Int(commandStr[2]) ?? 0) - 1
                commands.append(.count(l: l, r: r))
            case "ENTER":
                let i = (Int(commandStr[1]) ?? 0) - 1
                commands.append(.enter(i))
            case "LEAVE":
                let i = (Int(commandStr[1]) ?? 0) - 1
                commands.append(.leave(i))
            default:
                break
            }
        }

        return Lvivstar(commands: commands, usersPerStation: users)
    }

    func start() {
        readInput().execute()
    }
}

