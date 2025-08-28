//
//  Footprint.swift
//
//  Created by Zack Brown on 24/05/2024.
//

import Euclid

// MARK: Footprint

open class Footprint<S: Scale,
                     T: Tile,
                     R: Rotation,
                     V: Vertex>: Codable,
                                 Hashable,
                                 Rotatable where T.R == R,
                                                 T.S == S,
                                                 T.V == V {
    
    public let origin: T
    public let tiles: [T]
    
    public required init(_ origin: T,
                         _ tiles: [T]) {
     
        self.origin = origin
        self.tiles = tiles
    }
    
    open func rotate(_ rotation: R) -> Self { self }
}

extension Footprint {
    
    public var perimeter: [T] {
        
        Array(Set(tiles.flatMap { $0.perimeter }))
    }
    
    public var vertices: [V] {
        
        Array(Set(tiles.flatMap { $0.vertices }))
    }
}

extension Footprint {
    
    public func hash(into hasher: inout Hasher) {
        
        hasher.combine(origin)
        hasher.combine(tiles)
    }
    
    public static func == (lhs: Footprint<S, T, R, V>,
                           rhs: Footprint<S, T, R, V>) -> Bool {
        
        lhs.origin == rhs.origin &&
        lhs.tiles == rhs.tiles
    }
    
    public func center(_ scale: S) -> Vector {
        
        let vector = tiles.reduce(into: Vector.zero) { result, tile in
            
            result += tile.position(scale)
        }
        
        return vector / Double(tiles.count)
    }
    
    public func intersects(_ footprint: Footprint) -> Bool {
        
        for tile in footprint.tiles {
            
            guard !intersects(tile) else { return true }
        }
        
        return intersects(footprint.origin)
    }
    
    public func intersects(_ tile: T) -> Bool {
        
        tiles.contains(tile) ||
        tile == origin
    }
}
