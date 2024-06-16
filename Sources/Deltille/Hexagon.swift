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
    
    var corners: [Grid.Coordinate] { Corner.allCases.map { corner($0) } }

    func corner(_ corner: Corner) -> Grid.Coordinate {
        
        switch corner {

        case .c0: position + .unitX
        case .c1: position + -.unitZ
        case .c2: position + .unitY
        case .c3: position + -.unitX
        case .c4: position + .unitZ
        case .c5: position + -.unitY
        }
    }
    
    func corner(_ vertex: Grid.Coordinate) -> Corner? { Corner.allCases.first { corner($0) == vertex } }
    
    func vertices(_ scale: Scale) -> [Vector] { corners.map { Vector($0,
                                                                     scale) } }
}

public extension Grid.Hexagon {
    
    ///
    ///  Directly connected adjacent hexagons that share an edge.
    ///
    ///                     -:-
    ///                   /     \
    ///               -:-    h    -:-
    ///             /     \     /     \
    ///            -   h    -:-    h   -
    ///             \     /     \     /
    ///               -:-    o    -:-
    ///             /     \     /     \
    ///            -   h    -:-    h   -
    ///             \     /     \     /
    ///               -:-    h    -:-
    ///                   \     /
    ///                     -:-
    ///
 
    var perimeter: [Grid.Coordinate] { [position + .init(1, 0, -1),
                                        position + .init(1, -1, 0),
                                        position + .init(0, -1, 1),
                                        position + .init(-1, 0, 1),
                                        position + .init(-1, 1, 0),
                                        position + .init(0, 1, -1)] }
}
