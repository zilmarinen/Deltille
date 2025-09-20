//
//  Tile.swift
//
//  Created by Zack Brown on 27/11/2024.
//

import Euclid

// MARK: Tile

public protocol Tile: Codable,
                      Hashable,
                      Identifiable,
                      Sendable {
    
    associatedtype C = Corner
    associatedtype E = Edge
    associatedtype R = Rotation
    associatedtype S = Scale
    associatedtype V = Vertex
    
    var vertex: V { get }
    
    var vertices: [V] { get }
    var corners: [C] { get }
    var edges: [E] { get }
    
    var adjacent: [Self] { get }
    var perimeter: [Self] { get }
    
    func position(_ scale: S) -> Vector
    
    func rotate(_ rotation: R) -> Self
    
    func vertex(_ corner: C) -> V
    func corner(_ vertex: V) -> C?
    
    func neighbour(_ edge: E) -> Self
    
    func translation(_ along: E) -> Coordinate
    
    func transpose(_ from: S,
                   _ to: S) -> Self
    
    func contains(_ vector: Vector,
                  _ scale: S) -> Bool
    
    func closest(_ vector: Vector,
                 _ scale: S) -> V
    
    func distance(_ other: Self) -> Int
    
    func disc(_ radius: Int) -> [Self]
    
    func mesh(_ scale: S,
              _ color: Color?) -> Mesh
}
