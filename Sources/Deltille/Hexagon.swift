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
    
    static let zero = Self(.zero)
}

public extension Grid.Hexagon {
 
    var corners: [Vertex] { [] }
}
