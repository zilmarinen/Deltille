//
//  Sieve.swift
//  Deltille
//
//  Created by Zack Brown on 30/07/2026.
//

import Euclid

// MARK: Sieve

public protocol Sieve: Sendable {
    
    associatedtype T: Tile
    associatedtype V: Vertex
    
    var origin: T { get }
    
    var scale: Scale { get }
    
    var tiles: Set<T> { get }
    var vertices: Set<V> { get }
}
