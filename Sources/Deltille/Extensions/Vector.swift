//
//  Vector.swift
//
//  Created by Zack Brown on 24/05/2024.
//

import Euclid
import Foundation

extension Vector: Identifiable {
    
    public var id: String { "[\(x), \(y), \(z)]" }
    
    public init(_ coordinate: Grid.Triangle.Coordinate,
                _ scale: Grid.Triangle.Scale) {
        
        let dx = Double(coordinate.y)
        let dy = Double(coordinate.x)
        let dz = Double(coordinate.z)
            
        self.init((0.5 * dx + -0.5 * dz) * scale.edgeLength,
                  0.0,
                  ((-.sqrt3d6 * dx) + (.sqrt3d3 * dy) - (.sqrt3d6 * dz)) * scale.edgeLength)
    }
    
    public init(_ coordinate: Grid.Hexagon.Coordinate,
                _ scale: Grid.Hexagon.Scale) {
        
        let dx = Double(coordinate.y)
        let dy = Double(coordinate.x)
        let dz = Double(coordinate.z)
            
        self.init((0.5 * dx + -0.5 * dz) * scale.edgeLength,
                  0.0,
                  ((-.sqrt3d6 * dx) + (.sqrt3d3 * dy) - (.sqrt3d6 * dz)) * scale.edgeLength)
    }
}

public extension Vector {
    
    static let forward = Self(0.0, 0.0, 1.0)
    static let up = Self(0.0, 1.0, 0.0)
    static let right = Self(1.0, 0.0, 0.0)
    
    func mid(_ other: Self) -> Self { lerp(other, 0.5) }
}
