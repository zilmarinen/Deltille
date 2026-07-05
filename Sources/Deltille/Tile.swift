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
                      Rotatable,
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
    
    init(_ coordinate: Coordinate)
    
    func position(_ scale: S) -> Vector
    
    func vertex(_ corner: C) -> V
    func corner(_ vertex: V) -> C?
    
    func neighbour(_ edge: E) -> Self
    
    func translation(_ along: E) -> Coordinate
    
    func contains(_ vector: Vector,
                  _ scale: S) -> Bool
    
    func closest(_ vector: Vector,
                 _ scale: S) -> V
    
    func distance(_ other: Self) -> Int
    
    func disc(_ radius: Int) -> [Self]
    
    func rotate(_ rotation: R) -> Self
    
    func transpose(_ from: S,
                   _ to: S) -> Self
}

public extension Array where Element: Tile,
                             Element.V: Vertex,
                             Element.V.S == Element.S {
    
    func bounds(_ scale: Element.S) -> Bounds {
        
        var min = Vector.zero
        var max = Vector.zero
        
        forEach {
            
            for vertex in $0.vertices {
                
                let position = vertex.position(scale)
                
                min.x = min.x < position.x ? min.x : position.x
                min.z = min.z < position.z ? min.z : position.z
                max.x = max.x > position.x ? max.x : position.x
                max.z = max.z > position.z ? max.z : position.z
            }
        }
        
        return .init(min: min,
                     max: max)
    }
    
    var perimeter: [Element] {
        
        let unique = Set(flatMap { $0.perimeter })
        
        let edges = Array(unique.subtracting(self))
        
        return edges.filter { tile in
            
            let intersecting = tile.adjacent.filter {
                
                contains($0)
            }
            
            return intersecting.count <= 1
        }
    }
    
    func transpose(_ from: Element.S,
                   _ to: Element.S) -> Self {
        map {
            
            $0.transpose(from,
                         to)
        }
    }
    
    func unique(_ from: Element.S,
                _ to: Element.S) -> Self {
        
        Array(Set(transpose(from,
                            to)))
    }
}
