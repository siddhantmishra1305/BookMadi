//
//  Queue.swift
//  BookMadi
//
//  Created by Siddhant Mishra on 24/02/21.
//

import Foundation

public protocol Queue {
    associatedtype Element
    mutating func enqueue(_ element: Element)
    mutating func dequeue() -> Element?
    func count() -> Int
    var isEmpty: Bool { get }
    var peek: Element? { get }
}

public struct QueueArray<T:Equatable>: Queue {
    public func count() -> Int {
        return array.count
    }
    
    private var array: [T] = []
    
    public init() {}
    
    public var isEmpty: Bool {
        array.isEmpty // 1
    }
    
    public var peek: T? {
        array.first // 2
    }
    
    public mutating func enqueue(_ element: T)  {
        array.append(element)
    }
    
    public func contain(_ element: T) ->Bool {
        return array.contains(element)
    }
    
    public mutating func dequeue() -> T? {
        isEmpty ? nil : array.removeFirst()
    }
    
    

    public func getAllElements() -> String?{

        var seats = String()
        for item in array{
            seats = "\(seats)\(item),"
        }
        
        return String(seats.dropLast())
    }
}

