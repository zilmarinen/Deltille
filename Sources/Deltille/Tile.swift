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
    
    associatedtype V = Vertex
    associatedtype C = Corner
    associatedtype E = Edge
    associatedtype S = Scale
    
    var vertex: V { get }
    
    var vertices: [V] { get }
    var corners: [C] { get }
    var edges: [E] { get }
    
    var adjacent: [Self] { get }
    var perimeter: [Self] { get }
    var winding: [Grid.Coordinate] { get }
    
    func vertex(_ corner: C) -> V
    func corner(_ vertex: V) -> C?
    
    func neighbour(_ edge: E) -> Self
    
    func translation(_ along: E) -> Grid.Coordinate
}
