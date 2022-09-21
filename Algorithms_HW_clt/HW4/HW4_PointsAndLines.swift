//
//  HW4_PointsAndLines.swift
//  Algorithms_HW_clt
//
//  Created by Serhii Haponov on 20.09.2022.
//

import Foundation

//Точки та відрізки
//
//Задано N відрізків на числовій прямій та M точок на цій же прямій.
//
//Для кожної з заданих точок визначте, скільком відрізкам вона належить.
//
//Точка x вважається такою, що належить відрізку з кінцями a та b, якщо виконується подвійна нерівність
//
//min(a, b) ≤ x ≤ max(a, b).
//
//Вхідні дані
//
//Перший рядок вхідного файлу містить два цілих числа N – кількість відрізків та M – кількість точок (1 ≤ N, M ≤ 105). У наступних N рядках по два цілих числа ai та bi – координати кінців відповідного відрізка. У останньому рядку M цілих чисел – координати точок. Усі числа у вхідному файлі не перевищують по модулю 109.
//
//Вихідні дані
//
//У вихідний файл виведіть M чисел – для кожної точки кількість відрізків, у яких вона міститься.

//Вхідні дані
//2 2
//0 5
//7 10
//1 6

//Вихідні дані
//1 0

//MARK: - Start
struct HW4_PointsAndLines {
    
    enum PointType {
        case start(p: Int)
        case end(p: Int)
        case point(id: Int, p: Int)
        
        func getPoint() -> Int {
            switch self {
            case .start(let p):
                return p
            case .end(let p):
                return p
            case .point( _, let p):
                return p
            }
        }
        
        func sortLine(_ p: PointType) -> Bool {
            let left = self.getPoint()
            let right = p.getPoint()
            
            if left == right {
                switch self {
                case .start:
                    return true
                case .end:
                    return false
                case .point:
                    switch p {
                    case .start:
                        return false
                    default:
                        return true
                    }
                }
            }
            return  left < right
        }
    }
    
    func start() {
        let input = getInput()
        print(execute(input))
    }
}

//MARK: - Input
//2 2
//0 5
//7 10
//1 6

private extension HW4_PointsAndLines {
    func getInput() -> [PointType] {
        print("Set imput for HW4_PointsAndLines:")
        let firstLine = readLine()?.split(separator: " ").compactMap { Int($0) } ?? []
        let numberOfLines = firstLine[0]
    
        var line: [PointType] = []
        var i = 0
        while i < numberOfLines {
            let pointsOfLine = readLine()?.split(separator: " ").compactMap { Int($0) } ?? []
            
            var startPoint = 0
            var endPint = 0
            if pointsOfLine[0] < pointsOfLine[1] {
                startPoint = pointsOfLine[0]
                endPint = pointsOfLine[1]
            } else {
                startPoint = pointsOfLine[1]
                endPint = pointsOfLine[0]
            }

            line.append(.start(p: startPoint))
            line.append(.end(p: endPint))
            i += 1
        }
        
        let points = readLine()?.split(separator: " ").compactMap { Int($0) }.enumerated().compactMap { PointType.point(id: $0, p: $1) } ?? []
        line.append(contentsOf: points)
        
        return line
    }
}

//MARK: - Execution
private extension HW4_PointsAndLines {
    
    func execute(_ line: [PointType]) -> String {
        let sortedLine = line.sorted { $0.sortLine($1) }
        
        var linesByPoints: [(id: Int, numberOfLinesInPoint: Int)] = []
        var numberOfLinesInPoint = 0
        
        for type in sortedLine {
            switch type {
            case .start:
                numberOfLinesInPoint += 1
            case .end:
                numberOfLinesInPoint -= 1
            case let .point(id, _):
                linesByPoints.append((id, numberOfLinesInPoint))
            }
        }
        
        //bottleneck
//        let strLineByPoints = linesByPoints
//            .sorted { $0.id < $1.id }
//            .map { String($0.numberOfLinesInPoint) }
//            .joined(separator: " ")
//
//        return strLineByPoints
        
        linesByPoints = linesByPoints
            .sorted(by: { $0.id < $1.id })

        var str = ""
        for item in linesByPoints {
            str += "\(item.numberOfLinesInPoint) "
        }
        return str
    }
}


// MARK: - Max Version
private struct Dot {
    let value: Int
    let type: Int
    let id: Int
}

func testEo4430() {
    let inputFast = readInputFast()
    let r1 = calcFast(timeline: inputFast)
    print(r1)
}
//testEo4430()

private func calcFast(timeline: [Dot]) -> String {
    var result: [(sum: Int, id: Int)] = []

    var count = 0
    for point in timeline {
        switch point.type {
        case -1:
            count += 1
        case 0:
            result.append((sum: count, id: point.id))
        case 1:
            count -= 1
        default:
            break
        }
    }

    result = result
        .sorted(by: { $0.id < $1.id })

    var str = ""
    for item in result {
        str += "\(item.sum) "
    }
    return str
}

private func readInputFast() -> [Dot] {
    let f1 = (readLine() ?? "")
        .split(separator: " ")
        .compactMap({ Int($0) })
    let n = f1[0]

    var timeline: [Dot] = []
    for _ in 0..<n {
        let f2 = (readLine() ?? "")
            .split(separator: " ")
            .compactMap({ Int($0) })

        let a = f2[0]
        let b = f2[1]
        timeline.append(Dot(value: min(a, b), type: -1, id: -1))
        timeline.append(Dot(value: max(a, b), type: 1, id: -1))
    }

    let points: [Dot] = (readLine() ?? "")
        .split(separator: " ")
        .enumerated()
        .compactMap({ item in Int(item.element).map { Dot(value: $0, type: 0, id: item.offset) } })

    timeline.append(contentsOf: points)

    timeline.sort(by: {
        $0.value != $1.value ? $0.value < $1.value : $0.type < $1.type
    })
    return timeline
}
