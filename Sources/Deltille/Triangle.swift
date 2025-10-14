//
//  Triangle.swift
//
//  Created by Zack Brown on 23/05/2024.
//

import Euclid
import Foundation

// MARK: Triangle

public struct Triangle: Tile {
    
    public static let zero = Self(Vertex.zero)
    
    public let vertex: Vertex
    
    public init(_ position: Coordinate) {
                
        self.vertex = Vertex(position)
    }
    
    public init(_ vertex: Vertex) {
        
        self.vertex = vertex
    }
    
    public init(_ x: Int,
                _ y: Int,
                _ z: Int) {
        
        self.vertex = .init(x, y, z)
    }
    
    public init(_ vector: Vector,
                _ scale: Scale) {
    
        let j = ceil((vector.x - .sqrt3d3  * vector.z) / scale.edgeLength)
        let i = floor((     .sqrt3d3 * 2.0 * vector.z) / scale.edgeLength) + 1
        let k = ceil((-vector.x - .sqrt3d3 * vector.z) / scale.edgeLength)
        
        let triangle = Triangle(Int(round((i - j) / 3.0)),
                                Int(round((j - k) / 3.0)),
                                Int(round((k - i) / 3.0)))
        
        let triangles = [triangle] + triangle.adjacent
        
        let closest = triangles.first {
            
            $0.contains(vector,
                        scale)
        } ?? triangle
        
        self.init(closest.vertex)
    }
}

extension Triangle {
    
    public var id: String { vertex.id }
    
    public var isPointy: Bool {
        
        vertex.position.equalToZero
    }
    
    public var rotation: Double {
        
        isPointy ? 0.0 : Rotation.inverse
    }
    
    public var vertices: [Vertex] {
        
        edges.map {
            
            .init(vertex.position + (isPointy ? -translation($0) : .one - translation($0)))
        }
    }
    
    public var corners: [Corner] {
        
        Corner.allCases
    }
    
    public var edges: [Edge] {
        
        Edge.allCases
    }
    
    public var adjacent: [Self] {
        
        edges.map {
            
            .init(vertex.position + translation($0))
        }
    }
    
    public var perimeter: [Self] {
        
        Array(vertices.reduce(into: Set<Self>(), { result, vertex in
            
            for tile in vertex.tiles {
                
                guard tile.vertex != self.vertex else { continue }
                
                result.insert(tile)
            }
        }))
    }
}

extension Triangle {
    
    public func position(_ scale: Scale) -> Vector {
        
        vertex.position(scale)
    }
    
    public func vertex(_ corner: Corner) -> Vertex {
        
        vertices[corner.rawValue]
    }
    
    public func corner(_ vertex: Vertex) -> Corner? {
        
        guard let index = vertices.firstIndex(of: vertex) else { return nil }
        
        return Corner(rawValue: index)
    }
    
    public func neighbour(_ edge: Edge) -> Self {
        
        adjacent[edge.rawValue]
    }
    
    public func translation(_ along: Edge) -> Coordinate {
        
        switch along {
            
        case .e0: isPointy ? -.unitX : .unitX
        case .e1: isPointy ? -.unitY : .unitY
        case .e2: isPointy ? -.unitZ : .unitZ
        }
    }
    
    public func contains(_ vector: Vector,
                         _ scale: Scale) -> Bool {
        
        let c0 = vertex(.c0).position(scale)
        let c1 = vertex(.c1).position(scale)
        let c2 = vertex(.c2).position(scale)
        
        let v0 = c2 - c0
        let v1 = c1 - c0
        let v2 = vector - c0
        
        let v0v0 = v0.dot(v0)
        let v0v1 = v0.dot(v1)
        let v0v2 = v0.dot(v2)
        let v1v1 = v1.dot(v1)
        let v1v2 = v1.dot(v2)
        
        let denominator = (v0v0 * v1v1 - v0v1 * v0v1)
        if abs(denominator) < 1e-8 { return false }
        
        let inverse = 1.0 / denominator
        let u = (v1v1 * v0v2 - v0v1 * v1v2) * inverse
        let v = (v0v0 * v1v2 - v0v1 * v0v2) * inverse
        
        return (u >= 0.0) && (v >= 0.0) && (u + v <= 1.0)
    }
    
    public func closest(_ vector: Vector,
                        _ scale: Scale) -> Vertex {
        
        vertices.closest(vector,
                         scale)
    }
    
    public func distance(_ other: Self) -> Int {
        
        vertex.distance(other.vertex)
    }
    
    public func disc(_ radius: Int) -> [Triangle] {
        
        var tiles: [Triangle] = []
        
        for i in -radius...radius {
            
            for j in -radius...radius {
             
                let s = -1 - (vertex.position.sum + i + j)
                
                for k in s...(s + 1) {
                    
                    if abs(i) + abs(j) + abs(k) <= radius {
                        
                        tiles.append(.init(vertex.position + .init(i, j, k)))
                    }
                }
            }
        }
        
        return tiles
    }
    
