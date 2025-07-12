//
//  Vertex.swift
//
//  Created by Zack Brown on 27/11/2024.
//

import Euclid

// MARK: Vertex

public protocol Vertex: Codable,
                        Hashable,
                        Identifiable,
                        Sendable {
    
    associatedtype S = Scale
    associatedtype T = Tile
    
    var position: Grid.Coordinate { get }
    
    var tiles: [T] { get }
    var vertices: [Self] { get }
    
    func position(_ scale: S) -> Vector
}

extension Vertex {
    
    public var id: String { position.id }
}
