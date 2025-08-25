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
    
    public func mid(_ lhs: Self) -> Self {
        
        lerp(lhs, 0.5)
    }
}

// MARK: Coordinate

extension Vector {
    
    public init(_ coordinate: Grid.Coordinate,
                _ scale: any Scale) {
        
        let dx = Double(coordinate.y)
        let dy = Double(coordinate.x)
        let dz = Double(coordinate.z)
        
        self.init((dx - 0.5 * dy - 0.5 * dz) * scale.edgeLength,
                  0.0,
                  ((.sqrt3d2 * dy) - (.sqrt3d2 * dz)) * scale.edgeLength)
    }
}

// MARK: Hexagon

extension Vector {
    
    public init(_ vertex: Grid.Hexagon.Vertex,
                _ scale: Grid.Hexagon.Scale) {
        
        self.init(vertex.position,
                  scale)
    }
}

// MARK: Triangle

extension Vector {
    
    public init(_ vertex: Grid.Triangle.Vertex,
                _ scale: Grid.Triangle.Scale) {
        
        self.init(vertex.position,
                  scale)
    }
}