    public func mesh(_ scale: Scale,
                     _ color: Color? = nil) -> Mesh {
        
        vertices.mesh(scale,
                      color)
    }
}

// MARK: Corner

extension Triangle {
    
    public enum Corner: Int,
                        Deltille.Corner {
        
        case c0, c1, c2
        
        public var id: String { "\(rawValue)" }
        
        public var corners: [Corner] {
                    
            switch self {
                
            case .c0: [.c1, .c2]
            case .c1: [.c2, .c0]
            case .c2: [.c0, .c1]
            }
        }
        
        public var edges: [Edge] {
            
            switch self {
                
            case .c0: [.e0, .e2]
            case .c1: [.e1, .e0]
            case .c2: [.e2, .e1]
            }
        }
    }
}

// MARK: Edge

extension Triangle {
    
    public enum Edge: Int,
                      Deltille.Edge {
        
        case e0, e1, e2
        
        public var id: String { "\(rawValue)" }
        
        public var corners: [Corner] {
            
            switch self {
                
            case .e0: [.c1, .c0]
            case .e1: [.c2, .c1]
            case .e2: [.c0, .c2]
            }
        }
        
        public var edges: [Edge] {
           
            switch self {
               
            case .e0: [.e1, .e2]
            case .e1: [.e2, .e0]
            case .e2: [.e0, .e1]
            }
        }
    }
}

// MARK: EdgeLoop

extension Triangle {
    
    public typealias EdgeLoop = Deltille.EdgeLoop<Self.Scale,
                                                  Self,
                                                  Self.Vertex>
}

// MARK: Footprint

extension Triangle {
    
    public final class Footprint: Deltille.Footprint<Scale,
                                                     Triangle,
                                                     Rotation,
                                                     Vertex> {
        
        public convenience init(_ origin: Triangle,
                                _ coordinates: [Coordinate]) {
            
            self.init(origin,
                      coordinates.map {
                
                .init(origin.vertex.position + (origin.isPointy ? $0 : -$0))
            })
        }
        
        public override func rotate(_ rotation: Rotation) -> Self {
            
            let triangles = tiles.map {
                
                let triangle = Triangle($0.vertex.position - origin.vertex.position)
                
                let rotated = triangle.rotate(rotation)
                
                return Triangle(rotated.vertex.position + origin.vertex.position)
            }
            
            return .init(origin,
                         triangles)
        }
    }
}

// MARK: Rotation

extension Triangle: Rotatable {
    
    public enum Rotation: String,
                          Deltille.Rotation {
        
        public static let inverse: Double = .pi
        public static let step: Double = .tau / 3.0
        
        case clockwise
        case counterClockwise
        
        public var id: String { rawValue }
    }
    
    public func rotate(_ rotation: Rotation) -> Self {
    
        switch rotation {
            
        case .clockwise:
            
            .init(vertex.position.y,
                  vertex.position.z,
                  vertex.position.x)
            
        case .counterClockwise:
            
            .init(vertex.position.z,
                  vertex.position.x,
                  vertex.position.y)
        }
    }
}

// MARK: Scale

extension Triangle {
    
    public enum Scale: String,
                       Deltille.Scale {
        
        public static let `default` = Self.tile
        
        case sierpinski
        case tile
        case chunk
        case region
        
        public var id: String { rawValue.capitalized }
        
        public var edgeLength: Double {
            
            switch self {
                
            case .sierpinski: 0.1428571429   // 1.0 / 7.0
            case .tile: 1.0
            case .chunk: 7.0
            case .region: 28.0
            }
        }
    }
    
    public func transpose(_ from: Scale,
                          _ to: Scale) -> Self {
        
        guard from != to else { return self }
        
        return .init(vertex.position(from),
                     to)
    }
}

// MARK: Vertex

extension Triangle {
    
    public struct Vertex: Deltille.Vertex {
        
        public static let zero = Self(.zero)
        
        public var tiles: [Triangle] {
            
            [.init(position - .unitX),
             .init(position - (.unitX + .unitY)),
             .init(position - .unitY),
             .init(position - (.unitY + .unitZ)),
             .init(position - .unitZ),
             .init(position - (.unitX + .unitZ))]
        }
        
        public var vertices: [Vertex] {
            
            [.init(position + (-.unitX + .unitY)),
             .init(position + (-.unitX + .unitZ)),
             .init(position + (-.unitY + .unitZ)),
             .init(position + (-.unitY + .unitX)),
             .init(position + (-.unitZ + .unitX)),
             .init(position + (-.unitZ + .unitY))]
        }
        
        public let position: Coordinate
        
        public init(_ position: Coordinate) {
            
            self.position = position
        }
        
        public init(_ x: Int,
                    _ y: Int,
                    _ z: Int) {
            
            self.position = .init(x, y, z)
        }
        
        public func position(_ scale: Scale) -> Vector {
            
            .init(self,
                  scale)
        }
        
        public func distance(_ other: Self) -> Int {
            
            abs(position.x - other.position.x) +
            abs(position.y - other.position.y) +
            abs(position.z - other.position.z)
        }
    }
}
