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

// MARK: Hexagon

extension Vector {
    
    public init(_ vertex: Hexagon.Vertex,
                _ scale: Hexagon.Scale) {
        
        let dx = Double(vertex.position.x)
        let dy = Double(vertex.position.y)
        let dz = Double(vertex.position.z)
        
        self.init(((.sqrt3d2 * dy) - (.sqrt3d2 * dz)) * scale.length,
                  0.0,
                  (dx - 0.5 * dy - 0.5 * dz) * scale.length)
    }
}

// MARK: Triangle

extension Vector {
    
    public init(_ vertex: Triangle.Vertex,
                _ scale: Triangle.Scale) {
        
        let dx = Double(vertex.position.y)
        let dy = Double(vertex.position.x)
        let dz = Double(vertex.position.z)
        
        self.init((dx - 0.5 * dy - 0.5 * dz) * scale.length,
                  0.0,
                  ((.sqrt3d2 * dy) - (.sqrt3d2 * dz)) * scale.length)
    }
}

// MARK: Array

extension Array where Element == Vector {
    
    public func firstIndexOf(closest vector: Vector) -> Int {
        
        var distance = Double.greatestFiniteMagnitude
        var closestIndex = 0
        
        for index in indices {
            
            let other = self[index]
            
            let length = (other - vector).length
            
            if length < distance {
                
                closestIndex = index
                
                distance = length
            }
        }
        
        return closestIndex
    }
}
