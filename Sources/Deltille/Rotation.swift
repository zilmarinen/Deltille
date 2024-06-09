//
//  Rotation.swift
//
//  Created by Zack Brown on 24/05/2024.
//

extension Grid.Triangle.Coordinate {
    
    public enum Rotation {
        
        public static let inverse = 180.0
        public static let step = 120.0
        
        case clockwise
        case counterClockwise
    }
    
    public func rotate(_ rotation: Rotation) -> Self { rotation == .clockwise ? .init(z, x, y) : .init(y, z, x) }
}
