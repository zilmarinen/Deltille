//
//  Sieve.swift
//
//  Created by Zack Brown on 01/07/2024.
//

import Euclid
import Foundation

// MARK: Sieve

extension Grid.Triangle {

    //
    //  A sieve subdivides a triangle of a given scale into
    //  a set of smaller, inner triangles and their vertices.
    //
    //      v-------v-------v-------v-------v
    //        \ t / t \ t / t \ t / t \ t /
    //          v-------v-------v-------v
    //            \ t / t \ t / t \ t /
    //              v-------v-------v
    //                \ t / t \ t /
    //                  v-------v
    //                    \ t /
    //                      v
    //

    public struct Sieve {

        public let origin: Grid.Triangle
        public let scale: Grid.Triangle.Scale
        public let triangles: [Grid.Triangle]
        public let vertices: [Grid.Triangle.Vertex]
        
        public init(_ origin: Grid.Triangle,
                    _ scale: Grid.Triangle.Scale,
                    _ triangles: [Grid.Triangle],
                    _ vertices: [Grid.Triangle.Vertex]) {
            
            self.origin = origin
            self.scale = scale
            self.triangles = triangles
            self.vertices = vertices
        }
    }

    public func sieve(for scale: Grid.Triangle.Scale) -> Sieve {
        
        let columns = Int(ceil(scale.edgeLength))
        let base = Int(floor(Double(columns) / 1.5))
        let half = Int(ceil(Double(base) / 2.0))
        let pointy = isPointy
        
        var triangles: [Grid.Triangle] = []
        var vertices: [Grid.Triangle.Vertex] = []
        
        for column in 0...columns {
            
            let rows = columns - column
            
            let x = half - column
            
            for row in 0...rows {
                
                let y = half - row
                let z = base + 1 - column - row
                
                let vertex = Grid.Triangle.Vertex(pointy ? -x : x + 1,
                                                  pointy ? -y : y + 1,
                                                  pointy ? z : -z + 1)
                
                vertices.append(.init(vertex.position + vertex.position))
                
                guard row != rows else { continue }
                
                let lhs = Grid.Coordinate(pointy ? -x : x,
                                          pointy ? -y : y,
                                          pointy ? z - 1 : -z + 1)
                
                triangles.append(.init(vertex.position + lhs))
                
                guard row < (rows - 1) else { continue }
                
                let rhs = Grid.Coordinate(pointy ? -x : x,
                                          pointy ? -y : y,
                                          pointy ? z - 2 : -z + 2)
                
                triangles.append(.init(vertex.position + rhs))
            }
        }

        return Sieve(.init(vertex.position),
                     scale,
                     triangles,
                     vertices)
    }
}
