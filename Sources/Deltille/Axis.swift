//
//  Axis.swift
//
//  Created by Zack Brown on 23/05/2024.
//

// MARK: Axis

extension Grid {
    
    enum Axis: CaseIterable,
               Codable,
               Hashable,
               Identifiable,
               Sendable {
        
        case x, y, z
         
        public var id: String { unit.id }
        
        public var unit: Grid.Coordinate {
            
            switch self {
                
            case .x: return .unitX
            case .y: return .unitY
            case .z: return .unitZ
            }
        }
    }
}
