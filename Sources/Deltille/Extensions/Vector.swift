//
//  Vector.swift
//
//  Created by Zack Brown on 24/05/2024.
//

import Euclid
import Foundation

extension Vector: Identifiable {
    
    public var id: String { "[\(x), \(y), \(z)]" }
    
    public init(_ coordinate: Grid.Triangle.Coordinate) {
        
        self.init(Double(coordinate.x),
                  Double(coordinate.y),
                  Double(coordinate.z))
    }
    
    public init(_ coordinate: Grid.Hexagon.Coordinate) {
        
        self.init(Double(coordinate.x),
                  Double(coordinate.y),
                  Double(coordinate.z))
    }
}

public extension Vector {
    
    static let forward = Vector(0.0, 0.0, 1.0)
    static let up = Vector(0.0, 1.0, 0.0)
    static let right = Vector(1.0, 0.0, 0.0)
    
    func mid(_ other: Vector) -> Vector { lerp(other, 0.5) }
}

public extension Vector {
    
    func convert(to scale: Grid.Scale) -> Grid.Triangle.Coordinate {
        
        let offset = Double.sqrt3d6 * scale.edgeLength
        let slope = (.sqrt3d3 * z)
        
        let j = (2.0 * slope) + offset
        let i = (x - slope) + offset
        let k = (-x - slope) + offset
        
        return .init(Int(floor(j / scale.edgeLength)),
                     Int(floor(i / scale.edgeLength)),
                     Int(ceil(k / scale.edgeLength) - 1.0))
    }
}
