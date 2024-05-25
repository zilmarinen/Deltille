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

extension Grid.Triangle {
    
    public static let zero = Grid.Triangle(.zero)
}

extension Grid.Triangle {

    public var corners: [Coordinate] { Corner.allCases.map { corner($0) } }

    public func corner(_ corner: Corner) -> Coordinate {
        
        let unit = (corner.axis.unit * -1) + (isPointy ? .zero : .one)

        return position + (isPointy ? -unit : unit)
    }
    
    public func corners(for scale: Grid.Scale) -> [Vector] { corners.map { $0.convert(to: scale) } }

    public func index(of vertex: Coordinate) -> Grid.Triangle.Corner? { Corner.allCases.first { self.corner($0) == vertex } }
}
