//
//  Edge.swift
//
//  Created by Zack Brown on 24/05/2024.
//

// MARK: Edge

public protocol Edge: CaseIterable,
                      Codable,
                      Equatable,
                      Hashable,
                      RawRepresentable,
                      Sendable {
    
    associatedtype C = Corner
    
    var corners: [C] { get }
    
    var edges: [Self] { get }
}

// MARK: Triangle

extension Grid.Triangle {
    
    public enum Edge: Int,
                      Deltille.Edge {
        
        case e0, e1, e2
        
        public var corners: [Corner] {
            
            switch self {
                
            case .e0: return [.c1, .c0]
            case .e1: return [.c2, .c1]
            case .e2: return [.c0, .c2]
            }
        }
        
        public var edges: [Edge] {
           
            switch self {
               
            case .e0: return [.e1, .e2]
            case .e1: return [.e2, .e0]
            case .e2: return [.e0, .e1]
            }
        }
    }
}

// MARK: Hexagon

extension Grid.Hexagon {
    
    public enum Edge: Int,
                      Deltille.Edge {
        
        case e0, e1, e2, e3, e4, e5
        
        public var corners: [Corner] {
            
            switch self {
                
            case .e0: return [.c1, .c0]
            case .e1: return [.c2, .c1]
            case .e2: return [.c3, .c2]
            case .e3: return [.c4, .c3]
            case .e4: return [.c5, .c4]
            case .e5: return [.c0, .c5]
            }
        }
        
        public var edges: [Edge] {
            
            switch self {
                
            case .e0: return [.e1, .e5]
            case .e1: return [.e2, .e0]
            case .e2: return [.e3, .e1]
            case .e3: return [.e4, .e2]
            case .e4: return [.e5, .e3]
            case .e5: return [.e0, .e4]
            }
        }
    }
}
