//
//  Vector.swift
//
//  Created by Zack Brown on 24/05/2024.
//

import Euclid
import Foundation

extension Vector: Identifiable {
    
    public var id: String { "[\(x), \(y), \(z)]" }
    
    init(_ coordinate: Coordinate) {
        
        self.init(Double(coordinate.x),
                  Double(coordinate.y),
                  Double(coordinate.z))
    }
}

extension Vector {
    
    public static let forward = Vector(0.0, 0.0, 1.0)
    public static let up = Vector(0.0, 1.0, 0.0)
    public static let right = Vector(1.0, 0.0, 0.0)
}

extension Vector {
    
    public func convert(to scale: Grid.Scale) -> Coordinate {
        
        let offset = Double.sqrt3d6 * scale.edgeLength
        let slope = (.sqrt3d3 * z)
        
        let j = (2.0 * slope) + offset
        let i = (x - slope) + offset
        let k = (-x - slope) + offset
        
        return Coordinate(Int(floor(j / scale.edgeLength)),
                          Int(floor(i / scale.edgeLength)),
                          Int(ceil(k / scale.edgeLength) - 1.0))
    }
    
    public func mid(_ other: Vector) -> Vector { lerp(other, 0.5) }
}
