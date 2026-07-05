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
    
    func unique(_ from: S,
                _ to: S) -> [T]
}

public extension Footprint {
    
    var perimeter: [T] {
        
        tiles.perimeter
    }
    
    var vertices: [V] {
        
        Array(Set(tiles.flatMap { $0.vertices }))
    }
}

public extension Footprint {
    
    func center(_ scale: S) -> Vector {
        
        vertices.center(scale)
    }
    
    func intersects(_ footprint: Self) -> Bool {
        
        for tile in footprint.tiles {
            
            guard !intersects(tile) else { return true }
        }
        
        return intersects(footprint.origin)
    }
    
    func intersects(_ tile: T) -> Bool {
        
        tiles.contains(tile) ||
        tile == origin
    }
    
    func unique(_ from: S,
                _ to: S) -> [T] {
        
        [origin] + tiles.unique(from,
                                to)
    }
}
