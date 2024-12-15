//
//  Corner.swift
//
//  Created by Zack Brown on 23/05/2024.
//

// MARK: Corner

public protocol Corner: CaseIterable,
                        Codable,
                        Equatable,
                        Hashable,
                        RawRepresentable,
                        Sendable {
    
    associatedtype E = Edge
    
    var corners: [Self] { get }
    
    var edges: [E] { get }
}

// MARK: Triangle

extension Grid.Triangle {
    
    public enum Corner: Int,
                        Deltille.Corner {
        
        case c0, c1, c2
        
        public var corners: [Corner] {
                    
            switch self {
                
            case .c0: return [.c1, .c2]
            case .c1: return [.c2, .c0]
            case .c2: return [.c0, .c1]
            }
        }
        
        public var edges: [Edge] {
            
            switch self {
                
            case .c0: return [.e0, .e2]
            case .c1: return [.e1, .e0]
            case .c2: return [.e2, .e1]
            }
        }
    }
}

// MARK: Hexagon

extension Grid.Hexagon {
    
    public enum Corner: Int,
                        Deltille.Corner {
        
        case c0, c1, c2, c3, c4, c5
        
        public var corners: [Corner] {
            
            switch self {
                
            case .c0: return [.c1, .c5]
            case .c1: return [.c2, .c0]
            case .c2: return [.c3, .c1]
            case .c3: return [.c4, .c2]
            case .c4: return [.c5, .c3]
            case .c5: return [.c0, .c4]
            }
        }
        
        public var edges: [Edge] {
            
            switch self {
                
            case .c0: return [.e0, .e5]
            case .c1: return [.e1, .e0]
            case .c2: return [.e2, .e1]
            case .c3: return [.e3, .e2]
            case .c4: return [.e4, .e3]
            case .c5: return [.e5, .e4]
            }
        }
    }
}
