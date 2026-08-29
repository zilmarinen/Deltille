//
//  Tile.swift
//  Deltille
//
//  Created by Zack Brown on 27/11/2024.
//

import Euclid

// MARK: Tile

public protocol Tile: Coordinate,
                      Rotatable {
    
    associatedtype C: Corner
    associatedtype E: Edge
    associatedtype SI: Sieve
    associatedtype ST: Stencil
    associatedtype V: Vertex
    
    static func size(for scale: Scale) -> Int
    
    var corners: C.AllCases { get }
    var edges: E.AllCases { get }
    
    var adjacent: [Self] { get }
    
    var vertex: V { get }
    
    func contains(_ vector: Vector,
                  _ scale: Scale) -> Bool
    
    func disc(_ radius: Int) -> [Self]
    
    func neighbour(_ edge: E) -> Self
    func vertex(_ corner: C,
                _ scale: Scale) -> V
    
    func vertices(_ scale: Scale) -> [V]
    
    func corner(_ vertex: V,
                _ scale: Scale) -> C?
    
    func closest(vertex vector: Vector,
                 _ scale: Scale) -> V
    
    func child(_ size: Int) -> Self
    func parent(_ size: Int) -> Self
    
    func transpose(_ from: Scale,
                   _ to: Scale) -> Self
    
    func sieve(_ scale: Scale) -> SI
    
    func stencil(_ scale: Scale) -> ST
}

public extension Tile {
    
    var adjacent: [Self] {
     
        edges.map {
            
            neighbour($0)
        }
    }
    
    var corners: C.AllCases {
        
        C.allCases
    }
    
    var edges: E.AllCases {
        
        E.allCases
    }
    
    var vertex: V {
    
        .init(x, y, z)
    }
}

public extension Tile {
    
    func closest(vertex vector: Vector,
                 _ scale: Scale = .default) -> V {
        
        let vertices = vertices(scale)
        
        let vectors = vertices.map {
            
            $0.vector
        }
        
        let index = vectors.firstIndex(closest: vector)
        
        return vertices[index]
    }
    
    func corner(_ vertex: V,
                _ scale: Scale = .default) -> C? {
        
        guard let index = vertices(scale).firstIndex(of: vertex) else { return nil }
        
        return .init(rawValue: index)
    }
    
    func vertices(_ scale: Scale = .default) -> [V] {
        
        corners.map {
            
            vertex($0,
                   scale)
        }
    }
}

public extension Collection where Element: Tile,
                                  Element.V: Vertex {
    
    func bounds(_ scale: Scale = .default) -> Bounds {
        
        var min = Vector.zero
        var max = Vector.zero
        
        forEach {
            
            for vertex in $0.vertices(scale) {
                
                let position = vertex.vector
                
                min.x = min.x < position.x ? min.x : position.x
                min.z = min.z < position.z ? min.z : position.z
                max.x = max.x > position.x ? max.x : position.x
                max.z = max.z > position.z ? max.z : position.z
            }
        }
        
        return .init(min: min,
                     max: max)
    }
    
    func transpose(_ from: Scale,
                   _ to: Scale) -> [Element] {
        map {
            
            $0.transpose(from,
                         to)
        }
    }
    
    func unique(_ from: Scale,
                _ to: Scale) -> [Element] {
        
        Array(Set(transpose(from,
                            to)))
    }
}
