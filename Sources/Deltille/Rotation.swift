//
//  Rotation.swift
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

extension Rotation {
    
    public static var identity: Self { Self(turns: 0) }
    public static var clockwise: Self { Self(turns: 1) }
    public static var counterClockwise: Self { Self(turns: -1) }
    
    public static func wrap(_ turns: Int) -> Int {
        
        ((turns % Self.turns) + Self.turns) % Self.turns
    }
    
    public var radians: Double {
        
        (.tau / Double(Self.turns)) * Double(turns)
    }
}

// MARK: Rotatable

public protocol Rotatable {
    
    associatedtype R = Rotation
    
    func rotate(_ rotation: R) -> Self
}
