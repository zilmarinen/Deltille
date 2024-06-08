//
//  Footprint.swift
//
//  Created by Zack Brown on 24/05/2024.
//

import Euclid

extension Grid.Triangle {
    
    ///
    ///  Footprint defines a grouping of triangle coordinates centered around its origin.
    ///
    
    public struct Footprint {
        
        public let origin: Grid.Triangle
        
        public let coordinates: [Grid.Triangle.Coordinate]
        
        public init(origin: Grid.Triangle,
                    coordinates: [Grid.Triangle.Coordinate]) {
            
            self.origin = origin
            self.coordinates = coordinates.map { origin.position + (origin.isPointy ? $0 : -$0) }
        }
    }
}

public extension Grid.Triangle.Footprint {
    
    func intersects(rhs: Self) -> Bool {
        
        for coordinate in rhs.coordinates {
            
            guard !intersects(rhs: coordinate) else { return true }
        }
        
        return false
    }
    
    func intersects(rhs: Grid.Triangle.Coordinate) -> Bool { coordinates.contains(rhs) }
}

public extension Grid.Triangle.Footprint {
    
    func rotate(rotation: Grid.Triangle.Coordinate.Rotation) -> Self {

        let footprint = coordinates.map { ($0 - origin.position) * (origin.isPointy ? 1 : -1) }
        
        return Self(origin: origin,
                    coordinates: footprint.map { $0.rotate(rotation: rotation) })
    }
}

public extension Grid.Triangle.Footprint {
    
    func center(at scale: Grid.Scale) -> Vector {
        
        let vector = coordinates.reduce(into: Vector.zero) { result, coordinate in
            
            result += coordinate.convert(to: scale)
        }
        
        return vector / Double(coordinates.count)
    }
}
