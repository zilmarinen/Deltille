//
//  Vertex.swift
//
//  Created by Zack Brown on 27/11/2024.
//

// MARK: Vertex

public protocol Vertex: Codable,
                        Hashable,
                        Identifiable,
                        Sendable {
    
    associatedtype T = Tile
    
    var position: Grid.Coordinate { get }
    
    var tiles: [T] { get }
    var vertices: [Self] { get }
}

extension Vertex {
    
    public var id: String { position.id }
}
