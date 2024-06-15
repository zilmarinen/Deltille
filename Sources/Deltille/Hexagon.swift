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

    func corner(_ corner: Corner) -> Grid.Coordinate { position + corner.axis.unit }
    
    func corner(_ vertex: Grid.Coordinate) -> Corner? { Corner.allCases.first { corner($0) == vertex } }
    
    func vertices(_ scale: Scale) -> [Vector] { corners.map { Vector($0,
                                                                     scale) } }
}

public extension Grid.Hexagon {
    
    var perimeter: [Grid.Coordinate] { adjacent }
    
    ///
    ///  Directly connected adjacent hexagons that share an edge.
    ///
    ///                     -:-
    ///                   /     \
    ///               -:-    y    -:-
    ///             /     \     /     \
    ///            -        -:-        -
    ///             \     /     \     /
    ///               -:-    o    -:-
    ///             /     \     /     \
    ///            -   z    -:-    x   -
    ///             \     /     \     /
    ///               -:-         -:-
    ///                   \     /
    ///                     -:-
    ///
 
    var adjacent: [Grid.Coordinate] { Axis.allCases.map { adjacent($0) } }
    
    func adjacent(_ axis: Axis) -> Grid.Coordinate {
        
        switch axis {
            
        case .x: return position + .init(0, -1, 1)
        case .y: return position + .init(1, 0, -1)
        case .z: return position + .init(-1, 1, 0)
        case .inverseX: return position + .init(0, 1, -1)
        case .inverseY: return position + .init(-1, 0, 1)
        case .inverseZ: return position + .init(1, -1, 0)
        }
    }
}
