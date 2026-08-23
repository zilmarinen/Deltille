//
//  Vector.swift
//  Deltille
//
//  Created by Zack Brown on 24/05/2024.
//

import Euclid
import Foundation

// MARK: Vector

extension Vector: @retroactive Identifiable {
    
    public var id: String {
        
        "[\(x), \(y), \(z)]"
    }
}

public extension Vector {
    
    func mid(_ lhs: Self) -> Self {
        
        lerp(lhs, 0.5)
    }
}

// MARK: Hexagon

public extension Vector {
    
    init(_ vertex: Hexagon.Vertex,
         _ scale: Double = 1.0) {
        
        let dx = Double(vertex.x)
        let dy = Double(vertex.y)
        let dz = Double(vertex.z)
        
        self.init((dx - 0.5 * dy - 0.5 * dz) * scale,
                  0.0,
                  ((.sqrt3d2 * dy) - (.sqrt3d2 * dz)) * scale)
    }
}

// MARK: Triangle

public extension Vector {
    
    init(_ vertex: Triangle.Vertex,
         _ scale: Double = 1.0) {
        
        let dx = Double(vertex.x)
        let dy = Double(vertex.y)
        let dz = Double(vertex.z)
        
        self.init(((.sqrt3d2 * dy) - (.sqrt3d2 * dz)) * scale,
                  0.0,
                  (dx - 0.5 * dy - 0.5 * dz) * scale)
    }
}

// MARK: Array

public extension Array where Element == Vector {
    
    func firstIndex(closest vector: Vector) -> Int {
        
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
