//
//  Stencil.swift
//  Deltille
//
//  Created by Zack Brown on 24/05/2024.
//

import Euclid

// MARK: Stencil

public protocol Stencil: Sendable {
    
    associatedtype D
    associatedtype V
    
    var center: Vector { get }
    var perimeter: [Vector] { get }
    
    func division(_ division: D) -> [V]
    
    func vertex(_ vertex: V) -> Vector
}
