//
//  Rotation.swift
//
//  Created by Zack Brown on 24/05/2024.
//

// MARK: Rotation

public struct Rotation: Codable,
                        Hashable,
                        Sendable {
    
    public static let identity = Self(turns: 0)
    public static let clockwise = Self(turns: 1)
    public static let counterClockwise = Self(turns: -1)
    
    public let turns: Int
    
    public init(turns: Int) {
     
        self.turns = turns
    }
}

extension Rotation {
    
    public var radians: Double {
        
        guard turns != 0 else { return 0 }
        
        return .tau / Double(turns)
    }
}

// MARK: Rotatable

public protocol Rotatable {
    
    static var turns: Int { get }
    
    static func wrap(_ turns: Int) -> Int
    
    func rotate(_ rotation: Rotation) -> Self
}

extension Rotatable {
    
    public static func wrap(_ turns: Int) -> Int {
        
        ((turns % Self.turns) + Self.turns) % Self.turns
    }
}
