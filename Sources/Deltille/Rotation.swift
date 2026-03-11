//
//  Rotation.swift
//
//  Created by Zack Brown on 24/05/2024.
//

// MARK: Rotation

public protocol Rotation: Codable,
                          Hashable,
                          Sendable {
    
    static var inverse: Double { get }
    static var turn: Double { get }
    static var turns: Int { get }
    
    func wrap(_ turns: Int) -> Int
}

extension Rotation {
    
    public static var inverse: Double { .pi }
    public static var turn: Double { .tau / Double(turns) }
    
    public func wrap(_ turns: Int) -> Int {
        
        ((turns % Self.turns) + Self.turns) % Self.turns
    }
}

// MARK: Rotatable

public protocol Rotatable {
    
    associatedtype R = Rotation
    
    func rotate(_ rotation: R) -> Self
}
