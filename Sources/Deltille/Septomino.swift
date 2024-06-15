//
//  Septomino.swift
//
//  Created by Zack Brown on 24/05/2024.
//

extension Grid.Triangle {
    
    ///
    /// A septomino is a plane geometric figure formed by joining
    /// seven triangles edge to edge.
    ///
    
    public enum Septomino: String,
                           CaseIterable,
                           Identifiable {
        
        case alcyone
        case asterope
        case atlas
        case celaeno
        case electra
        case maia
        case merope
        case pleione
        case sterope
        case taygeta
        
        public var id: String { rawValue.capitalized }
        
        public var coordinates: [Grid.Coordinate] {
            
            switch self {
                
            case .alcyone: return [.zero,
                                   .init(0, 0, -1),
                                   .init(1, 0, -1),
                                   .init(1, 0, -2),
                                   .init(2, 0, -2),
                                   .init(2, 0, -3),
                                   .init(3, 0, -3)]
                
            case .asterope: return [.zero,
                                    .init(0, 0, -1),
                                    .init(1, 0, -1),
                                    .init(1, 0, -2),
                                    .init(2, 0, -2),
                                    .init(1, -1, -1),
                                    .init(1, 1, -2)]
                        
            case .atlas: return [.zero,
                                 .init(-1, 0, 0),
                                 .init(-1, 1, 0),
                                 .init(-2, 1, 0),
                                 .init(-2, 1, 1),
                                 .init(-2, 0, 1),
                                 .init(-1, 0, 1)]
                
            case .celaeno: return [.zero,
                                   .init(0, 0, -1),
                                   .init(1, 0, -1),
                                   .init(1, 0, -2),
                                   .init(2, 0, -2),
                                   .init(1, 1, -2),
                                   .init(2, -1, -2)]
                
            case .electra: return [.zero,
                                   .init(-1, 0, 0),
                                   .init(0, 0, -1),
                                   .init(1, 0, -1),
                                   .init(1, 0, -2),
                                   .init(1, 1, -2),
                                   .init(1, 1, -3)]
                
            case .maia: return [.zero,
                                .init(0, 0, -1),
                                .init(1, 0, -1),
                                .init(1, 0, -2),
                                .init(2, 0, -2),
                                .init(0, -1, 0),
                                .init(1, 1, -2)]
                
            case .merope: return [.zero,
                                  .init(0, 0, -1),
                                  .init(1, 0, -1),
                                  .init(1, 0, -2),
                                  .init(2, 0, -2),
                                  .init(-1, 0, 0),
                                  .init(1, -1, -1)]

            case .pleione: return [.zero,
                                   .init(-1, 0, 0),
                                   .init(0, 0, -1),
                                   .init(1, 0, -1),
                                   .init(1, 0, -2),
                                   .init(1, 1, -2),
                                   .init(-1, 1, 0)]
                
            case .sterope: return [.zero,
                                   .init(0, 0, -1),
                                   .init(1, 0, -1),
                                   .init(0, 1, -1),
                                   .init(-1, 1, -1),
                                   .init(-1, 2, -1),
                                   .init(-2, 2, -1)]
                
            case .taygeta: return [.zero,
                                   .init(-1, 0, 0),
                                   .init(0, -1, 0),
                                   .init(0, -1, 1),
                                   .init(0, -2, 1),
                                   .init(1, -2, 1),
                                   .init(1, -3, 1)]
            }
        }
    }
}
