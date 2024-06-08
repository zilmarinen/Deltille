//
//  Triangle.swift
//
//  Created by Zack Brown on 23/05/2024.
//

import Euclid

extension Grid {
    
    ///
    /// A triangle represents both the position and orientation of
    /// an equilateral triangle on a regular tiling of a triangular grid.
    ///
    public struct Triangle: Equatable,
                            Hashable {
        
        public var isPointy: Bool { position.equalToZero }
        
        public var delta: Int { isPointy ? -1 : 1 }
        
        public var rotation: Double { isPointy ? 0.0 : Coordinate.Rotation.inverse }
        
        public let position: Coordinate
        
        public init(_ position: Coordinate) {
            
            self.position = position
        }
    }
}

public extension Grid.Triangle {
    
    static let zero = Self(.zero)
}

public extension Grid.Triangle {

    var corners: [Coordinate] { Corner.allCases.map { corner($0) } }

    func corner(_ corner: Corner) -> Coordinate {
        
        let unit = (corner.axis.unit * -1) + (isPointy ? .zero : .one)

        return position + (isPointy ? -unit : unit)
    }
    
    func corners(for scale: Scale) -> [Vector] { corners.map { Vector($0,
                                                                      scale) } }

    func index(of vertex: Coordinate) -> Corner? { Corner.allCases.first { self.corner($0) == vertex } }
}

public extension Grid.Triangle {
    
    var perimeter: [Coordinate] { adjacent + diagonals + touching }
    
    ///
    ///  Directly connected adjacent triangles that share an edge.
    ///
    ///                  :-------:
    ///
    ///              :-------:-------:
    ///                \ z / o \ y /
    ///          :-------:-------:-------:
    ///                   \  x  /
    ///              :-------:-------:
    ///
 
    var adjacent: [Coordinate] { Axis.allCases.map { adjacent(along: $0) } }
    
    func adjacent(along axis: Axis) -> Coordinate { position + (axis.unit * delta) }
    
    ///
    ///  Indirectly connected diagonal triangles that are opposite an edge.
    ///
    ///                  :-------:
    ///                   \  x  /
    ///              :-------:-------:
    ///                    / o \
    ///          :-------:-------:-------:
    ///           \  y  /         \  z  /
    ///              :-------:-------:
    ///
    
    var diagonals: [Coordinate] { Axis.allCases.map { diagonal(along: $0) } }
    
    func diagonal(along axis: Axis) -> Coordinate {
        
        switch axis {
            
        case .x: return .init(-delta + position.x, delta + position.y, delta + position.z)
        case .y: return .init(delta + position.x, -delta + position.y, delta + position.z)
        case .z: return .init(delta + position.x, delta + position.y, -delta + position.z)
        }
    }
    
    ///
    ///  Indirectly connected triangles that share a corner.
    ///
    ///                  :-------:
    ///                / z \  /  y \
    ///              :-------:-------:
    ///            / z \   / o \   / y \
    ///          :-------:-------:-------:
    ///                / x \   / x \
    ///              :-------:-------:
    ///
    
    var touching: [Coordinate] { Axis.allCases.flatMap { touching(along: $0) } }
    
    func touching(along axis: Axis) -> [Coordinate] {
        
        switch axis {
            
        case .x: return [.init(-delta + position.x, position.y, delta + position.z),
                         .init(-delta + position.x, delta + position.y, position.z)]
        case .y: return [.init(position.x, -delta + position.y, delta + position.z),
                         .init(delta + position.x, -delta + position.y, position.z)]
        case .z: return [.init(position.x, delta + position.y, -delta + position.z),
                         .init(delta + position.x, position.y, -delta + position.z)]
        }
    }
}
