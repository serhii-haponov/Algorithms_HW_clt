//
//  HW3_CF_BBooks.swift
//  Algorithms_HW_clt
//
//  Created by Serhii Haponov on 02.09.2022.
//

import Foundation

//https://codeforces.com/problemset/problem/279/B?locale=en

//B. Books
//time limit per test2 seconds
//memory limit per test256 megabytes
//inputstandard input
//outputstandard output
//When Valera has got some free time, he goes to the library to read some books. Today he's got t free minutes to read. That's why Valera took n books in the library and for each book he estimated the time he is going to need to read it. Let's number the books by integers from 1 to n. Valera needs ai minutes to read the i-th book.
//
//Valera decided to choose an arbitrary book with number i and read the books one by one, starting from this book. In other words, he will first read book number i, then book number i + 1, then book number i + 2 and so on. He continues the process until he either runs out of the free time or finishes reading the n-th book. Valera reads each book up to the end, that is, he doesn't start reading the book if he doesn't have enough free time to finish reading it.
//
//Print the maximum number of books Valera can read.
//
//Input
//The first line contains two integers n and t (1 ≤ n ≤ 105; 1 ≤ t ≤ 109) — the number of books and the number of free minutes Valera's got. The second line contains a sequence of n integers a1, a2, ..., an (1 ≤ ai ≤ 104), where number ai shows the number of minutes that the boy needs to read the i-th book.
//
//Output
//Print a single integer — the maximum number of books Valera can read.
//
//Examples
//input
//4 5
//3 1 2 1
//output
//3
//input
//3 3
//2 2 3
//output
//1

struct HW3_CF_BBooks {
    
    func start() {
        let input = readBBooksInput()
        let maxBooksNum = getMaxNumOfBooks(timeLimit: input.time, bookTimes: input.bookTimes)
        print(maxBooksNum)
    }
}


private extension HW3_CF_BBooks {
    struct Item {
        let time: Int
        let bookTimes: [Int]
    }
    
    func readBBooksInput() -> Item {
        print("Set imput for HW3_CF_BBooks:")
        let time = readLine()?.split(separator: " ").last.flatMap { Int($0) } ?? 0
        let bookTimes = readLine()?.split(separator: " ").compactMap { Int($0) } ?? []
        return Item(time: time, bookTimes: bookTimes)
    }
    
    func getMaxNumOfBooks(timeLimit: Int, bookTimes: [Int]) -> Int {

        var maxBooks = 0
        var currentBooks = 0
        var readTime = 0
        
        var L = 0
        
        for P in 0..<bookTimes.count {
            while (bookTimes[P] + readTime) > timeLimit {
                readTime -= bookTimes[L]
                currentBooks -= 1
                L += 1
            }
            
            currentBooks += 1
            readTime += bookTimes[P]
            maxBooks = max(maxBooks, currentBooks)
        }
        return maxBooks
    }
    
    // second variant:
    private func calcAmount(t: Int, books: [Int]) -> Int {
        guard t > 0 else { return 0 }
        var sum = 0
        var l = 0
        var total = 0
        for r in 0..<books.count {
            sum += books[r]
            while sum > t {
                sum -= books[l]
                l += 1
            }
            total = max(total, r - l + 1)
        }
        return total
    }
}
