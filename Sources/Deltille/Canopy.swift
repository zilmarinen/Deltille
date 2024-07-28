//
//  Canopy.swift
//
//  Created by Zack Brown on 23/05/2024.
//

import Euclid
import Foundation

extension Grid.Triangle {
    
    ///
    /// Canopy defines a series of coordinates wound in a closed loop
    /// starting from the world origin.
    ///

    public enum Canopy: String,
                        CaseIterable,
                        Identifiable {

        case ammann
        case conway
        case escher
        case floret
        case penrose
        case perlin
        case pinwheel
        case snub
        case truchet
        case voronoi
        case wang

        public var id: String { rawValue.capitalized }

        public var coordinates: [Grid.Coordinate] {

            switch self {
                
            case .ammann: return [.zero,
                                  .init(0, -1, 0),
                                  .init(1, -1, 0),
                                  .init(1, -2, 0),
                                  .init(2, -2, 0),
                                  .init(2, -3, 0),
                                  .init(3, -3, 0),
                                  .init(3, -3, -1),
                                  .init(3, -2, -1),
                                  .init(3, -2, -2),
                                  .init(3, -1, -2),
                                  .init(3, -1, -3),
                                  .init(3, 0, -3),
                                  .init(2, 0, -3),
                                  .init(2, 0, -2),
                                  .init(1, 0, -2),
                                  .init(1, 0, -1),
                                  .init(0, 0, -1)]

            case .conway: return [.zero,
                                  .init(0, -1, 0),
                                  .init(1, -1, 0),
                                  .init(1, -2, 0),
                                  .init(2, -2, 0),
                                  .init(2, -3, 0),
                                  .init(3, -3, 0),
                                  .init(3, -3, -1),
                                  .init(3, -2, -1),
                                  .init(3, -2, -2),
                                  .init(3, -1, -2),
                                  .init(2, -1, -2),
                                  .init(2, 0, -2),
                                  .init(1, 0, -2),
                                  .init(1, 0, -1),
                                  .init(0, 0, -1)]
                
            case .escher: return [.zero,
                                  .init(0, -1, 0),
                                  .init(1, -1, 0),
                                  .init(1, -2, 0),
                                  .init(2, -2, 0),
                                  .init(2, -2, -1),
                                  .init(3, -2, -1),
                                  .init(3, -2, -2),
                                  .init(3, -1, -2),
                                  .init(2, -1, -2),
                                  .init(2, -1, -1),
                                  .init(1, -1, -1),
                                  .init(1, 0, -1),
                                  .init(0, 0, -1)]

            case .floret: return [.zero,
                                  .init(0, -1, 0),
                                  .init(1, -1, 0),
                                  .init(1, -1, -1),
                                  .init(1, 0, -1),
                                  .init(0, 0, -1)]

            case .penrose: return [.zero,
                                   .init(0, -1, 0),
                                   .init(1, -1, 0),
                                   .init(1, -2, 0),
                                   .init(2, -2, 0),
                                   .init(2, -2, -1),
                                   .init(3, -2, -1),
                                   .init(3, -2, -2),
                                   .init(3, -1, -2),
                                   .init(3, -1, -3),
                                   .init(3, 0, -3),
                                   .init(2, 0, -3),
                                   .init(2, 1, -3),
                                   .init(1, 1, -3),
                                   .init(1, 1, -2),
                                   .init(0, 1, -2),
                                   .init(0, 1, -1),
                                   .init(0, 0, -1)]
                
            case .perlin: return [.zero,
                                  .init(-1, 1, 0),
                                  .init(-1, 0, 1)]

            case .pinwheel: return [.zero,
                                    .init(0, -1, 0),
                                    .init(1, -1, 0),
                                    .init(1, -1, -1),
                                    .init(2, -1, -1),
                                    .init(2, -1, -2),
                                    .init(2, 0, -2),
                                    .init(1, 0, -2),
                                    .init(1, 1, -2),
                                    .init(0, 1, -2),
                                    .init(0, 1, -1),
                                    .init(0, 0, -1)]

            case .snub: return [.zero,
                                .init(0, -1, 0),
                                .init(1, -1, 0),
                                .init(1, -2, 0),
                                .init(2, -2, 0),
                                .init(2, -2, -1),
                                .init(3, -2, -1),
                                .init(3, -2, -2),
                                .init(3, -1, -2),
                                .init(2, -1, -2),
                                .init(2, 0, -2),
                                .init(1, 0, -2),
                                .init(1, 0, -1),
                                .init(0, 0, -1)]

            case .truchet: return [.zero,
                                   .init(0, -1, 0),
                                   .init(1, -1, 0),
                                   .init(1, -1, -1),
                                   .init(2, -1, -1),
                                   .init(2, -1, -2),
                                   .init(2, 0, -2),
                                   .init(1, 0, -2),
                                   .init(1, 0, -1),
                                   .init(0, 0, -1)]

            case .voronoi: return [.zero,
                                   .init(0, -1, 0),
                                   .init(0, -1, 1),
                                   .init(0, -2, 1),
                                   .init(1, -2, 1),
                                   .init(1, -3, 1),
                                   .init(2, -3, 1),
                                   .init(2, -3, 0),
                                   .init(3, -3, 0),
                                   .init(3, -3, -1),
                                   .init(4, -3, -1),
                                   .init(4, -3, -2),
                                   .init(4, -2, -2),
                                   .init(4, -2, -3),
                                   .init(4, -1, -3),
                                   .init(3, -1, -3),
                                   .init(3, 0, -3),
                                   .init(2, 0, -3),
                                   .init(2, 0, -2),
                                   .init(1, 0, -2),
                                   .init(1, 0, -1),
                                   .init(0, 0, -1)]

            case .wang: return [.zero,
                                .init(0, -1, 0),
                                .init(1, -1, 0),
                                .init(1, -2, 0),
                                .init(1, -2, 1),
                                .init(1, -3, 1),
                                .init(2, -3, 1),
                                .init(2, -3, 0),
                                .init(2, -2, 0),
                                .init(2, -2, -1),
                                .init(3, -2, -1),
                                .init(3, -2, -2),
                                .init(3, -1, -2),
                                .init(2, -1, -2),
                                .init(2, -1, -1),
                                .init(1, -1, -1),
                                .init(1, 0, -1),
                                .init(0, 0, -1)]
            }
        }
        
        public var footprint: Grid.Triangle.Footprint { .init(.zero,
                                                              coordinates) }
    }
}
