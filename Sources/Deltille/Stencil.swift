//
//  Stencil.swift
//
//  Created by Zack Brown on 24/05/2024.
//

import Euclid

extension Grid.Triangle {
    
    ///
    ///  Stencil defines a fixed set of points for the corners, edges
    ///  and interior subdivisions of a triangle and its center.
    ///
    ///      0-------3-------5-------8-------1
    ///        \   /   \   /   \   /   \   /
    ///          4-------6-------9-------12
    ///            \   /   \ c /   \   /
    ///              7------10-------13
    ///                \   /   \   /
    ///                 11-------14
    ///                    \   /
    ///                      2
    ///
    
    public struct Stencil {
        
        public enum Vertex: CaseIterable {
            
            case v0, v1, v2
            case v5, v7, v13
            case v6, v9, v10
            case v3, v4, v8, v11, v12, v14
            case center
        }
        
        // Subdivided triangles
        public static let subdivisions: [[Vertex]] = [[.v0, .v3, .v4],
                                                      [.v3, .v6, .v4],
                                                      [.v3, .v5, .v6],
                                                      [.v5, .v9, .v6],
                                                      [.v5, .v8, .v9],
                                                      [.v8, .v12, .v9],
                                                      [.v8, .v1, .v12],
                                                      [.v4, .v6, .v7],
                                                      [.v6, .v10, .v7],
                                                      [.v6, .v9, .v10],
                                                      [.v9, .v13, .v10],
                                                      [.v9, .v12, .v13],
                                                      [.v7, .v10, .v11],
                                                      [.v10, .v14, .v11],
                                                      [.v10, .v13, .v14],
                                                      [.v11, .v14, .v2]]
        
        // Triangle corners
        public let v0, v1, v2: Vector
        
        // Edge midpoints
        public let v5, v7, v13: Vector
        
        // Inner subdivision
        public let v6, v9, v10: Vector
        
        // Outer subdivisions
        public let v3, v4, v8, v11, v12, v14: Vector
        
        public let scale: Scale
        
        public var center: Vector { (v0 + v1 + v2) / 3.0 }
        
        public func vertex(_ vertex: Vertex) -> Vector {
            
            switch vertex {
                
            case .v0: return v0
            case .v1: return v1
            case .v2: return v2
            case .v3: return v3
            case .v4: return v4
            case .v5: return v5
            case .v6: return v6
            case .v7: return v7
            case .v8: return v8
            case .v9: return v9
            case .v10: return v10
            case .v11: return v11
            case .v12: return v12
            case .v13: return v13
            case .v14: return v14
            case .center: return center
            }
        }
    }
    
    public func stencil(_ scale: Scale) -> Stencil {
        
        let v0 = Vector(corner(.c0),
                        scale)
        let v1 = Vector(corner(.c1), 
                        scale)
        let v2 = Vector(corner(.c2), 
                        scale)
        
        let v5 = v0.mid(v1)
        let v7 = v0.mid(v2)
        let v13 = v1.mid(v2)
        
        return .init(v0: v0,
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
                     v14: v2.mid(v13),
                     scale: scale)
    }
}
