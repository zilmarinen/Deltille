//
//  EdgeLoop.swift
//
//  Created by Zack Brown on 14/10/2025.
//

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
        
        var next: T? = nil
        
        let first = tiles.first { tile in
            
            let neighbours = tile.adjacent.filter { tiles.contains($0) }
            
            let lhs = tile.position(.default) - center
            
            for neighbour in neighbours {
                
                let rhs = neighbour.position(.default) - center
                let cross = lhs.cross(rhs).normalized()
                
                guard cross.y > 0 else { continue }
                
                next = neighbour
                
                return true
            }
            
            return false
        }
        
        guard let first,
              var next else { throw Error.invalidWinding }
        
        var loop = [first, next]
        
        let tiles = Array(Set(tiles).subtracting(loop))
        
        self.start = next
        self.end = first
        
        self.tiles = try tiles.reduce(into: loop, { result, _ in
            
            let neighbour = next.adjacent.first {
                
                !result.contains($0) &&
                tiles.contains($0)
            }
            
            guard let neighbour else { throw Error.invalidEdgeLoop }
            
            result.append(neighbour)
            
            next = neighbour
        })
    }
}
