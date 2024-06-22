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
        
        let normal = Vector.normal(v0: vectors[0],
                                   v1: vectors[1],
                                   v2: vectors[2])
        
        return Self.face(vectors,
                         normal,
                         color)
    }
}
