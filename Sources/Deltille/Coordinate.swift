//
//  Coordinate.swift
//
//  Created by Zack Brown on 23/05/2024.
//

import Euclid
import Foundation

extension Grid {
    ///
    /// A coordinate represents a position along a two dimensional plane
    /// within a regular tiling of a triangular grid.
    ///
    /// Coordinates can be used to define the center position of a specific triangle
    /// or hexagon within a grid, or an individual vertex along a triangle or hexagon edge.
    ///
    /// # Triangles:
    ///
    /// When using the coordinate to represent the position of a triangle,
    /// the sum of all components must either equal 0 or -1.
    ///
    /// When using the coordinate to define a vertex along a triangles edge,
    /// the sum of all components must be equal to 1 exactly.
    ///
    /// # Hexagons:
    ///
    /// When using the coordinate to represent the position of a hexagon,
    /// the sum of all components must be equal to 0 exactly.
    ///
    /// When using the coordinate to define a vertex along a hexagons edge,
    /// the sum of all components must either equal -1 or 1.
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
        
        public init(_ vector: Vector,
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
        
        public init(_ vector: Vector,
                    _ scale: Grid.Hexagon.Scale) {
            
            let slope = (.sqrt3d3 * vector.z)
            
            let j = 2.0 * slope
            let i = vector.x - slope
            let k = -vector.x - slope
            
            let s = Int(floor(j / scale.edgeLength))
            let t = Int(floor(i / scale.edgeLength))
            let u = Int( ceil(k / scale.edgeLength) - 1.0)
            
            self.init(Int(round(Double(s - t) / 3.0)),
                      Int(round(Double(t - u) / 3.0)),
                      Int(round(Double(u - s) / 3.0)))
        }
    }
}

public extension Grid.Coordinate {
    
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
