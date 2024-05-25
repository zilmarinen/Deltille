//
//  Double.swift
//
//  Created by Zack Brown on 25/05/2024.
//

extension Double {
    
    func isEqual(to other: Double,
                 withPrecision p: Double) -> Bool { self == other || abs(self - other) < p }
}
