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
                           Sendable {
    
    associatedtype S = Scale
    associatedtype T = Tile
    
    var origin: T { get }
    var tiles: [T] { get }
    
    func intersects(_ rhs: Self) -> Bool
    func intersects(_ tile: T) -> Bool
    
    func center(_ scale: S) -> Vector
}

extension Footprint {
    
    public func intersects(_ footprint: Self) -> Bool {
        
        for tile in footprint.tiles {
            
            guard !intersects(tile) else { return true }
        }
        
        return intersects(footprint.origin)
    }
}
