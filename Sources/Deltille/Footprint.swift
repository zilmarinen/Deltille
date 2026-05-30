//
//  Footprint.swift
//
//  Created by Zack Brown on 24/05/2024.
//

import Euclid

// MARK: Footprint

public protocol Footprint: Codable,
                           Hashable,
                           Rotatable,
                           Sendable where T.V == V,
                                          V.S == S,
                                          T.S == V.S {
    
    associatedtype S: Scale
    associatedtype T: Tile
    associatedtype V: Vertex
    
    var origin: T { get }
    var tiles: [T] { get }
    
    var perimeter: [T] { get }
    var vertices: [V] { get }
    
    func center(_ scale: S) -> Vector
    func intersects(_ footprint: Self) -> Bool
    func intersects(_ tile: T) -> Bool
}

extension Footprint {
    
    public var perimeter: [T] {
        
        tiles.perimeter
    }
    
    public var vertices: [V] {
        
        Array(Set(tiles.flatMap { $0.vertices }))
    }
}

extension Footprint {
    
    public func center(_ scale: S) -> Vector {
        
        vertices.center(scale)
    }
    
    public func intersects(_ footprint: Self) -> Bool {
        
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
