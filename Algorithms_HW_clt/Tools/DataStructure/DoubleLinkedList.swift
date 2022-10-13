//
//  DoubleLinkedList.swift
//  Algorithms_HW_clt
//
//  Created by Serhii Haponov on 07.10.2022.
//

import Foundation

class DoubleLinkedList<Element> {
    
    class Node {
        var val: Element?
        var next: Node?
        var prev: Node?
        
        init(val: Element?, next: Node?, prev: Node?) {
            self.val = val
            self.next = next
            self.prev = prev
        }
    }
    
    private var head: Node = Node(val: nil, next: nil, prev: nil)
    private var tail: Node = Node(val: nil, next: nil, prev: nil)
    
    init() {
        head.next = tail
        tail.prev = head
    }
    
    func insertFirst(n: Node) {
        let currentFirst = head.next
        head.next = n
        n.next = currentFirst
        n.prev = head
        currentFirst?.prev = n
    }
    
    func remove(n: Node) {
        let prev = n.prev
        let next = n.next
        prev?.next = next
        next?.prev = prev
    }
}
