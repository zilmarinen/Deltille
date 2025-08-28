//
//  Hexagon.swift
//
//  Created by Zack Brown on 05/06/2024.
//

import Euclid
import Foundation

// MARK: Hexagon

extension Grid {
    
    public struct Hexagon: Tile {
        
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
            
            self.vertex = Vertex(x, y, z)
        }
        
        public init(_ vector: Vector,
                    _ scale: Scale) {

            let i = ceil((vector.z - .sqrt3d3  * vector.x) / scale.edgeLength)
            let j = floor((     .sqrt3d3 * 2.0 * vector.x) / scale.edgeLength) + 1
            let k = ceil((-vector.z - .sqrt3d3 * vector.x) / scale.edgeLength)
            
            self.vertex = Vertex(Int(round((i - k) / 3.0)),
                                 Int(round((j - i) / 3.0)),
                                 Int(round((k - j) / 3.0)))
        }
    }
}

extension Grid.Hexagon {
    
    public var id: String { vertex.id }
    
    public var vertices: [Vertex] {
        
        [.init(vertex.position + .unitX),
         .init(vertex.position - .unitZ),
         .init(vertex.position + .unitY),
         .init(vertex.position - .unitX),
         .init(vertex.position + .unitZ),
         .init(vertex.position - .unitY)]
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
    
    public var perimeter: [Self] { adjacent }
}

extension Grid.Hexagon {
    
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
    
    public func translation(_ along: Edge) -> Grid.Coordinate {
        
        switch along {
            
        case .e0: .unitX - .unitZ
        case .e1: .unitY - .unitZ
        case .e2: .unitY - .unitX
        case .e3: .unitZ - .unitX
        case .e4: .unitZ - .unitY
        case .e5: .unitX - .unitY
        }
    }
    
    public func contains(_ vector: Vector,
                         _ scale: Scale) -> Bool {
        
        let center = position(scale)
        
        let dx = abs(vector.x - center.x)
        let dz = abs(vector.z - center.z)
        
        if dx > scale.edgeLength * 1.5 { return false }
        if dz > scale.edgeLength * .sqrt3  { return false }
        
        return (dz * 2.0 + dx * .sqrt3) <= .sqrt3 * scale.edgeLength * 2.0
    }
    
    public func mesh(_ scale: Scale) -> Mesh {
        
        let vertices = self.vertices.map {
            
            Euclid.Vertex($0.position(scale),
                          .unitY)
        }
        
        guard let polygon = Polygon(vertices) else { fatalError("Degenerate tile vertices") }
        
        return .init([polygon])
    }
}

// MARK: Corner

extension Grid.Hexagon {
    
    public enum Corner: Int,
                        Deltille.Corner {
        
        case c0, c1, c2, c3, c4, c5
        
        public var id: String { "\(rawValue)" }
        
        public var corners: [Corner] {
            
            switch self {
                
            case .c0: [.c1, .c5]
            case .c1: [.c2, .c0]
            case .c2: [.c3, .c1]
            case .c3: [.c4, .c2]
            case .c4: [.c5, .c3]
            case .c5: [.c0, .c4]
            }
        }
        
        public var edges: [Edge] {
            
            switch self {
                
            case .c0: [.e0, .e5]
            case .c1: [.e1, .e0]
            case .c2: [.e2, .e1]
            case .c3: [.e3, .e2]
            case .c4: [.e4, .e3]
            case .c5: [.e5, .e4]
            }
        }
    }
}

// MARK: Edge

extension Grid.Hexagon {
    
    public enum Edge: Int,
                      Deltille.Edge {
        
        case e0, e1, e2, e3, e4, e5
        
        public var id: String { "\(rawValue)" }
        
        public var corners: [Corner] {
            
            switch self {
                
            case .e0: [.c1, .c0]
            case .e1: [.c2, .c1]
            case .e2: [.c3, .c2]
            case .e3: [.c4, .c3]
            case .e4: [.c5, .c4]
            case .e5: [.c0, .c5]
            }
        }
        
        public var edges: [Edge] {
            
            switch self {
                
            case .e0: [.e1, .e5]
            case .e1: [.e2, .e0]
            case .e2: [.e3, .e1]
            case .e3: [.e4, .e2]
            case .e4: [.e5, .e3]
            case .e5: [.e0, .e4]
            }
        }
    }
}

// MARK: Footprint

extension Grid.Hexagon {
    
    open class Footprint: Deltille.Footprint<Scale,
                                             Grid.Hexagon,
                                             Rotation,
                                             Vertex> {
        
        public convenience init(_ origin: Grid.Hexagon,
                    _ coordinates: [Grid.Coordinate]) {
            
            self.init(origin,
                      coordinates.map {
                
                .init(origin.vertex.position + $0)
            })
        }
        
        public override func rotate(_ rotation: Rotation) -> Self {
        
            let hexagons = tiles.map {
                
                let hexagon = Grid.Hexagon($0.vertex.position - origin.vertex.position)
                
                let rotated = hexagon.rotate(rotation)
                
                return Grid.Hexagon(rotated.vertex.position + origin.vertex.position)
            }
            
            return Self(origin,
                        hexagons)
        }
    }
}

// MARK: Rotation

extension Grid.Hexagon: Rotatable {
    
    public enum Rotation: String,
                          Deltille.Rotation {
        
        public static let inverse: Double = .pi
        public static let step: Double = .tau / 6.0
        
        case clockwise
        case counterClockwise
        
        public var id: String { rawValue }
    }
    
    public func rotate(_ rotation: Rotation) -> Self {
        
        switch rotation {
            
        case .clockwise:
            
            .init(-vertex.position.z,
                  -vertex.position.x,
                  -vertex.position.y)
            
        case .counterClockwise:
            
            .init(-vertex.position.y,
                  -vertex.position.z,
                  -vertex.position.x)
        }
    }
}

// MARK: Scale

extension Grid.Hexagon {
    
    public enum Scale: String,
                       Deltille.Scale {
        
        case tile
        case chunk
        case region
        
        public var id: String { rawValue.capitalized }
        
        public var edgeLength: Double {
            
            switch self {
                
            case .tile: 0.5
            case .chunk: 3.5
            case .region: 14.0
            }
        }
    }
}

// MARK: Vertex

extension Grid.Hexagon {
    
    public struct Vertex: Deltille.Vertex {
        
        public static let zero = Self(.zero)
        
        public let position: Grid.Coordinate
        
        public var tiles: [Grid.Hexagon] {
            
            Grid.Axis.allCases.map {
                
                .init(position + ($0.unit * (position.equalToOne ? -1 : 1)))
            }
        }
        
        public var vertices: [Vertex] {
            
            Grid.Axis.allCases.map {
                
                .init(position + ((.one - $0.unit) * (position.equalToOne ? -1 : 1)))
            }
        }
        
        public init(_ position: Grid.Coordinate) {
            
            self.position = position
        }
        
        public init(_ x: Int,
                    _ y: Int,
                    _ z: Int) {
            
            self.position = .init(x, y, z)
        }
        
        public func position(_ scale: Scale) -> Vector {
            
            Vector(self,
                   scale)
        }
    }
}

