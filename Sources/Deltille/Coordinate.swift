//
//  Coordinate.swift
//
//  Created by Zack Brown on 23/05/2024.
//

import Euclid

///
/// A coordinate represents a position along a two dimensional plane
/// within a regular tiling of a triangular grid.
///
/// Coordinates can be used to define the position of a specific triangle
/// within a grid, or an individual vertex along a triangles edge.
///
/// When using the coordinate as a representation of a triangles position,
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
}

extension Coordinate {
    
    public static let zero = Coordinate(0, 0, 0)
    public static let one = Coordinate(1, 1, 1)
    public static let unitX = Coordinate(1, 0, 0)
    public static let unitY = Coordinate(0, 1, 0)
    public static let unitZ = Coordinate(0, 0, 1)
    
    public static func -(lhs: Coordinate,
                         rhs: Coordinate) -> Coordinate { Coordinate(lhs.x - rhs.x, lhs.y - rhs.y, lhs.z - rhs.z) }
    
    public static func +(lhs: Coordinate,
                         rhs: Coordinate) -> Coordinate { Coordinate(lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z) }
    
    public static prefix func -(rhs: Coordinate) -> Coordinate { Coordinate(-rhs.x, -rhs.y, -rhs.z) }
    
    public static func *(lhs: Coordinate,
                         rhs: Int) -> Coordinate { Coordinate(lhs.x * rhs, lhs.y * rhs, lhs.z * rhs) }
}

extension Coordinate {
    
    public func convert(from: Grid.Scale,
                        to: Grid.Scale) -> Coordinate {
        
        guard from != to else { return self }
        
        return convert(to: from).convert(to: to)
    }
    
    public func convert(to scale: Grid.Scale) -> Vector {
        
        let dx = Double(y)
        let dy = Double(x)
        let dz = Double(z)
            
        return Vector((0.5 * dx + -0.5 * dz) * scale.edgeLength,
                      0.0,
                      ((-.sqrt3d6 * dx) + (.sqrt3d3 * dy) - (.sqrt3d6 * dz)) * scale.edgeLength)
    }
}
