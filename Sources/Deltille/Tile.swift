//
//  Tile.swift
//  Deltille
//
//  Created by Zack Brown on 27/11/2024.
//

import Euclid

// MARK: Tile

public protocol Tile: Coordinate {
    
    associatedtype C: Corner
    associatedtype E: Edge
    associatedtype S: Scale
    associatedtype SI: Sieve
    associatedtype ST: Stencil
    associatedtype V: Vertex
    
    var corners: C.AllCases { get }
    var edges: E.AllCases { get }
    
    var adjacent: [Self] { get }
    
    func contains(_ vector: Vector,
                  _ scale: S) -> Bool
    
    func disc(_ radius: Int) -> [Self]
    
    func neighbour(_ edge: E) -> Self
    func vertex(_ corner: C,
                _ scale: S) -> V
    
    func vertices(_ scale: S) -> [V]
    
    func corner(_ vertex: V,
                _ scale: S) -> C?
    
    func closest(vertex vector: Vector,
                 _ scale: S) -> V
    
    func child(_ size: Int) -> Self
    func parent(_ size: Int) -> Self
    
    func transpose(_ from: S,
                   _ to: S) -> Self
    
    func sieve(_ scale: S) -> SI
    
    func stencil(_ scale: S) -> ST
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
}

public extension Tile {
    
    func closest(vertex vector: Vector,
                 _ scale: S = .default) -> V {
        
        let vertices = vertices(scale)
        
        let vectors = vertices.map {
            
            $0.vector
        }
        
        let index = vectors.firstIndex(closest: vector)
        
        return vertices[index]
    }
    
    func corner(_ vertex: V,
                _ scale: S = .default) -> C? {
        
        guard let index = vertices(scale).firstIndex(of: vertex) else { return nil }
        
        return .init(rawValue: index)
    }
    
    func vertices(_ scale: S = .default) -> [V] {
        
        corners.map {
            
            vertex($0,
                   scale)
        }
    }
}

public extension Array where Element: Tile,
                             Element.V: Vertex {
    
    func bounds(_ scale: Element.S = .default) -> Bounds {
        
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
    
    func transpose(_ from: Element.S,
                   _ to: Element.S) -> Self {
        map {
            
            $0.transpose(from,
                         to)
        }
    }
    
    func unique(_ from: Element.S,
                _ to: Element.S) -> Self {
        
        Array(Set(transpose(from,
                            to)))
    }
}
