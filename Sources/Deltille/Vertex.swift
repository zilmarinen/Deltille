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
    
    var position: Coordinate { get }
    
    var tiles: [T] { get }
    var vertices: [Self] { get }
    
    func position(_ scale: S) -> Vector
    
    func distance(_ other: Self) -> Int
}

extension Vertex {
    
    public var id: String { position.id }
}

// MARK: Array

extension Array where Element: Vertex {
    
    public var perimeter: [Element] {
    
        filter {
            
            for vertex in $0.vertices {
                
                if !contains(vertex) {
                    
                    return false
                }
            }
            
            return true
        }
    }
    
    public var interior: [Element] {
        
        Array(Set(self).subtracting(perimeter))
    }
    
    public func center(_ scale: Element.S) -> Vector {
        
        let vector = reduce(into: Vector.zero) { result, vertex in
            
            result += vertex.position(scale)
        }
        
        return vector / Double(count)
    }
    
    public func closest(_ vector: Vector,
                        _ scale: Element.S) -> Element {
        
        let vectors = position(scale)
        
        let index = vectors.firstIndexOf(closest: vector)
        
        return self[index]
    }
    
    public func mesh(_ scale: Element.S,
                     _ color: Color? = nil) -> Mesh {
        
        let path = path(scale,
                        color)
        
        guard let polygon = Polygon(shape: path) else { fatalError("Degenerate vertices") }
        
        return .init([polygon])
    }
    
    public func path(_ scale: Element.S,
                     _ color: Color?) -> Path {
        
        let points = map { $0.position(scale) }
        
        return points.path(color)
    }
    
    public func position(_ scale: Element.S) -> [Vector] {
        
        map { $0.position(scale) }
    }
}
