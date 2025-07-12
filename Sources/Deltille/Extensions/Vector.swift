//
//  Vector.swift
//
//  Created by Zack Brown on 24/05/2024.
//

import Euclid
import Foundation

// MARK: Vector

extension Vector: @retroactive Identifiable {
    
    public var id: String { "[\(x), \(y), \(z)]" }
}

extension Vector {
    
    public func mid(_ lhs: Self) -> Self { lerp(lhs, 0.5) }
}

// MARK: Triangle

extension Vector {
    
    public init(_ vertex: Grid.Triangle.Vertex,
                _ scale: Grid.Triangle.Scale) {
        
        let dx = Double(vertex.position.y)
        let dy = Double(vertex.position.x)
        let dz = Double(vertex.position.z)
        
        self.init((0.5 * dx + -0.5 * dz) * scale.edgeLength,
                  0.0,
                  ((-.sqrt3d6 * dx) + (.sqrt3d3 * dy) - (.sqrt3d6 * dz)) * scale.edgeLength)
    }
}

// MARK: Hexagon

extension Vector {
    
    public init(_ vertex: Grid.Hexagon.Vertex,
                _ scale: Grid.Hexagon.Scale) {
        
        let dx = Double(vertex.position.y)
        let dy = Double(vertex.position.x)
        let dz = Double(vertex.position.z)
        
        self.init((dx - 0.5 * dy - 0.5 * dz) * scale.edgeLength,
                  0.0,
                  ((.sqrt3d2 * dy) - (.sqrt3d2 * dz)) * scale.edgeLength)
    }
}
