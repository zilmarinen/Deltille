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

// MARK: Coordinate

public extension Vector {
    
    init(_ coordinate: any Coordinate,
         _ scale: Double = 1.0) {
        
        let dx = Double(coordinate.x)
        let dy = Double(coordinate.y)
        let dz = Double(coordinate.z)
        
        self.init((dx - 0.5 * dy - 0.5 * dz) * scale,
                  0.0,
                  ((.sqrt3d2 * dy) - (.sqrt3d2 * dz)) * scale)
    }
    
    func quantised(_ scale: Double = 1.0) -> (x: Int,
                                              y: Int,
                                              z: Int) {
        
        let i = ceil((x - .sqrt3d3 * z) / scale)
        let j = floor((.sqrt3d3 * 2.0 * z) / scale) + 1
        let k = ceil((-x - .sqrt3d3 * z) / scale)
        
        return (Int(round((i - k) / 3.0)),
                Int(round((j - i) / 3.0)),
                Int(round((k - j) / 3.0)))
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
