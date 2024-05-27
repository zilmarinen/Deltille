//
//  Vector.swift
//
//  Created by Zack Brown on 25/05/2024.
//

import Euclid

extension Vector {
    
    func isEqual(to other: Vector,
                 withPrecision p: Double = 1e-8) -> Bool {  x.isEqual(to: other.x, withPrecision: p) &&
                                                            y.isEqual(to: other.y, withPrecision: p) &&
                                                            z.isEqual(to: other.z, withPrecision: p) }
}
