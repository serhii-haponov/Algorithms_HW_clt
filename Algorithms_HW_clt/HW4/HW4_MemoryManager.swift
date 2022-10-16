//
//  HW4_MemoryManager.swift
//  Algorithms_HW_clt
//
//  Created by Serhii Haponov on 05.10.2022.
//

//https://informatics.msk.ru/mod/statements/view.php?chapterid=10#1

//Задача №10. Менеджер памяти
//Пете поручили написать менеджер памяти для новой стандартной библиотеки языка H++. В распоряжении у менеджера находится массив из N последовательных ячеек памяти, пронумерованных от 1 до N. Задача менеджера — обрабатывать запросы приложений на выделение и освобождение памяти.
//
//Запрос на выделение памяти имеет один параметр K. Такой запрос означает, что приложение просит выделить ему K последовательных ячеек памяти. Если в распоряжении менеджера есть хотя бы один свободный блок из K последовательных ячеек, то он обязан в ответ на запрос выделить такой блок. При этом непосредственно перед самой первой ячейкой памяти выделяемого блока не должно располагаться свободной ячейки памяти. После этого выделенные ячейки становятся занятыми и не могут быть использованы для выделения памяти, пока не будут освобождены. Если блока из K последовательных свободных ячеек нет, то запрос отклоняется.
//
//Запрос на освобождение памяти имеет один параметр T. Такой запрос означает, что менеджер должен освободить память, выделенную ранее при обработке запроса с порядковым номером T. Запросы нумеруются, начиная с единицы. Гарантируется, что запрос с номером T — запрос на выделение, причем к нему еще не применялось освобождение памяти. Освобожденные ячейки могут снова быть использованы для выделения памяти. Если запрос с номером T был отклонен, то текущий запрос на освобождение памяти игнорируется.
//
//Требуется написать менеджер памяти, удовлетворяющий приведенным критериям.
//
//Входные данные
//В первой строке входных данных задаются числа N и M — количество ячеек памяти и количество запросов, соответственно (1 ≤ N ≤ 231 – 1; 1 ≤ M ≤ 105). Каждая из следующих M строк содержит по одному числу: (i+1)-я строка входных данных (1 ≤ i ≤ M) содержит либо положительное число K, если i-й запрос — запрос на выделение с параметром K (1 ≤ K ≤ N), либо отрицательное число –T, если i-й запрос — запрос на освобождение с параметром T (1 ≤ T < i).
//
//Выходные данные
//Для каждого запроса на выделение памяти выведите результат обработки этого запроса: для успешных запросов выведите номер первой ячейки памяти в выделенном блоке, для отклоненных запросов выведите число –1. Результаты нужно выводить в порядке следования запросов во входных данных
//
//Примеры
//входные данные
//42 9
//7
//3
//8
//-2
//6
//5
//-5
//9
//4
//выходные данные
//1
//8
//11
//19
//25
//30
//19
//Сдать: для сдачи задач необходимо войти в систему

import Foundation

class LinkedListMemory {
    
    private class Node {
        var id: Int // id == 0 is a free space
        var bufferSize: Int
        var next: Node?
        var prev: Node?
        
        init(bufferSize: Int, next: Node?, prev: Node?, id: Int) {
            self.bufferSize = bufferSize
            self.next = next
            self.prev = prev
            self.id = id
        }
    }
    
    private let head: Node = Node(bufferSize: 0, next: nil, prev: nil, id: -1)
    private let tail: Node = Node(bufferSize: 0, next: nil, prev: nil, id: -1)
    private let capacity: Int
    private var filledSpace: Int
    
    private var freeSpace: Int {
        capacity - filledSpace
    }

    init(capacity: Int) {
        self.capacity = capacity
        filledSpace = 0
        head.next = tail
        tail.prev = head
    }
    
//    init(val: Int, id: Int, capacity: Int) {
//        sentinel = Node(bufferSize: 0, next: nil, id: 0)
//        sentinel.next = Node(bufferSize: val, next: nil, id: id)
//        filledSpace = val
//        self.capacity = capacity
//    }
    
    func insert(val: Int, id: Int) -> Int {
        guard freeSpace >= val else {
            return -1
        }
        var counter = 1
        
        var craw = head.next
        while craw !== tail {
            if let unwCraw = craw, unwCraw.id == 0 {
                if unwCraw.bufferSize > val {
                    let insertionNode = Node(bufferSize: val, next: craw, prev: craw?.prev, id: id)
                    unwCraw.prev?.next = insertionNode
                    unwCraw.prev = insertionNode
                    unwCraw.bufferSize -= val
                    return counter
                }
                
                if unwCraw.bufferSize == val {
                    unwCraw.id = id
                    return counter
                }
            }
            counter += craw!.bufferSize
            craw = craw?.next
        }
            
        if capacity - (counter - 1) >= val {
            let insertionNode = Node(bufferSize: val, next: tail, prev: craw?.prev, id: id)
            tail.prev?.next = insertionNode
            tail.prev = insertionNode
            filledSpace += val
            return counter
        }
    
        return -1
    }
        
    func remove(id: Int) {
        var craw = head.next
        while craw !== tail {
            if let craw = craw, craw.id == id {
                var val = craw.bufferSize
                
                if let crawPrew = craw.prev, crawPrew.id == 0 {
                    val += crawPrew.bufferSize
                    crawPrew.prev?.next = craw
                    craw.prev = crawPrew.prev
                }
                
                if let crawNext = craw.next, crawNext.id == 0 {
                    val += crawNext.bufferSize
                    crawNext.next?.prev = craw
                    craw.next = crawNext.next
                }
                
                craw.id = 0
                craw.bufferSize = val
                filledSpace -= val
                return
            }
            craw = craw?.next
        }
    }
        
    func count() -> Int {
        return filledSpace
    }
    
}

//MARK: - Start
struct HW4_MemoryManager {
    
    func start() {
        let input = getInput()
        print("Start")
        let dll = LinkedListMemory(capacity: input.memoryCapacity)
        
        for (i, q) in input.queries.enumerated() {
            if q > 0 {
              print(dll.insert(val: q, id: i + 1))
            } else {
                let id = abs(q)
                dll.remove(id: id)
            }
            
        }
        
        print(input)
    }
}

//MARK: - Input
private extension HW4_MemoryManager {
    
    struct QueryData {
        let memoryCapacity: Int
        let queriesAmount: Int
        let queries: [Int]
    }
    
    func getInput() -> QueryData {
        
        let firstLine = readLine()?.split(separator: " ").compactMap { Int($0) } ?? []
        let memoryCapacity = firstLine[0]
        let queryAmount = firstLine[1]
        
        var queries: [Int] = []
        for _ in 0..<queryAmount {
            let q = Int(readLine()!)!
            queries.append(q)
        }
        
        return QueryData(memoryCapacity: memoryCapacity,
                         queriesAmount: queryAmount,
                         queries: queries)
    }
}

//MARK: - Execution
private extension HW4_MemoryManager {
    

}


//
