//
//  Triangle.swift
//  Deltille
//
//  Created by Zack Brown on 23/05/2024.
//

import Euclid
import Foundation

// MARK: Triangle

public struct Triangle: Tile {
    
    public typealias D = Hexagon
    
    public let x: Int
    public let y: Int
    public let z: Int
    
    public init(_ x: Int,
                _ y: Int,
                _ z: Int) {
        
        self.x = x
        self.y = y
        self.z = z
    }
    
    public init(_ vector: Vector,
                _ lattice: Double = 1.0) {
        
        let i = ceil((vector.z - .sqrt3d3 * vector.x) / lattice)
        let j = floor((.sqrt3d3 * 2.0 * vector.x) / lattice) + 1
        let k = ceil((-vector.z - .sqrt3d3 * vector.x) / lattice)
        
        let triangle = Triangle(Int(round((i - k) / 3.0)),
                                Int(round((j - i) / 3.0)),
                                Int(round((k - j) / 3.0)))
        
        let triangles = [triangle] + triangle.adjacent
        
        let closest = triangles.first {
            
            $0.contains(vector,
                        .tile,
                        lattice)
        } ?? triangle
        
        self.init(closest.x,
                  closest.y,
                  closest.z)
    }
}

public extension Triangle {
 
    static func size(for scale: Scale) -> Int {
        
        switch scale {
        
        case .tile: 1
        case .chunk: 7
        case .region: 31
        }
    }
}

public extension Triangle {
    
    var isPointy: Bool {
        
        equalToZero
    }
    
    var orientation: Double {
        
        isPointy ? 0.0 : .pi
    }
}

public extension Triangle {
    
    func contains(_ vector: Vector,
                  _ scale: Scale = .default,
                  _ lattice: Double = 1.0) -> Bool {
        
        let c0 = vertex(.c0,
                        scale).vector(lattice)
        let c1 = vertex(.c1,
                        scale).vector(lattice)
        let c2 = vertex(.c2,
                        scale).vector(lattice)
        
        let v0 = c2 - c0
        let v1 = c1 - c0
        let v2 = vector - c0
        
        let v0v0 = v0.dot(v0)
        let v0v1 = v0.dot(v1)
        let v0v2 = v0.dot(v2)
        let v1v1 = v1.dot(v1)
        let v1v2 = v1.dot(v2)
        
        let denominator = (v0v0 * v1v1 - v0v1 * v0v1)
        if abs(denominator) < 1e-8 { return false }
        
        let inverse = 1.0 / denominator
        let u = (v1v1 * v0v2 - v0v1 * v1v2) * inverse
        let v = (v0v0 * v1v2 - v0v1 * v0v2) * inverse
        
        return (u >= 0.0) && (v >= 0.0) && (u + v <= 1.0)
    }
    
    func disc(_ radius: Int) -> [Self] {
        
        var tiles: [Self] = []
        
        for i in -radius...radius {
            
            for j in -radius...radius {
             
                let s = -1 - (sum + i + j)
                
                for k in s...(s + 1) {
                    
                    if abs(i) + abs(j) + abs(k) <= radius {
                        
                        tiles.append(self + .init(i, j, k))
                    }
                }
            }
        }
        
        return tiles
    }
    
    func neighbour(_ edge: Edge) -> Triangle {
        
        switch edge {
            
        case .e0:
            
            self + (isPointy ? -.unitX : .unitX)
            
        case .e1:
            
            self + (isPointy ? -.unitY : .unitY)
            
        case .e2:
            
            self + (isPointy ? -.unitZ : .unitZ)
        }
    }
    
    func vertex(_ corner: Corner,
                _ scale: Scale = .default) -> Vertex {
        
        let size = Self.size(for: scale)
        let u = (size / 3) + 1
        let v = u / 2
        
        let dx = Vertex(u, -v, -v)
        let dy = Vertex(-v, u, -v)
        let dz = Vertex(-v, -v, u)
        
        let origin = Vertex(dx.x * x + dy.x * y + dz.x * z,
                            dx.y * x + dy.y * y + dz.y * z,
                            dx.z * x + dy.z * y + dz.z * z)
        
        switch corner {
            
        case .c0:
            
            return origin + (isPointy ? dx : .one - dx)
            
        case .c1:
            
            return origin + (isPointy ? dy : .one - dy)
            
        case .c2:
            
            return origin + (isPointy ? dz : .one - dz)
        }
    }
}

