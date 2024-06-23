//
//  Scale.swift
//
//  Created by Zack Brown on 23/05/2024.
//

extension Grid.Triangle {
    
    ///
    /// Scale represents the edge length for a triangle of a given size.
    ///
    
    public enum Scale {
        
        case sierpinski
        case tile
        case chunk
        case region
        
        public var edgeLength: Double {
            
            switch self {
                
            case .sierpinski: return 0.1428571429
            case .tile: return 1.0
            case .chunk: return 7.0
            case .region: return 28.0
            }
        }
    }
}

extension Grid.Hexagon {
    
    ///
    /// Scale represents the edge length for a hexagon of a given size.
    ///
    
    public enum Scale {
        
        case tile
        case chunk
        case region
        
        public var edgeLength: Double {
            
            switch self {
                
            case .tile: return 0.5
            case .chunk: return 3.5
            case .region: return 14.0
            }
        }
    }
}
