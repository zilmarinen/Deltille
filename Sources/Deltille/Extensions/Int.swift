//
//  Int.swift
//  Deltille
//
//  Created by Zack Brown on 25/07/2026.
//

extension Int {
    
    static func floorDivision(_ a: Int, _ b: Int) -> Int {
        
        let q = a / b
        let r = a % b
        
        return (r != 0 && (r < 0) != (b < 0)) ? q - 1 : q
    }
}
