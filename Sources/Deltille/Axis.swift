//
//  Axis.swift
//
//  Created by Zack Brown on 23/05/2024.
//

// MARK: Axis

public enum Axis: CaseIterable,
                  Codable,
                  Hashable,
                  Identifiable,
                  Sendable {
    
    case x, y, z
     
    public var id: String { unit.id }
}

public extension Axis {
    
    var unit: Coordinate {
        
        switch self {
            
        case .x: .unitX
        case .y: .unitY
        case .z: .unitZ
        }
    }
}
