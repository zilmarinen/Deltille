//
//  Triangle.swift
//
//  Created by Zack Brown on 23/05/2024.
//

import Euclid
import Foundation

// MARK: Triangle

extension Grid {
    
    public struct Triangle: Tile {
        
        public static let zero = Self(.zero)
        
        public let vertex: Vertex
        
        public init(_ position: Coordinate) {
                    
            self.vertex = Vertex(position)
        }
        
        public init(_ x: Int,
                    _ y: Int,
                    _ z: Int) {
            
            self.vertex = Vertex(x, y, z)
        }
    }
}

extension Grid.Triangle {
    
    public var id: String { vertex.id }
    
    public var isPointy: Bool { vertex.position.equalToZero }
    public var rotation: Double { isPointy ? 0.0 : Rotation.inverse }
    
    public var vertices: [Vertex] { edges.map { .init(vertex.position + (isPointy ? -translation($0) : .one - translation($0))) } }
    
    public var corners: [Corner] { Corner.allCases }
    public var edges: [Edge] { Edge.allCases }
    
    public var adjacent: [Self] { edges.map { .init(vertex.position + translation($0)) } }
    public var perimeter: [Self] {
    
        Array(vertices.reduce(into: Set<Self>(), { result, vertex in
            
            for tile in vertex.tiles {
                
                guard tile.vertex != self.vertex else { continue }
                
                result.insert(tile)
            }
        }))
    }
    
    public func vertex(_ corner: Corner) -> Vertex { vertices[corner.rawValue] }
    
    public func corner(_ vertex: Vertex) -> Corner? {
        
        guard let index = vertices.firstIndex(of: vertex) else { return nil }
        
        return Corner(rawValue: index)
    }
    
    public func neighbour(_ edge: Edge) -> Self { adjacent[edge.rawValue] }
    
    public func translation(_ along: Edge) -> Grid.Coordinate {
        
        switch along {
            
        case .e0: return isPointy ? -.unitX : .unitX
        case .e1: return isPointy ? -.unitY : .unitY
        case .e2: return isPointy ? -.unitZ : .unitZ
        }
    }
}

// MARK: Corner

extension Grid.Triangle {
    
    public enum Corner: Int,
                        Deltille.Corner {
        
        case c0, c1, c2
        
        public var id: String { "\(rawValue)" }
        
        public var corners: [Corner] {
                    
            switch self {
                
            case .c0: return [.c1, .c2]
            case .c1: return [.c2, .c0]
            case .c2: return [.c0, .c1]
            }
        }
        
        public var edges: [Edge] {
            
            switch self {
                
            case .c0: return [.e0, .e2]
            case .c1: return [.e1, .e0]
            case .c2: return [.e2, .e1]
            }
        }
    }
}

// MARK: Edge

extension Grid.Triangle {
    
    public enum Edge: Int,
                      Deltille.Edge {
        
        case e0, e1, e2
        
        public var id: String { "\(rawValue)" }
        
        public var corners: [Corner] {
            
            switch self {
                
            case .e0: return [.c1, .c0]
            case .e1: return [.c2, .c1]
            case .e2: return [.c0, .c2]
            }
        }
        
        public var edges: [Edge] {
           
            switch self {
               
            case .e0: return [.e1, .e2]
            case .e1: return [.e2, .e0]
            case .e2: return [.e0, .e1]
            }
        }
    }
}

// MARK: Footprint

extension Grid.Triangle {
    
    public struct Footprint: Deltille.Footprint {
        
        public let origin: Grid.Triangle
        public let tiles: [Grid.Triangle]
        
        public init(_ origin: Grid.Triangle,
                    _ tiles: [Grid.Triangle]) {
         
            self.origin = origin
            self.tiles = tiles
        }
        
        public init(_ origin: Grid.Triangle,
                    _ coordinates: [Grid.Coordinate]) {
            
            self.origin = origin
            self.tiles = coordinates.map { .init(origin.vertex.position + (origin.isPointy ? $0 : -$0)) }
        }
        
        public func intersects(_ tile: Grid.Triangle) -> Bool { tiles.contains(tile) || tile == origin }
        
        public func center(_ scale: Scale) -> Vector {
                
            let vector = tiles.reduce(into: Vector.zero) { result, tile in
                
                result += Vector(tile.vertex,
                                 scale)
            }
            
            return vector / Double(tiles.count)
        }
        
        public func rotate(_ rotation: Rotation) -> Self {
        
            let triangles = tiles.map {
                
                let triangle = Grid.Triangle($0.vertex.position - origin.vertex.position)
                
                let rotated = triangle.rotate(rotation)
                
                return Grid.Triangle(rotated.vertex.position + origin.vertex.position)
            }
            
            return Self(origin,
                        triangles)
        }
    }
}

// MARK: Rotation

extension Grid.Triangle: Rotatable {
    
    public enum Rotation: String,
                          Deltille.Rotation {
        
        public static var inverse: Double = .pi
        public static var step: Double = .tau / 3.0
        
        case clockwise
        case counterClockwise
        
        public var id: String { rawValue }
    }
    
    public func rotate(_ rotation: Rotation) -> Self {
    
        switch rotation {
            
        case .clockwise: return .init(vertex.position.y,
                                      vertex.position.z,
                                      vertex.position.x)
            
        case .counterClockwise: return .init(vertex.position.z,
                                             vertex.position.x,
                                             vertex.position.y)
        }
    }
}

// MARK: Scale

extension Grid.Triangle {
    
    public enum Scale: String,
                       Deltille.Scale {
        
        case sierpinski
        case tile
        case chunk
        case region
        
        public var id: String { rawValue.capitalized }
        
        public var edgeLength: Double {
            
            switch self {
                
            case .sierpinski: return 0.1428571429   // 1.0 / 7.0
            case .tile: return 1.0
            case .chunk: return 7.0
            case .region: return 28.0
            }
        }
    }
    
    public func transpose(_ from: Grid.Triangle.Scale,
                          _ to: Grid.Triangle.Scale) -> Self {
        
        guard from != to else { return self }
        
        let origin = Vector(vertex, from)
        let destination = Vertex(origin, to)
        
        return Self(destination.position)
    }
}

// MARK: Vertex

extension Grid.Triangle {
    
    public struct Vertex: Deltille.Vertex {
        
        public static let zero = Self(.zero)
        
        public let position: Grid.Coordinate
        
        public var tiles: [Grid.Triangle] { [.init(position - .unitX),
                                             .init(position - (.unitX + .unitY)),
                                             .init(position - .unitY),
                                             .init(position - (.unitY + .unitZ)),
                                             .init(position - .unitZ),
                                             .init(position - (.unitX + .unitZ))] }
        
        public var vertices: [Vertex] { [.init(position + (-.unitX + .unitY)),
                                         .init(position + (-.unitX + .unitZ)),
                                         .init(position + (-.unitY + .unitZ)),
                                         .init(position + (-.unitY + .unitX)),
                                         .init(position + (-.unitZ + .unitX)),
                                         .init(position + (-.unitZ + .unitY))] }
        
        public init(_ position: Grid.Coordinate) {
            
            self.position = position
        }
        
        public init(_ x: Int,
                    _ y: Int,
                    _ z: Int) {
            
            self.position = .init(x, y, z)
        }
        
        public init(_ vector: Vector,
                    _ scale: Scale) {
        
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
