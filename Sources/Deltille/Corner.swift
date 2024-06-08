//
//  Corner.swift
//
//  Created by Zack Brown on 23/05/2024.
//

extension Grid.Triangle {
    
    ///
    /// A corner defines one of three vertices of a triangle.
    ///
    
    public enum Corner: Int,
                        CaseIterable {
        
        case c0, c1, c2
        
        public var axis: Grid.Triangle.Axis {
            
            switch self {
                
            case .c0: return .x
            case .c1: return .y
            case .c2: return .z
            }
        }
        
        public var connected: [Corner] {
            
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
