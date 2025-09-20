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
    
    public func closest(_ vector: Vector,
                        _ scale: Element.S) -> Element {
        
        let vectors = position(scale)
        
        let index = vectors.firstIndexOf(closest: vector)
        
        return self[index]
    }
    
    public func position(_ scale: Element.S) -> [Vector] {
        
        map { $0.position(scale) }
    }
    
    internal func mesh(_ scale: Element.S,
                       _ color: Color? = nil) -> Mesh {
        
        let vertices = map {
            
            Euclid.Vertex($0.position(scale),
                          .unitY,
                          nil,
                          color)
        }
        
        guard let polygon = Polygon(vertices) else { fatalError("Degenerate vertices") }
        
        return .init([polygon])
    }
}
