//
//  Vector.swift
//
//  Created by Zack Brown on 24/05/2024.
//

import Euclid
import Foundation

extension Vector: @retroactive Identifiable {
    
    public var id: String { "[\(x), \(y), \(z)]" }
}

public extension Vector {
    
    func mid(_ other: Self) -> Self { lerp(other, 0.5) }
}
