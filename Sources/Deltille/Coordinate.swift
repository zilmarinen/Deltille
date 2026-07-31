//
//  Coordinate.swift
//  Deltille
//
//  Created by Zack Brown on 23/05/2024.
//

import Euclid
import Foundation

// MARK: Coordinate

public protocol Coordinate: Codable,
                            Equatable,
                            Hashable,
                            Identifiable,
                            Sendable {
    
    var x: Int { get }
    var y: Int { get }
    var z: Int { get }
    
    init(_ x: Int,
         _ y: Int,
         _ z: Int)
    
    init(_ vector: Vector,
         _ scale: Double)
    
    var id: String { get }
    
    var sum: Int { get }
    var equalToZero: Bool { get }
    var equalToOne: Bool { get }
    var equalToNegativeOne: Bool { get }
    
    var adjacent: [Self] { get }
    
    var vector: Vector { get }
    
    var xyz: (x: Int,
              y: Int,
              z: Int) { get }
    
    func distance(_ other: Self) -> Int
}

public extension Coordinate {
 
    static var zero: Self {
        
        .init(0, 0, 0)
    }
    
    static var one: Self {
        
        .init(1, 1, 1)
    }
    
    static var unitX: Self {
        
        .init(1, 0, 0)
    }
    
    static var unitY: Self {
        
        .init(0, 1, 0)
    }
    
    static var unitZ: Self {
        
        .init(0, 0, 1)
    }
}

public extension Coordinate {
    
    static func +(lhs: Self,
                  rhs: Self) -> Self {
        
        .init(lhs.x + rhs.x,
              lhs.y + rhs.y,
              lhs.z + rhs.z)
    }
    
    static func -(lhs: Self,
                  rhs: Self) -> Self {
        
        .init(lhs.x - rhs.x,
              lhs.y - rhs.y,
              lhs.z - rhs.z)
    }
    
    static prefix func -(rhs: Self) -> Self {
        
        .init(-rhs.x,
              -rhs.y,
              -rhs.z)
    }
    
    static func *(lhs: Self,
                  rhs: Int) -> Self {
        
        .init(lhs.x * rhs,
              lhs.y * rhs,
              lhs.z * rhs) }
}


public extension Coordinate {
    
    var id: String {
        
        "[\(x), \(y), \(z)]"
    }
    
    var sum: Int {
        
        x + y + z
    }
    
    var equalToZero: Bool {
        
        sum == 0
    }
    
    var equalToOne: Bool {
        
        sum == 1
    }
    
    
    var equalToNegativeOne: Bool {
        
        sum == -1
    }
    
    var adjacent: [Self] {
        
        [self + .unitX,
         self - .unitZ,
         self + .unitY,
         self - .unitX,
         self + .unitZ,
         self - .unitY]
    }
    
    var vector: Vector {
        
        .init(self)
    }
    
    var xyz: (x: Int,
              y: Int,
              z: Int) {
        
        (x, y, z)
    }
}

public extension Coordinate {
    
    init(_ vector: Vector,
         _ scale: Double = 1.0) {
        
        let quantised = vector.quantised(scale)
        
        self.init(quantised.x,
                  quantised.y,
                  quantised.z)
    }
    
    func distance(_ other: Self) -> Int {
        
        (abs(x - other.x) +
         abs(y - other.y) +
         abs(z - other.z))
    }
}
