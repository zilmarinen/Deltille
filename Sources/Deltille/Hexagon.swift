//
//  Hexagon.swift
//  Deltille
//
//  Created by Zack Brown on 05/06/2024.
//

import Euclid
import Foundation

// MARK: Hexagon

public struct Hexagon: Tile {
    
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
}

public extension Hexagon {
    
    func contains(_ vector: Vector,
                  _ scale: Scale = .default) -> Bool {
        
        let vertices = vertices(scale).map {
            
            $0.vector
        }
        
        var sign = 0.0
        
        for corner in corners {
            
            let c0 = vertices[corner.rawValue]
            let c1 = vertices[(corner.rawValue + 1) % vertices.count]
            
            let dx = c1.x - c0.x
            let dz = c1.z - c0.z
            
            let px = vector.x - c0.x
            let pz = vector.z - c0.z
            
            let cross = dx * pz - dz * px
            
            guard sign * cross >= 0.0 else {
                
                return false
            }
            
            sign = cross
        }
        
        return true
    }
    
    func disc(_ radius: Int) -> [Self] {
        
        var tiles: [Self] = []
        
        for i in -radius...radius {
            
            let start = max(-radius, -i - radius)
            let end = min(radius, -i + radius) + 1
            
            for j in start..<end {
                
                tiles.append(self + .init(i, j, -i - j))
            }
        }
        
        return tiles
    }
    
    func distance(_ other: Self) -> Int {
        
        (abs(x - other.x) +
         abs(y - other.y) +
         abs(z - other.z)) / 2
    }
    
    func neighbour(_ edge: Edge) -> Hexagon {
    
        switch edge {
            
        case .e0:
            
            self + .unitX - .unitZ
            
        case .e1:
            
            self + .unitY - .unitZ
            
        case .e2:
            
            self + .unitY - .unitX
            
        case .e3:
            
            self + .unitZ - .unitX
            
        case .e4:
            
            self + .unitZ - .unitY
            
        case .e5:
            
            self + .unitX - .unitY
        }
    }
    
    func vertex(_ corner: Corner,
                _ scale: Scale = .default) -> Vertex {
        
        let u = scale.size
        let v = u - 1
        let t = scale == .tile ? 0 : 1
        
        let dx = Vertex(u, t, -v)
        let dy = Vertex(-v, u, t)
        let dz = Vertex(t, -v, u)
        
        let origin = Vertex(dx.x * x + dy.x * y + dz.x * z,
                            dx.y * x + dy.y * y + dz.y * z,
                            dx.z * x + dy.z * y + dz.z * z)
        
        switch corner {
            
        case .c0:
            
            return origin + dx
            
        case .c1:
            
            return origin - dz
            
        case .c2:
            
            return origin + dy
            
        case .c3:
            
            return origin - dx
            
        case .c4:
            
            return origin + dz
            
        case .c5:
            
            return origin - dy
        }
    }
}

// MARK: Corner

public extension Hexagon {
    
    enum Corner: Int,
                 Deltille.Corner {
        
        case c0, c1, c2, c3, c4, c5
        
        public var id: String {
            
            "\(rawValue)"
        }
        
        public var corners: [Corner] {
            
            switch self {
                
            case .c0: [.c1, .c5]
            case .c1: [.c2, .c0]
            case .c2: [.c3, .c1]
            case .c3: [.c4, .c2]
            case .c4: [.c5, .c3]
            case .c5: [.c0, .c4]
            }
        }
        
        public var edges: [Edge] {
            
            switch self {
                
            case .c0: [.e0, .e5]
            case .c1: [.e1, .e0]
            case .c2: [.e2, .e1]
            case .c3: [.e3, .e2]
            case .c4: [.e4, .e3]
            case .c5: [.e5, .e4]
            }
        }
    }
}

// MARK: Edge

public extension Hexagon {
    
    enum Edge: Int,
               Deltille.Edge {
        
        case e0, e1, e2, e3, e4, e5
        
        public var id: String {
            
            "\(rawValue)"
        }
        
        public var corners: [Corner] {
            
            switch self {
                
            case .e0: [.c1, .c0]
            case .e1: [.c2, .c1]
            case .e2: [.c3, .c2]
            case .e3: [.c4, .c3]
            case .e4: [.c5, .c4]
            case .e5: [.c0, .c5]
            }
        }
        
        public var edges: [Edge] {
            
            switch self {
                
            case .e0: [.e1, .e5]
            case .e1: [.e2, .e0]
            case .e2: [.e3, .e1]
            case .e3: [.e4, .e2]
            case .e4: [.e5, .e3]
            case .e5: [.e0, .e4]
            }
        }
    }
}

// MARK: Footprint

public extension Hexagon {
    
    struct Footprint: Deltille.Footprint {
        
        public let origin: Hexagon
        public let tiles: [Hexagon]
        
        public init(_ origin: Hexagon,
                    _ tiles: [Hexagon]) {
         
            self.origin = origin
            self.tiles = tiles
        }
        
        public func rotate(_ rotation: Rotation) -> Self {
        
            let hexagons = tiles.map {
                
                let hexagon = $0 - origin
                
                let rotated = hexagon.rotate(rotation)
                
                return rotated + origin
            }
            
            return .init(origin,
                         hexagons)
        }
    }
}

