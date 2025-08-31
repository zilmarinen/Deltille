//
//  Rotation.swift
//
//  Created by Zack Brown on 24/05/2024.
//

// MARK: Rotation

public protocol Rotation: CaseIterable,
                          Codable,
                          Hashable,
                          Identifiable,
                          Sendable {
    
    static var inverse: Double { get }
    static var step: Double { get }
}

// MARK: Rotatable

public protocol Rotatable {
    
    associatedtype R = Rotation
    
    func rotate(_ rotation: R) -> Self
}
