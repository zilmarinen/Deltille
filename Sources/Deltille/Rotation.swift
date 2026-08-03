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
    
    static func wrap(_ turns: Int) -> Int
    
    init(_ turns: Int)
    
    var turns: Int { get }
    var radians: Double { get }
}

public extension Rotation {
    
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
