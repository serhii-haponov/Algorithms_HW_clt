//
//  Stack.swift
//  Algorithms_HW_clt
//
//  Created by Serhii Haponov on 04.10.2022.
//

import Foundation

struct StackArray<Element> {
    fileprivate var array: [Element] = []
    
    var isEmpty: Bool {
      return array.isEmpty
    }

    var count: Int {
      return array.count
    }
    
    mutating func push(_ element: Element) {
        array.append(element)
    }
    
    mutating func pop() -> Element? {
      return array.popLast()
    }

    func peek() -> Element? {
      return array.last
    }
}

extension StackArray: CustomStringConvertible {
  var description: String {

    let topDivider = "---Stack---\n"
    let bottomDivider = "\n-----------\n"
      
    let stackElements = array.map { "\($0)" }.reversed().joined(separator: "\n")
      
    return topDivider + stackElements + bottomDivider
  }
}
