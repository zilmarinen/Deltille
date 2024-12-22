//
//  Tile.swift
//
//  Created by Zack Brown on 27/11/2024.
//

// MARK: Tile

public protocol Tile: Codable,
                      Hashable,
                      Identifiable,
                      Sendable {
    
    associatedtype C = Corner
    associatedtype E = Edge
    associatedtype V = Vertex
    
    var vertex: V { get }
    
    var vertices: [V] { get }
    var corners: [C] { get }
    var edges: [E] { get }
    
    var adjacent: [Self] { get }
    var perimeter: [Self] { get }
    
    func vertex(_ corner: C) -> V
    func corner(_ vertex: V) -> C?
    
    func neighbour(_ edge: E) -> Self
    
    func translation(_ along: E) -> Grid.Coordinate
}
