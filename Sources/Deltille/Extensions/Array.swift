//
//  Array.swift
//
//  Created by Zack Brown on 29/06/2024.
//

import Foundation

public extension Array where Element == Grid.Coordinate {
    
    var perimeter: [Grid.Coordinate] {
        
        var coordinates = Set<Grid.Coordinate>()
        
        forEach { coordinates.formUnion(Grid.Triangle($0).perimeter) }
        
        return Self(coordinates.subtracting(self))
    }
}
