//
//  Rotation.swift
//  Deltille
//
//  Created by Zack Brown on 24/05/2024.
//

// MARK: Rotation

public protocol Rotation: Codable,
                          Hashable,
                          Sendable {
    
    static var turns: Int { get }
    
    static var identity: Self { get }
    static var clockwise: Self { get }
    static var counterClockwise: Self { get }
    
    static func wrap(_ turns: Int) -> Int
    
    init(turns: Int)
    
    var turns: Int { get }
    var radians: Double { get }
}

public extension Rotation {
    
    static var identity: Self {
        
        .init(turns: 0)
    }
    
    static var clockwise: Self {
        
        .init(turns: 1)
    }
    
    static var counterClockwise: Self {
        
        .init(turns: -1)
    }
    
    static func wrap(_ turns: Int) -> Int {
        
        ((turns % Self.turns) + Self.turns) % Self.turns
    }
    
    var radians: Double {
        
        (.tau / Double(Self.turns)) * Double(turns)
    }
}

// MARK: Rotatable

public protocol Rotatable {
    
    associatedtype R = Rotation
    
    func rotate(_ rotation: R) -> Self
}
