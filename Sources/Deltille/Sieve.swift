//
//  Sieve.swift
//
//  Created by Zack Brown on 01/07/2024.
//

import Euclid
import Foundation

// MARK: Sieve

public class Sieve<S: Scale,
                   T: Tile,
                   V: Vertex> {
    
    public let origin: T
    public let scale: S
    public let tiles: [T]
    public let vertices: [V]
    
    public init(_ origin: T,
                _ scale: S,
                _ tiles: [T],
                _ vertices: [V]) {
        
        self.origin = origin
        self.scale = scale
        self.tiles = tiles
        self.vertices = vertices
    }
}

// MARK: Triangle

extension Triangle {
    
    //
    //  v-------v-------v-------v-------v
    //    \ t / t \ t / t \ t / t \ t /
    //      v-------v-------v-------v
    //        \ t / t \ t / t \ t /
    //          v-------v-------v
    //            \ t / t \ t /
    //              v-------v
    //                \ t /
    //                  v
    //

    public func sieve(for scale: Scale) -> Sieve<Scale,
                                                 Triangle,
                                                 Triangle.Vertex> {
        
        let origin = Triangle(vertex.position(scale),
                              .tile)
        
        let columns = Int(max(scale.edgeLength, 1.0))
        let base = Int(floor(Double(columns) / 1.5))
        let half = Int(floor(Double(base) / 2.0))
        let pointy = isPointy
        
        var triangles: [Triangle] = []
        var vertices: [Vertex] = []
        
        for column in 0...columns {
            
            let rows = columns - column
            
            let x = half - column
            
            for row in 0...rows {
                
                let y = half - row
                let z = base + 1 - column - row
                
                let other = Triangle.Vertex(pointy ? -x : x + 1,
                                            pointy ? -y : y + 1,
                                            pointy ? z : -z + 1)
                
                vertices.append(.init(origin.vertex.position + other.position))
                
                guard row != rows else { continue }
                
                let lhs = Coordinate(pointy ? -x : x,
                                     pointy ? -y : y,
                                     pointy ? z - 1 : -z + 1)
                
                triangles.append(.init(origin.vertex.position + lhs))
                
                guard row < (rows - 1) else { continue }
                
                let rhs = Coordinate(pointy ? -x : x,
                                     pointy ? -y : y,
                                     pointy ? z - 2 : -z + 2)
                
                triangles.append(.init(origin.vertex.position + rhs))
            }
        }

        return .init(.init(vertex.position),
                     scale,
                     triangles,
                     vertices)
    }
}
