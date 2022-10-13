//
//  QueueRingBuffer.swift
//  Algorithms_HW_clt
//
//  Created by Serhii Haponov on 13.10.2022.
//

import Foundation

public struct QueueRingBuffer<T>: Queue {
  
  private var ringBuffer: RingBuffer<T>
  
  public init(count: Int) {
    ringBuffer = RingBuffer<T>(count: count)
  }
  
  public var isEmpty: Bool {
    return ringBuffer.isEmpty
  }
  
  public var peek: T? {
    return ringBuffer.first
  }
  
  public mutating func enqueue(_ element: T) -> Bool {
    return ringBuffer.write(element)
  }
  
  public mutating func dequeue() -> T? {
    return isEmpty ? nil : ringBuffer.read()
  }
}

extension QueueRingBuffer: CustomStringConvertible {
  
  public var description: String {
    return ringBuffer.description
  }
}
