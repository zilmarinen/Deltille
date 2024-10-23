//
//  Vector.swift
//
//  Created by Zack Brown on 24/05/2024.
//

import Euclid
import Foundation

extension Vector: Identifiable {
    
    public var id: String { "[\(x), \(y), \(z)]" }
    
    public init(_ coordinate: Grid.Coordinate,
                _ scale: Grid.Triangle.Scale) {
        
        let dx = Double(coordinate.y)
        let dy = Double(coordinate.x)
        let dz = Double(coordinate.z)
        
        self.init((0.5 * dx + -0.5 * dz) * scale.edgeLength,
                  0.0,
                  ((-.sqrt3d6 * dx) + (.sqrt3d3 * dy) - (.sqrt3d6 * dz)) * scale.edgeLength)
    }
    
    public init(_ coordinate: Grid.Coordinate,
                _ scale: Grid.Hexagon.Scale) {
        
        let dx = Double(coordinate.y)
        let dy = Double(coordinate.x)
        let dz = Double(coordinate.z)
        
        self.init((dx - 0.5 * dy - 0.5 * dz) * scale.edgeLength,
                  0.0,
                  ((.sqrt3d2 * dy) - (.sqrt3d2 * dz)) * scale.edgeLength)
    }
}

public extension Vector {
    
    func mid(_ other: Self) -> Self { lerp(other, 0.5) }
}
