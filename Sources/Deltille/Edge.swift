//
//  Edge.swift
//
//  Created by Zack Brown on 24/05/2024.
//

extension Grid.Triangle {
    
    ///
    /// An edge defines one of three sides of a triangle.
    ///
    
    public enum Edge: Int,
                      CaseIterable {
        
        case e0, e1, e2
        
        public var connected: [Edge] {
            
            switch self {
                
            case .e0: return [.e1, .e2]
            case .e1: return [.e2, .e0]
            case .e2: return [.e0, .e1]
            }
        }
        
        public var corners: [Corner] {
            
            switch self {
                
            case .e0: return [.c1, .c0]
            case .e1: return [.c2, .c1]
            case .e2: return [.c0, .c2]
            }
        }
    }
}
