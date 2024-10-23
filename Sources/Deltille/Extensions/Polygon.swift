//
//  Polygon.swift
//
//  Created by Zack Brown on 17/06/2024.
//

import Euclid

public extension Polygon {
    
    static func face(_ vectors: [Vector],
                     _ normal: Vector,
                     _ color: Color) -> Self? {
        
        Self(vectors.map { Vertex($0,
                                  normal,
                                  nil,
                                  color) })
    }
    
    static func face(_ vectors: [Vector],
                     _ color: Color) -> Self? {
        
        guard vectors.count > 2 else { return nil }
        
        let normal = ((vectors[0] - vectors[1]).cross(vectors[0] - vectors[2])).normalized()
        
        return Self.face(vectors,
                         normal,
                         color)
    }
}