// MARK: Rotation

public extension Hexagon {
    
    struct Rotation: Deltille.Rotation {
        
        public static let turns: Int = 6
        
        public let turns: Int
        
        public init(_ turns: Int) {
            
            self.turns = Self.wrap(turns)
        }
    }
    
    func rotate(_ rotation: Rotation) -> Self {
        
        var rotated = self
                
        for _ in 0..<rotation.turns {
            
            rotated = .init(-rotated.z,
                            -rotated.x,
                            -rotated.y)
        }
        
        return rotated
    }
}

// MARK: Scale

public extension Hexagon {
    
    enum Scale: Int,
                Deltille.Scale {
        
        public static let `default` = Self.tile
        
        case tile = 1
        case chunk = 3
        
        public var id: String {
            
            switch self {
            
            case .tile: "Tile"
            case .chunk: "Chunk"
            }
        }
        
        public var size: Int {
            
            rawValue
        }
    }
    
    func transpose(_ from: Scale,
                   _ to: Scale) -> Self {
        
        switch (from, to) {
            
        case (.tile, .chunk):
            
            parent(to.size - 1)
            
        case (.chunk, .tile):
            
            child(from.size - 1)
            
        default:
            
            self
        }
    }
    
    func child(_ size: Int = 1) -> Self {
        
        let shift = 3 * size + 2
        
        let a = y - z
        let b = z - x
        let c = x - y
        
        return .init(Int(floor(Double(shift * c + b) / 3)),
                     Int(floor(Double(shift * a + c) / 3)),
                     Int(floor(Double(shift * b + a) / 3)))
    }
    
    func parent(_ size: Int = 1) -> Self {
        
        let area = Double(3 * size * size + 3 * size + 1)
        let shift = 3 * size + 2
        
        let a = floor(Double(z + y * shift) / area)
        let b = floor(Double(x + z * shift) / area)
        let c = floor(Double(y + x * shift) / area)
        
        return .init(Int(floor((1 + c - b) / 3)),
                     Int(floor((1 + a - c) / 3)),
                     Int(floor((1 + b - a) / 3)))
    }
}

// MARK: Sieve

public extension Hexagon {
    
    struct Sieve: Deltille.Sieve {
        
        //
        //                   v-------v
        //                 /           \
        //       v-------v       h       v-------v
        //     /           \           /           \
        //   v       h       v-------v       h       v
        //     \           /           \           /
        //       v-------v       h       v-------v
        //     /           \           /           \
        //   v       h       v-------v       h       v
        //     \           /           \           /
        //       v-------v       h       v-------v
        //                 \           /
        //                   v-------v
        //
        
        public let origin: Hexagon
        public let scale: Scale
        public let tiles: [Hexagon]
        public let vertices: [Vertex]
        
        public init(_ origin: Hexagon,
                    _ scale: Scale,
                    _ tiles: [Hexagon],
                    _ vertices: [Vertex]) {
            
            self.origin = origin
            self.scale = scale
            self.tiles = tiles
            self.vertices = vertices
        }
    }
    
    func sieve(_ scale: Scale) -> Sieve {
        
        //TODO: Implement Hexagonal Sieve
        .init(self,
              scale,
              [],
              [])
    }
}

// MARK: Stencil

public extension Hexagon {
    
    struct Stencil: Deltille.Stencil {
        
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
        
        public var center: Vector { (v0 + v1 + v2 + v3 + v4 + v5) / 6.0 }
        
        public var perimeter: [Vector] { [v0, v1, v2, v3, v4, v5] }
        
        // Corners
        public let v0, v1, v2, v3, v4, v5: Vector
        
        public init(v0: Vector,
                    v1: Vector,
                    v2: Vector,
                    v3: Vector,
                    v4: Vector,
                    v5: Vector) {
            
            self.v0 = v0
            self.v1 = v1
            self.v2 = v2
            self.v3 = v3
            self.v4 = v4
            self.v5 = v5
        }
        
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
    
    func stencil(_ scale: Scale) -> Stencil {
        
        return .init(v0: Vector(vertex(.c0,
                                       scale)),
                     v1: Vector(vertex(.c1,
                                       scale)),
                     v2: Vector(vertex(.c2,
                                       scale)),
                     v3: Vector(vertex(.c3,
                                       scale)),
                     v4: Vector(vertex(.c4,
                                       scale)),
                     v5: Vector(vertex(.c5,
                                       scale)))
    }
}



// MARK: Vertex

public extension Hexagon {
    
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
        
        public var tiles: [Hexagon] {
            
            [.init(x, y, z) + (equalToOne ? -.unitX : .unitX),
             .init(x, y, z) + (equalToOne ? -.unitY : .unitY),
             .init(x, y, z) + (equalToOne ? -.unitZ : .unitZ)]
        }
        
        public var vertices: [Self] {
            
            [self + ((.unitY + .unitZ) * (equalToOne ? -1 : 1)),
             self + ((.unitX + .unitZ) * (equalToOne ? -1 : 1)),
             self + ((.unitX + .unitY) * (equalToOne ? -1 : 1))]
        }
    }
}
