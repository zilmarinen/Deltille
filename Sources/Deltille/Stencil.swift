//
//  Stencil.swift
//
//  Created by Zack Brown on 24/05/2024.
//

import Euclid

// MARK: Stencil

public protocol Stencil: Sendable {
    
    associatedtype D
    associatedtype S = Scale
    associatedtype V
    
    var scale: S { get }
    
    var center: Vector { get }
    var perimeter: [Vector] { get }
    
    func division(_ division: D) -> [V]
    
    func vertex(_ vertex: V) -> Vector
}

// MARK: Hexagon

extension Hexagon {
    
    public struct Stencil: Deltille.Stencil {
        
        //
        //     0---------1
        //    /   \   /   \
        //   5------c------2
        //    \   /   \   /
        //     4---------3
        //
        
        public enum Division: CaseIterable,
                              Sendable {
        
            case d0, d1, d2, d3, d4, d5
        }
        
        public enum Vertex: CaseIterable,
                            Sendable {
            
            case v0, v1, v2, v3, v4, v5
            case center
        }
        
        public let scale: Hexagon.Scale
        
        public var center: Vector { (v0 + v1 + v2 + v3 + v4 + v5) / 6.0 }
        
        public var perimeter: [Vector] { [v0, v1, v2, v3, v4, v5] }
        
        // Corners
        public let v0, v1, v2, v3, v4, v5: Vector
        
        public func division(_ division: Division) -> [Vertex] {
            
            switch division {
                
            case .d0: [.center, .v0, .v1]
            case .d1: [.center, .v1, .v2]
            case .d2: [.center, .v2, .v3]
            case .d3: [.center, .v3, .v4]
            case .d4: [.center, .v4, .v5]
            case .d5: [.center, .v5, .v0]
            }
        }
        
        public func vertex(_ vertex: Vertex) -> Vector {
            
            switch vertex {
                
            case .v0: v0
            case .v1: v1
            case .v2: v2
            case .v3: v3
            case .v4: v4
            case .v5: v5
            case .center: center
            }
        }
    }
    
    public func stencil(_ scale: Scale) -> Stencil {
        
        return .init(scale: scale,
                     v0: Vector(vertex(.c0),
                                scale),
                     v1: Vector(vertex(.c1),
                                scale),
                     v2: Vector(vertex(.c2),
                                scale),
                     v3: Vector(vertex(.c3),
                                scale),
                     v4: Vector(vertex(.c4),
                                scale),
                     v5: Vector(vertex(.c5),
                                scale))
    }
}

// MARK: Triangle

extension Triangle {
    
    public struct Stencil: Deltille.Stencil {
        
        //
        //  0-------3-------5-------8-------1
        //    \   /   \   /   \   /   \   /
        //      4-------6-------9-------12
        //        \   /   \ c /   \   /
        //          7------10-------13
        //            \   /   \   /
        //             11-------14
        //                \   /
        //                  2
        //
        
        public enum Division: CaseIterable,
                              Sendable {
        
            case d0, d1, d2, d3, d4, d5, d6, d7, d8, d9, d10, d11, d12, d13, d14, d15
        }
        
        public enum Vertex: CaseIterable,
                            Sendable {
            
            case v0, v1, v2
            case v5, v7, v13
            case v6, v9, v10
            case v3, v4, v8, v11, v12, v14
            case center
        }
        
        public let scale: Triangle.Scale
        
        public var center: Vector { (v0 + v1 + v2) / 3.0 }
        
        public var perimeter: [Vector] { [v0, v1, v2] }
        
        // Corners
        public let v0, v1, v2: Vector
        
        // Edge midpoints
        public let v5, v7, v13: Vector
        
        // Inner subdivision
        public let v6, v9, v10: Vector
        
        // Outer subdivisions
        public let v3, v4, v8, v11, v12, v14: Vector
        
        public func division(_ division: Division) -> [Vertex] {
            
            switch division {
                
            case .d0: [.v0, .v3, .v4]
            case .d1: [.v3, .v6, .v4]
            case .d2: [.v3, .v5, .v6]
            case .d3: [.v5, .v9, .v6]
            case .d4: [.v5, .v8, .v9]
            case .d5: [.v8, .v12, .v9]
            case .d6: [.v8, .v1, .v12]
            case .d7: [.v4, .v6, .v7]
            case .d8: [.v6, .v10, .v7]
            case .d9: [.v6, .v9, .v10]
            case .d10: [.v9, .v13, .v10]
            case .d11: [.v9, .v12, .v13]
            case .d12: [.v7, .v10, .v11]
            case .d13: [.v10, .v14, .v11]
            case .d14: [.v10, .v13, .v14]
            case .d15: [.v11, .v14, .v2]
            }
        }
        
        public func vertex(_ vertex: Vertex) -> Vector {
            
            switch vertex {
                
            case .v0: v0
            case .v1: v1
            case .v2: v2
            case .v3: v3
            case .v4: v4
            case .v5: v5
            case .v6: v6
            case .v7: v7
            case .v8: v8
            case .v9: v9
            case .v10: v10
            case .v11: v11
            case .v12: v12
            case .v13: v13
            case .v14: v14
            case .center: center
            }
        }
    }
    
    public func stencil(_ scale: Scale) -> Stencil {
        
        let v0 = Vector(vertex(.c0),
                        scale)
        let v1 = Vector(vertex(.c1),
                        scale)
        let v2 = Vector(vertex(.c2),
                        scale)
        
        let v5 = v0.mid(v1)
        let v7 = v0.mid(v2)
        let v13 = v1.mid(v2)
        
        return .init(scale: scale,
                     v0: v0,
                     v1: v1,
                     v2: v2,
                     v5: v5,
                     v7: v7,
                     v13: v13,
                     v6: v5.mid(v7),
                     v9: v5.mid(v13),
                     v10: v7.mid(v13),
                     v3: v0.mid(v5),
                     v4: v0.mid(v7),
                     v8: v1.mid(v5),
                     v11: v2.mid(v7),
                     v12: v1.mid(v13),
                     v14: v2.mid(v13),)
    }
}
