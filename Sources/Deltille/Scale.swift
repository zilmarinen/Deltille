//
//  Scale.swift
//
//  Created by Zack Brown on 23/05/2024.
//

extension Grid {
    
    ///
    /// Scale represents the edge length of a triangle of a given size.
    ///
    
    public enum Scale {
        
        case sierpinski
        case tile
        case chunk
        case region
        
        public var edgeLength: Double {
            
            switch self {
                
            case .sierpinski: return 0.5 //TODO: determine tile subdivision edge length
            case .tile: return 1.0
            case .chunk: return 7.0
            case .region: return 28.0
            }
        }
    }
}
