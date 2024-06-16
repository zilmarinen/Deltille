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
        
        public var rotation: Double { isPointy ? 0.0 : Rotation.inverse }
        
        public let position: Coordinate
        
        public init(_ position: Coordinate) {
            
            self.position = position
        }
        
        public init(_ x: Int,
                    _ y: Int,
                    _ z: Int) {
            
            self.position = Coordinate(x, y, z)
        }
    }
}

public extension Grid.Triangle {
    
    static let zero = Self(.zero)
}

public extension Grid.Triangle {

    var corners: [Grid.Coordinate] { Corner.allCases.map { corner($0) } }

    func corner(_ corner: Corner) -> Grid.Coordinate {
        
        let unit = (corner.axis.unit * -1) + (isPointy ? .zero : .one)

        return position + (isPointy ? -unit : unit)
    }
    
    func corner(_ vertex: Grid.Coordinate) -> Corner? { Corner.allCases.first { corner($0) == vertex } }
    
    func vertices(_ scale: Scale) -> [Vector] { corners.map { Vector($0,
                                                                     scale) } }
}

public extension Grid.Triangle {
    
    func transpose(_ from: Scale,
                   _ to: Scale) -> Self {
        
        guard from != to else { return self }
        
        return Self(Grid.Coordinate(Vector(position, from), to))
    }
}

public extension Grid.Triangle {
    
    ///
    ///  All connected triangles that share a corner or an edge.
    ///
    ///                  :-------:
    ///                / t \ t / y \
    ///              :-------:-------:
    ///            / t \ t / o \ t / t \
    ///          :-------:-------:-------:
    ///            \ t / t \ t / t \ t /
    ///              :-------:-------:
    ///
    
    var perimeter: [Grid.Coordinate] { adjacent + diagonals + touching }
    
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
 
    var adjacent: [Grid.Coordinate] { Grid.Axis.allCases.map { adjacent($0) } }
    
    func adjacent(_ axis: Grid.Axis) -> Grid.Coordinate { position + (axis.unit * delta) }
    
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
    
    var diagonals: [Grid.Coordinate] { Grid.Axis.allCases.map { diagonal($0) } }
    
    func diagonal(_ axis: Grid.Axis) -> Grid.Coordinate {
        
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
    ///                / z \   / y \
    ///              :-------:-------:
    ///            / z \   / o \   / y \
    ///          :-------:-------:-------:
    ///                / x \   / x \
    ///              :-------:-------:
    ///
    
    var touching: [Grid.Coordinate] { Grid.Axis.allCases.flatMap { touching($0) } }
    
    func touching(_ axis: Grid.Axis) -> [Grid.Coordinate] {
        
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

public extension Grid.Triangle {
    
    ///
    ///  Directly connected adjacent vertices that share an edge.
    ///
    ///                  x-------x
    ///                /   \   /   \
    ///              x-------v-------x
    ///                \   /   \   /
    ///                  x-------x
    ///
    
    static func vertices(_ coordinate: Grid.Coordinate) -> [Grid.Coordinate] {
        
        guard coordinate.equalToOne else { return [] }
        
        return [coordinate + (.unitX + -.unitZ),
                coordinate + (.unitX + -.unitY),
                coordinate + (-.unitY + .unitZ),
                coordinate + (-.unitX + .unitZ),
                coordinate + (-.unitX + .unitY),
                coordinate + (.unitY + -.unitZ)]
    }
    
    ///
    ///  Directly connected adjacent triangles that share an vertex.
    ///
    ///                  ---------
    ///                / x \ x / x \
    ///               -------v-------
    ///                \ x / x \ x /
    ///                  ---------
    ///

    static func triangles(_ coordinate: Grid.Coordinate) -> [Grid.Triangle] {
        
        guard coordinate.equalToOne else { return [] }
        
        return [.init(coordinate - (.unitY + .unitZ)),
                .init(coordinate - .unitY),
                .init(coordinate - (.unitX + .unitY)),
                .init(coordinate - .unitX),
                .init(coordinate - (.unitX + .unitZ)),
                .init(coordinate - .unitZ)]
    }
}
