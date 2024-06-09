//
//  Coordinate.swift
//
//  Created by Zack Brown on 23/05/2024.
//

import Euclid
import Foundation

// MARK: Grid.Triangle.Coordinate

extension Grid.Triangle {
    ///
    /// A coordinate represents a position along a two dimensional plane
    /// within a regular tiling of a triangular grid.
    ///
    /// Coordinates can be used to define the position of a specific triangle
    /// within a grid, or an individual vertex along a triangles edge.
    ///
    /// When using the coordinate to represent the position of a triangle,
    /// the sum of all components must either equal 0 or -1.
    ///
    /// When using the coordinate to define a vertex along a triangles edge,
    /// the sum of all components must be equal to 1 exactly.
    ///
    
    public struct Coordinate: Codable,
                              Equatable,
                              Hashable,
                              Identifiable {
        
        public let x: Int
        public let y: Int
        public let z: Int
        
        public var id: String { "[\(x), \(y), \(z)]" }
        
        public var sum: Int { x + y + z }
        
        public var equalToZero: Bool { sum == 0 }
        public var equalToOne: Bool { sum == 1 }
        public var equalToNegativeOne: Bool { sum == -1 }
        
        public init(_ x: Int,
                    _ y: Int,
                    _ z: Int) {
            
            self.x = x
            self.y = y
            self.z = z
        }
        
        init(_ vector: Vector,
             _ scale: Grid.Triangle.Scale) {
            
            let offset = Double.sqrt3d6 * scale.edgeLength
            let slope = (.sqrt3d3 * vector.z)
            
            let j = (2.0 * slope) + offset
            let i = (vector.x - slope) + offset
            let k = (-vector.x - slope) + offset
            
            self.init(Int(floor(j / scale.edgeLength)),
                      Int(floor(i / scale.edgeLength)),
                      Int( ceil(k / scale.edgeLength) - 1.0))
        }
    }
}

public extension Grid.Triangle.Coordinate {
    
    static let zero = Self(0, 0, 0)
    static let one = Self(1, 1, 1)
    static let unitX = Self(1, 0, 0)
    static let unitY = Self(0, 1, 0)
    static let unitZ = Self(0, 0, 1)
    
    static func -(lhs: Self,
                  rhs: Self) -> Self { .init(lhs.x - rhs.x, lhs.y - rhs.y, lhs.z - rhs.z) }
    
    static func +(lhs: Self,
                  rhs: Self) -> Self { .init(lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z) }
    
    static prefix func -(rhs: Self) -> Self { .init(-rhs.x, -rhs.y, -rhs.z) }
    
    static func *(lhs: Self,
                  rhs: Int) -> Self { .init(lhs.x * rhs, lhs.y * rhs, lhs.z * rhs) }
}

public extension Grid.Triangle.Coordinate {
    
    func transpose(from: Grid.Triangle.Scale,
                   to: Grid.Triangle.Scale) -> Self {
        
        guard from != to else { return self }
        
        return Self(Vector(self,
                           from),
                    to)
    }
}

// MARK: Grid.Hexagon.Coordinate

extension Grid.Hexagon {
    ///
    /// A coordinate represents a position along a two dimensional plane
    /// within a regular tiling of a triangular grid.
    ///
    /// Coordinates can be used to define the position of a specific hexagon
    /// within a grid, or an individual vertex along a hexagons edge.
    ///
    /// When using the coordinate to represent the position of a hexagon,
    /// the sum of all components must be equal to 1 exactly.
    ///
    /// When using the coordinate to define a vertex along a hexagons edge,
    /// the sum of all components must either equal 0 or 2.
    ///
    
    public struct Coordinate: Codable,
                              Equatable,
                              Hashable,
                              Identifiable {
        
        public let x: Int
        public let y: Int
        public let z: Int
        
        public var id: String { "[\(x), \(y), \(z)]" }
        
        public var sum: Int { x + y + z }
        
        public var equalToZero: Bool { sum == 0 }
        public var equalToOne: Bool { sum == 1 }
        public var equalToTwo: Bool { sum == 2 }
        
        public init(_ x: Int,
                    _ y: Int,
                    _ z: Int) {
            
            self.x = x
            self.y = y
            self.z = z
        }
        
        init(_ vector: Vector,
             _ scale: Grid.Hexagon.Scale) {
            
            let offset = Double.sqrt3d6 * scale.edgeLength
            let slope = (.sqrt3d3 * vector.z)
            
            let j = (2.0 * slope) + offset
            let i = (vector.x - slope) + offset
            let k = (-vector.x - slope) + offset
            
            self.init(Int(floor(j / scale.edgeLength)),
                      Int(floor(i / scale.edgeLength)),
                      Int( ceil(k / scale.edgeLength) - 1.0))
            
//            return ((             a +                                -c) * edge_length,
//                        (-sqrt3 / 3 * a + sqrt3 * 2 / 3 * b - sqrt3 / 3 * c) * edge_length)
        }
    }
}

public extension Grid.Hexagon.Coordinate {
    
    static let zero = Self(0, 0, 0)
    static let one = Self(1, 1, 1)
    static let unitX = Self(1, 0, 0)
    static let unitY = Self(0, 1, 0)
    static let unitZ = Self(0, 0, 1)
    static let translationX = Self(1, -1, 0)
    static let translationY = Self(0, 1, -1)
    static let translationZ = Self(-1, 0, 1)
    
    static func -(lhs: Self,
                  rhs: Self) -> Self { .init(lhs.x - rhs.x, lhs.y - rhs.y, lhs.z - rhs.z) }
    
    static func +(lhs: Self,
                  rhs: Self) -> Self { .init(lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z) }
    
    static prefix func -(rhs: Self) -> Self { .init(-rhs.x, -rhs.y, -rhs.z) }
    
    static func *(lhs: Self,
                  rhs: Int) -> Self { .init(lhs.x * rhs, lhs.y * rhs, lhs.z * rhs) }
}