// MARK: Corner

public extension Triangle {
    
    enum Corner: Int,
                 Deltille.Corner {
        
        case c0, c1, c2
        
        public var id: String {
            
            "\(rawValue)"
        }
        
        public var corners: [Corner] {
                    
            switch self {
                
            case .c0: [.c1, .c2]
            case .c1: [.c2, .c0]
            case .c2: [.c0, .c1]
            }
        }
        
        public var edges: [Edge] {
            
            switch self {
                
            case .c0: [.e0, .e2]
            case .c1: [.e1, .e0]
            case .c2: [.e2, .e1]
            }
        }
    }
}

// MARK: Edge

public extension Triangle {
    
    enum Edge: Int,
               Deltille.Edge {
        
        case e0, e1, e2
        
        public var id: String {
            
            "\(rawValue)"
        }
        
        public var corners: [Corner] {
            
            switch self {
                
            case .e0: [.c2, .c1]
            case .e1: [.c0, .c2]
            case .e2: [.c1, .c0]
            }
        }
        
        public var edges: [Edge] {
           
            switch self {
               
            case .e0: [.e1, .e2]
            case .e1: [.e2, .e0]
            case .e2: [.e0, .e1]
            }
        }
    }
}

// MARK: Footprint

public extension Triangle {
    
    struct Footprint: Deltille.Footprint {
        
        public let origin: Triangle
        public let tiles: [Triangle]
        
        public init(_ origin: Triangle,
                    _ tiles: [Triangle]) {
         
            self.origin = origin
            self.tiles = tiles
        }
        
        public func rotate(_ rotation: Rotation) -> Self {
            
            let triangles = tiles.map {
                
                let triangle = $0 - origin
                
                let rotated = triangle.rotate(rotation)
                
                return rotated + origin
            }
            
            return .init(origin,
                         triangles)
        }
    }
}

// MARK: Rotation

public extension Triangle {
    
    struct Rotation: Deltille.Rotation {
        
        public static let turns: Int = 3
        
        public let turns: Int
        
        public init(_ turns: Int) {
            
            self.turns = Self.wrap(turns)
        }
    }
    
    func rotate(_ rotation: Rotation) -> Self {
        
        var rotated = self
                
        for _ in 0..<rotation.turns {
            
            rotated = .init(rotated.y,
                            rotated.z,
                            rotated.x)
        }
        
        return rotated
    }
}

// MARK: Scale

public extension Triangle {
    
    func transpose(_ from: Scale,
                   _ to: Scale) -> Self {
        
        switch (from, to) {
            
        case (.tile, .chunk),
             (.chunk, .region):
            
            parent()
            
        case (.tile, .region):
            
            parent().parent()
            
        case (.chunk, .tile),
             (.region, .chunk):
            
            child()
            
        case (.region, .tile):
            
            child().child()
            
        default:
            
            self
        }
    }
    
    func child(_ size: Int = 4) -> Self {
     
        .init(x * size + (isPointy ? 0 : 1),
              y * size + (isPointy ? 0 : 1),
              z * size + (isPointy ? 0 : 1))
    }
    
    func parent(_ size: Int = 4) -> Self {
        
        .init(Int.floorDivision(x + 1, size),
              Int.floorDivision(y + 1, size),
              Int.floorDivision(z + 1, size))
    }
}

// MARK: Sieve

public extension Triangle {
    
    struct Sieve: Deltille.Sieve {
        
        //
        //  v-------v-------v-------v-------v
        //    \ t / t \ t / t \ t / t \ t /
        //      v-------v-------v-------v
        //        \ t / t \ t / t \ t /
        //          v-------v-------v
        //            \ t / t \ t /
        //              v-------v
        //                \ t /
        //                  v
        //
        
