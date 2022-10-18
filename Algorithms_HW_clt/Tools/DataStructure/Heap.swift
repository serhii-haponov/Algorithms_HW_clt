//
//  Heap.swift
//  Algorithms_HW_clt
//
//  Created by Serhii Haponov on 16.10.2022.
//

// TODO:- need to check
import Foundation

struct Heap {
    
    var a: [Int] = [0] //with sentinal
    
    var count: Int { a.count - 1 }
    var peek: Int? { a[1] }
    var isEmpty: Bool { a.count < 2 }
    
    init(array: [Int] = []) {
        a.append(contentsOf: array)
        sortN()
    }
    
    mutating func insert(n: Int) {
        a.append(n)
        siftUp(index: count)
    }
    
    mutating func extractPeek() {
        guard count > 1 else { return }
        a[1] = a[count]
        a.remove(at: count)
        siftDown(index: 1)
    }
    
    mutating func extractBy(index: Int) {
        guard index <= count else { return }
        a[index] = a[count]
        a.remove(at: count)
        siftDown(index: index)
    }
    
    mutating func sortNLogN() { // NLogN
        for i in 1...count {
            siftUp(index: i)
        }
    }
    
    mutating func sortN() {
        for i in stride(from: count, to: 1, by: 1) {
            siftDown(index: i)
        }
    }
}

private extension Heap {
    
    mutating func siftUp(index: Int) { // logN
        var i = index
        while i > 0, a[i / 2] > a[i] {
            a.swapAt(a[i / 2], a[i])
            i /= 2
        }
    }
    
    mutating func siftDown(index: Int) { // N
        var i = index
        let i2 = 2 * i
        while i2 < count {
            var j = i
            
            if a[i2] < a[i] {
                j = i2
            }
            
            if i2 + 1 <= count, a[i2 + 1] < a[j] {
                j = i2 + 1
            }
            
            if j == i { break }
            
            a.swapAt(i, j)
            i = j
        }
    }
}
