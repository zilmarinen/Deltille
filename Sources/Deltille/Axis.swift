//
//  Axis.swift
//
//  Created by Zack Brown on 23/05/2024.
//

extension Grid {
    
    ///
    /// Axis defines the three degrees of freedom used to represent
    /// the dimensions of translation allowed within a triangular grid.
    ///
    
    public enum Axis: Int,
                      CaseIterable {
        
        case x, y, z
        
        public var unit: Grid.Coordinate {
            
            switch self {
                
            case .x: return .unitX
            case .y: return .unitY
            case .z: return .unitZ
            }
        }
    }
}
