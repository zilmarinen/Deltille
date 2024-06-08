//
//  Coordinate.swift
//
//  Created by Zack Brown on 23/05/2024.
//

import Euclid

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
    
    func convert(from: Grid.Scale,
                 to: Grid.Scale) -> Self {
        
        guard from != to else { return self }
        
        return convert(to: from).convert(to: to)
    }
    
    func convert(to scale: Grid.Scale) -> Vector {
        
        let dx = Double(y)
        let dy = Double(x)
        let dz = Double(z)
            
        return .init((0.5 * dx + -0.5 * dz) * scale.edgeLength,
                      0.0,
                      ((-.sqrt3d6 * dx) + (.sqrt3d3 * dy) - (.sqrt3d6 * dz)) * scale.edgeLength)
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
    }
}

public extension Grid.Hexagon.Coordinate {
    
    static let zero = Self(0, 0, 0)
    static let one = Self(1, 1, 1)
    static let unitX = Self(1, -1, 0)
    static let unitY = Self(0, 1, -1)
    static let unitZ = Self(-1, 0, 1)
    
    static func -(lhs: Self,
                  rhs: Self) -> Self { .init(lhs.x - rhs.x, lhs.y - rhs.y, lhs.z - rhs.z) }
    
    static func +(lhs: Self,
                  rhs: Self) -> Self { .init(lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z) }
    
    static prefix func -(rhs: Self) -> Self { .init(-rhs.x, -rhs.y, -rhs.z) }
    
    static func *(lhs: Self,
                  rhs: Int) -> Self { .init(lhs.x * rhs, lhs.y * rhs, lhs.z * rhs) }
}