        public let origin: Triangle
        public let scale: Scale
        public let tiles: [Triangle]
        public let vertices: [Vertex]
        
        public init(_ origin: Triangle,
                    _ scale: Scale,
                    _ tiles: [Triangle],
                    _ vertices: [Vertex]) {
            
            self.origin = origin
            self.scale = scale
            self.tiles = tiles
            self.vertices = vertices
        }
    }
    
    func sieve(_ scale: Scale) -> Sieve {
        
        var tiles: [Triangle] = []
        var vertices: [Vertex] = []
        
        let size = Self.size(for: scale)
        let columns = size / 2
        let offset = -(size / 3) / 2
        let pointy = isPointy
        
        let origin = transpose(scale,
                               .tile)
        
        for column in 0...columns {
            
            let rows = size - (column * 2)
            
            for row in 0..<rows {
                
                let x = offset + column
                let y = offset + (row / 2)
                let z = -x - y - (row % 2)
                
                let triangle = origin + Triangle(pointy ? x : -x,
                                                 pointy ? y : -z,
                                                 pointy ? z : -y)
                
                tiles.append(triangle)
                
                guard triangle.isPointy == pointy else { continue }
                
                vertices.append(.init(triangle.x,
                                      triangle.y - (pointy ? 0 : 1),
                                      triangle.z + (pointy ? 1 : 0)))
                
                guard row == (rows - 1) else { continue }
                
                vertices.append(.init(triangle.x,
                                      triangle.y + (pointy ? 1 : 0),
                                      triangle.z - (pointy ? 0 : 1)))
                
                guard column == columns else { continue }
                
                vertices.append(.init(triangle.x + (pointy ? 1 : -1),
                                      triangle.y,
                                      triangle.z))
            }
        }

        return .init(self,
                     scale,
                     tiles,
                     vertices)
    }
}

// MARK: Stencil

public extension Triangle {
    
    struct Stencil: Deltille.Stencil {
        
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
        
        public init(v0: Vector,
                    v1: Vector,
                    v2: Vector) {
            
            let v5 = v0.mid(v1)
            let v7 = v0.mid(v2)
            let v13 = v1.mid(v2)
            
            self.v0 = v0
            self.v1 = v1
            self.v2 = v2
            self.v5 = v5
            self.v7 = v7
            self.v13 = v13
            self.v6 = v5.mid(v7)
            self.v9 = v5.mid(v13)
            self.v10 = v7.mid(v13)
            self.v3 = v0.mid(v5)
            self.v4 = v0.mid(v7)
            self.v8 = v1.mid(v5)
            self.v11 = v2.mid(v7)
            self.v12 = v1.mid(v13)
            self.v14 = v2.mid(v13)
        }
        
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
    
    func stencil(_ scale: Scale) -> Stencil {

        let v0 = Vector(vertex(.c0,
                               scale))
        let v1 = Vector(vertex(.c1,
                               scale))
        let v2 = Vector(vertex(.c2,
                               scale))

        return .init(v0: v0,
                     v1: v1,
                     v2: v2)
    }
}

// MARK: Vertex

public extension Triangle {
    
    struct Vertex: Deltille.Vertex {
        
        public let x: Int
        public let y: Int
        public let z: Int
        
        public init(_ x: Int,
                    _ y: Int,
                    _ z: Int) {
            
            self.x = x
            self.y = y
            self.z = z
        }
        
        public var tiles: [Triangle] {
            
            [.init(x, y, z) - (.unitX + .unitZ),
             .init(x, y, z) - .unitX,
             .init(x, y, z) - (.unitX + .unitY),
             .init(x, y, z) - .unitY,
             .init(x, y, z) - (.unitY + .unitZ),
             .init(x, y, z) - .unitZ]
        }
        
        public var vertices: [Self] {
            
            [self + (.unitX - .unitY),
             self + (.unitX - .unitZ),
             self + (.unitY - .unitZ),
             self + (.unitY - .unitX),
             self + (.unitZ - .unitX),
             self + (.unitZ - .unitY)]
        }
        
        public func vector(_ lattice: Double = 1.0) -> Vector {
            
            .init(self,
                  lattice)
        }
    }
}
