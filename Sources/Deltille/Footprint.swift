//
//  Footprint.swift
//  Deltille
//
//  Created by Zack Brown on 24/05/2024.
//

import Euclid

// MARK: Footprint

public protocol Footprint: Codable,
                           Hashable,
                           Rotatable,
                           Sendable where T.V == V {
    
    associatedtype T: Tile
    associatedtype V: Vertex
    
    var origin: T { get }
    var tiles: [T] { get }
    
    var footprint: [T] { get }
    
    func perimeter(_ size: Int) -> [T]
    
    func vertices(_ scale: Scale) -> [V]
    
    func intersects(_ footprint: Self) -> Bool
    func intersects(_ tile: T) -> Bool
    
    func unique(_ from: Scale,
                _ to: Scale) -> [T]
}

public extension Footprint {
    
    var footprint: [T] {
        
        [origin] + tiles
    }
}

public extension Footprint {
    
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
    
    func perimeter(_ size: Int) -> [T] {
        
        let surface = Set(footprint.flatMap {
            
            $0.disc(size)
            
        })
        
        return Array(surface.subtracting(footprint))
    }
    
    func unique(_ from: Scale,
                _ to: Scale) -> [T] {
        
        [origin] + tiles.unique(from,
                                to)
    }
    
    func vertices(_ scale: Scale) -> [V] {
        
        Array(Set(footprint.flatMap {
            
            $0.vertices(scale)
        }))
    }
}

