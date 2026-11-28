//
//  Vertex.swift
//  Deltille
//
//  Created by Zack Brown on 27/11/2024.
//

import Euclid

// MARK: Vertex

public protocol Vertex: Coordinate {
    
    associatedtype T: Tile
    
    var tiles: [T] { get }
    var vertices: [Self] { get }
    
    func vector(_ lattice: Double) -> Vector
}
