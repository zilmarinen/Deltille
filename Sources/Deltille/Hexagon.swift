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

extension Grid.Hexagon {
    
    public var id: String { vertex.id }
    
    public var vertices: [Vertex] { [.init(vertex.position + .unitX),
                                     .init(vertex.position - .unitZ),
                                     .init(vertex.position + .unitY),
                                     .init(vertex.position - .unitX),
                                     .init(vertex.position + .unitZ),
                                     .init(vertex.position - .unitY)] }
    
    public var corners: [Corner] { Corner.allCases }
    public var edges: [Edge] { Edge.allCases }
    
    public var adjacent: [Self] { edges.map { .init(vertex.position + translation($0)) } }
    public var perimeter: [Self] { adjacent }
    
    public func vertex(_ corner: Corner) -> Vertex { vertices[corner.rawValue] }
    
    public func corner(_ vertex: Vertex) -> Corner? {
        
        guard let index = vertices.firstIndex(of: vertex) else { return nil }
        
        return Corner(rawValue: index)
    }
    
    public func neighbour(_ edge: Edge) -> Self { adjacent[edge.rawValue] }
    
    public func translation(_ along: Edge) -> Grid.Coordinate {
        
        switch along {
            
        case .e0: return .unitX - .unitZ
        case .e1: return .unitY - .unitZ
        case .e2: return .unitY - .unitX
        case .e3: return .unitZ - .unitX
        case .e4: return .unitZ - .unitY
        case .e5: return .unitX - .unitY
        }
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
                
            case .c0: return [.c1, .c5]
            case .c1: return [.c2, .c0]
            case .c2: return [.c3, .c1]
            case .c3: return [.c4, .c2]
            case .c4: return [.c5, .c3]
            case .c5: return [.c0, .c4]
            }
        }
        
        public var edges: [Edge] {
            
            switch self {
                
            case .c0: return [.e0, .e5]
            case .c1: return [.e1, .e0]
            case .c2: return [.e2, .e1]
            case .c3: return [.e3, .e2]
            case .c4: return [.e4, .e3]
            case .c5: return [.e5, .e4]
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
                
            case .e0: return [.c1, .c0]
            case .e1: return [.c2, .c1]
            case .e2: return [.c3, .c2]
            case .e3: return [.c4, .c3]
            case .e4: return [.c5, .c4]
            case .e5: return [.c0, .c5]
            }
        }
        
        public var edges: [Edge] {
            
            switch self {
                
            case .e0: return [.e1, .e5]
            case .e1: return [.e2, .e0]
            case .e2: return [.e3, .e1]
            case .e3: return [.e4, .e2]
            case .e4: return [.e5, .e3]
            case .e5: return [.e0, .e4]
            }
        }
    }
}

// MARK: Footprint

extension Grid.Hexagon {
    
    public struct Footprint: Deltille.Footprint {
        
        public let origin: Grid.Hexagon
        public let tiles: [Grid.Hexagon]
        
        public init(_ origin: Grid.Hexagon,
                    _ tiles: [Grid.Hexagon]) {
         
            self.origin = origin
            self.tiles = tiles
        }
        
        public init(_ origin: Grid.Hexagon,
                    _ coordinates: [Grid.Coordinate]) {
            
            self.origin = origin
            self.tiles = coordinates.map { .init(origin.vertex.position + $0) }
        }
        
        public func intersects(_ tile: Grid.Hexagon) -> Bool { tiles.contains(tile) || tile == origin }
        
        public func center(_ scale: Scale) -> Vector {
                
            let vector = tiles.reduce(into: Vector.zero) { result, tile in
                
                result += Vector(tile.vertex,
                                 scale)
            }
            
            return vector / Double(tiles.count)
        }
        
        public func rotate(_ rotation: Rotation) -> Self {
        
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
        
        public static var inverse: Double = .pi
        public static var step: Double = .tau / 6.0
        
        case clockwise
        case counterClockwise
        
        public var id: String { rawValue }
    }
    
    public func rotate(_ rotation: Rotation) -> Self {
        
        switch rotation {
            
        case .clockwise: return .init(-vertex.position.z,
                                      -vertex.position.x,
                                      -vertex.position.y)
            
        case .counterClockwise: return .init(-vertex.position.y,
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
                
            case .tile: return 0.5
            case .chunk: return 3.5
            case .region: return 14.0
            }
        }
    }
}

// MARK: Vertex

extension Grid.Hexagon {
    
    public struct Vertex: Deltille.Vertex {
        
        public static let zero = Self(.zero)
        
        public let position: Grid.Coordinate
        
        public var tiles: [Grid.Hexagon] { Grid.Axis.allCases.map { .init(position + ($0.unit * (position.equalToOne ? -1 : 1))) } }
        public var vertices: [Vertex] { Grid.Axis.allCases.map { .init(position + ((.one - $0.unit) * (position.equalToOne ? -1 : 1))) } }
        
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

