//
//  Sieve.swift
//
//  Created by Zack Brown on 01/07/2024.
//

import Foundation
import Euclid

extension Grid.Triangle {

    //
    //  A sieve subdivides a given triangle of a specific scale into
    //  a set of smaller, inner triangles and their corner vertices.
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

        public let coordinate: Grid.Coordinate
        public let scale: Scale
        public let triangles: [Grid.Triangle]
        public let vertices: [Grid.Coordinate]
        
        public init(_ coordinate: Grid.Coordinate,
                    _ scale: Scale,
                    _ triangles: [Grid.Triangle],
                    _ vertices: [Grid.Coordinate]) {
            
            self.coordinate = coordinate
            self.scale = scale
            self.triangles = triangles
            self.vertices = vertices
        }
    }

    public func sieve(for scale: Scale) -> Sieve {
        
        let origin = Grid.Coordinate(Vector(position,
                                            scale),
                                     Grid.Triangle.Scale.tile)
        let pointy = position.equalToZero
        
        let columns = Int(ceil(scale.edgeLength))
        let base = Int(floor(Double(columns) / 1.5))
        let half = Int(ceil(Double(base) / 2.0))
        
        var triangles: [Grid.Triangle] = []
        var vertices: [Grid.Coordinate] = []
        
        for column in 0...columns {
            
            let rows = columns - column
            
            let x = half - column
            
            for row in 0...rows {
                
                let y = half - row
                let z = base + 1 - column - row
                
                let vertex = Grid.Coordinate(pointy ? -x : x + 1,
                                             pointy ? -y : y + 1,
                                             pointy ? z : -z + 1)
                
                vertices.append(origin + vertex)
                
                guard row != rows else { continue }
                
                let t0 = Grid.Coordinate(pointy ? -x : x,
                                         pointy ? -y : y,
                                         pointy ? z - 1 : -z + 1)
                
                triangles.append(.init(origin + t0))
                
                guard row < (rows - 1) else { continue }
                
                let t1 = Grid.Coordinate(pointy ? -x : x,
                                         pointy ? -y : y,
                                         pointy ? z - 2 : -z + 2)
                
                triangles.append(.init(origin + t1))
            }
        }

        return Sieve(position,
                     scale,
                     triangles,
                     vertices)
    }
}
