//
//  LinkedList.swift
//  Algorithms_HW_clt
//
//  Created by Serhii Haponov on 04.10.2022.
//

import Foundation

class LinkedList<Element> {
    
    private class Node: Equatable, CustomStringConvertible {
        let data: Element?
        var next: Node?
        
        init(data: Element?, next: Node?) {
            self.data = data
            self.next = next
        }
        
        static func == (lhs: LinkedList<Element>.Node, rhs: LinkedList<Element>.Node) -> Bool {
          return  lhs.next == rhs.next
        }
        
        public var description: String {
          guard let next = next else {
            return "\(data!)"
          }
          return "\(data!) -> " + String(describing: next) + " "
        }
    }
    
    private let sentinel: Node
    private var size: Int
    
    init() {
        sentinel = Node(data: nil, next: nil)
        size = 0
    }
    
    init(val: Element) {
        sentinel = Node(data: nil, next: nil)
        sentinel.next = Node(data: val, next: nil)
        size = 1
    }
    
    func insertFirst(val: Element) {
        sentinel.next = Node(data: val, next: sentinel.next)
        size += 1
    }
    
    func insertLast(val: Element) {
        var craw: Node? = sentinel
        while craw?.next != nil {
            craw = craw?.next
        }
        craw?.next = Node(data: val, next: nil)
        size += 1
    }
    
    func first() -> Element? {
        sentinel.next?.data
    }
    
    func count() -> Int {
        return size
    }
    
    @discardableResult
    func filter(_ iteraction: (Element) -> Bool) -> [Element] {
        var filteredElements: [Element] = []
        var craw: Node? = sentinel
        while craw != nil {
            if craw != sentinel {
                let accept = iteraction(craw!.data!)
                if accept {
                    filteredElements.append(craw!.data!)
                }
            }
            craw = craw?.next
        }
        return filteredElements
    }
    
    func iterateWhileTrue(_ iteraction: (Element) -> Bool) {
        var craw: Node? = sentinel
        while craw != nil {
            if craw != sentinel {
                let needToFinish = iteraction(craw!.data!)
                if needToFinish {
                    return
                }
            }
            craw = craw?.next
        }
    }

    func description() {
        var craw: Node? = sentinel
        while craw != nil {
            if craw != sentinel {
                print(craw!.data!)
            }
            craw = craw?.next
        }
    }
    
    func descriptionFirst(_ elementsNum: Int) -> [Element?] {
        var counter = 0
        var elements: [Element?] = []
        var craw: Node? = sentinel
        while craw != nil && counter <= elementsNum {
            if craw != sentinel {
                elements.append(craw?.data)
            }
            craw = craw?.next
            counter += 1
        }
        return elements
    }
}
