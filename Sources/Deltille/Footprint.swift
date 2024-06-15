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
        
        public let coordinates: [Grid.Coordinate]
        
        public init(_ origin: Grid.Triangle,
                    _ coordinates: [Grid.Coordinate]) {
            
            self.origin = origin
            self.coordinates = coordinates.map { origin.position + (origin.isPointy ? $0 : -$0) }
        }
    }
}

public extension Grid.Triangle.Footprint {
    
    func intersects(_ rhs: Self) -> Bool {
        
        for coordinate in rhs.coordinates {
            
            guard !intersects(rhs: coordinate) else { return true }
        }
        
        return false
    }
    
    func intersects(rhs: Grid.Coordinate) -> Bool { coordinates.contains(rhs) }
}

public extension Grid.Triangle.Footprint {
    
    func rotate(_ rotation: Grid.Triangle.Rotation) -> Self {

        let footprint = coordinates.map { Grid.Triangle(($0 - origin.position) * (origin.isPointy ? 1 : -1)) }
        
        return .init(origin,
                     footprint.map { $0.rotate(rotation).position })
    }
}

public extension Grid.Triangle.Footprint {
    
    func center(_ scale: Grid.Triangle.Scale) -> Vector {
        
        let vector = coordinates.reduce(into: Vector.zero) { result, coordinate in
            
            result += Vector(coordinate,
                             scale)
        }
        
        return vector / Double(coordinates.count)
    }
}
