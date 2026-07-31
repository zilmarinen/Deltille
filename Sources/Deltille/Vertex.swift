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
}

// MARK: Array

public extension Array where Element: Vertex {
    
    var center: Vector {
        
        let vector = reduce(into: Vector.zero) { result, vertex in
            
            result += vertex.vector
        }
        
        return vector / Double(count)
    }
}

