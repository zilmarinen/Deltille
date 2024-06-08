//
//  Hexagon.swift
//
//  Created by Zack Brown on 05/06/2024.
//

import Euclid

extension Grid {
    
    ///
    /// A hexagon represents the position of a flat topped
    /// six sided polygon on a regular tiling of a triangular grid.
    ///
    public struct Hexagon: Equatable,
                           Hashable {
        
        public let position: Coordinate
                
        public init(_ position: Coordinate) {
            
            self.position = position
        }
    }
}

public extension Grid.Hexagon {
    
    static let unitX = Self(.init(1, 0, 0))
    static let unitY = Self(.init(0, 1, 0))
    static let unitZ = Self(.init(0, 0, 1))
}

public extension Grid.Hexagon {
    
}
