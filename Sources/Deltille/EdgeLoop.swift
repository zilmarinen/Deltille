//
//  EdgeLoop.swift
//
//  Created by Zack Brown on 14/10/2025.
//

import Euclid

// MARK: EdgeLoop

public struct EdgeLoop<S: Scale,
                       T: Tile,
                       V: Vertex>: Hashable,
                                   Sendable where T.S == S,
                                                  T.V == V,
                                                  V.S == S {
    
    public enum Error: Swift.Error {
        
        case invalidEdgeLoop
        case invalidWinding
    }
    
    public let start: T
    public let end: T
    
    public let tiles: [T]
    
    public init(tiles: [T]) throws {
        
        let vertices = Array(Set(tiles.flatMap { $0.vertices }))
        let center = vertices.center(.default)
        
        var first: T? = nil
        
        let last = tiles.first { tile in
            
            let neighbours = tile.adjacent.filter { tiles.contains($0) }
            
            let lhs = tile.position(.default) - center
            
            for neighbour in neighbours {
                
                let rhs = neighbour.position(.default) - center
                let cross = lhs.cross(rhs).normalized()
                
                guard cross.y > 0 else { continue }
                
                first = neighbour
                
                return true
            }
            
            return false
        }
        
        guard let first,
              let last else { throw Error.invalidWinding }
        
        let tiles = Array(Set(tiles).subtracting([first, last]))
        
        var next = first
        
        let loop = try tiles.reduce(into: [T](), { result, _ in
            
            let neighbour = next.adjacent.first {
                
                !result.contains($0) &&
                tiles.contains($0)
            }
            
            guard let neighbour else { throw Error.invalidEdgeLoop }
            
            result.append(neighbour)
            
            next = neighbour
        })
        
        self.start = first
        self.end = last
        self.tiles = [first] + loop + [last]
    }
}

extension EdgeLoop {
    
    public func path(_ scale: S,
                     _ color: Color) -> Path {
        
        let loop = tiles.map { $0.position(scale) } + [start.position(scale)]
        
        let points = loop.map {
            
            PathPoint($0,
                      texcoord: nil,
                      color: color,
                      isCurved: false)
        }
        
        return .init(points)
    }
}
