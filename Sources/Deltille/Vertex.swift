//
//  Vertex.swift
//
//  Created by Zack Brown on 27/11/2024.
//

import Euclid
import Foundation

// MARK: Vertex

public protocol Vertex: Codable,
                        Hashable,
                        Identifiable,
                        Sendable {
    
    associatedtype T = Tile
    associatedtype C = Corner
    
    var position: Grid.Coordinate { get }
    
    var tiles: [T] { get }
    var vertices: [Self] { get }
}

extension Vertex {
    
    public var id: String { position.id }
}

// MARK: Triangle

extension Grid.Triangle {
    
    public struct Vertex: Deltille.Vertex {
        
        public static let zero = Self(.zero)
        
        public let position: Grid.Coordinate
        
        public var tiles: [Grid.Triangle] { [] }
        public var vertices: [Vertex] { [] }
        
        public init(_ position: Grid.Coordinate) {
            
            self.position = position
        }
        
        public init(_ x: Int,
                    _ y: Int,
                    _ z: Int) {
            
            self.position = .init(x, y, z)
        }
        
        public init(_ vector: Vector,
                    _ scale: Grid.Triangle.Scale) {
        
            let offset = .sqrt3d6 * scale.edgeLength
            let slope = .sqrt3d3 * vector.z
        
            let j = (2.0 * slope) + offset
            let i = (vector.x - slope) + offset
            let k = (-vector.x - slope) + offset
        
            self.init(Int(floor(j / scale.edgeLength)),
                      Int(floor(i / scale.edgeLength)),
                      Int(floor(k / scale.edgeLength)))
        }
    }
}

// MARK: Hexagon

extension Grid.Hexagon {
    
    public struct Vertex: Deltille.Vertex {
        
        public static let zero = Self(.zero)
        
        public let position: Grid.Coordinate
        
        public var tiles: [Grid.Triangle] { [] }
        public var vertices: [Vertex] { [] }
        
        public init(_ position: Grid.Coordinate) {
            
            self.position = position
        }
        
        public init(_ x: Int,
                    _ y: Int,
                    _ z: Int) {
            
            self.position = .init(x, y, z)
        }
        
        public init(_ vector: Vector,
                    _ scale: Grid.Hexagon.Scale) {
            
            let slope = .sqrt3d3 * vector.z
            
            let j = 2.0 * slope
            let i = vector.x - slope
            let k = -vector.x - slope
            
            let x = Int(floor(j / scale.edgeLength))
            let y = Int(floor(i / scale.edgeLength))
            let z = Int( ceil(k / scale.edgeLength) - 1.0)
            
            self.init(Int(round(Double(x - y) / 3.0)),
                      Int(round(Double(y - z) / 3.0)),
                      Int(round(Double(z - x) / 3.0)))
        }
    }
}
