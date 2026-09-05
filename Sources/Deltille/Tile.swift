//
//  Tile.swift
//  Deltille
//
//  Created by Zack Brown on 27/11/2024.
//

import Collections
import Euclid

// MARK: Tile

public protocol Tile: Coordinate,
                      Rotatable {
    
    associatedtype C: Corner
    associatedtype D: Tile
    associatedtype E: Edge
    associatedtype SI: Sieve
    associatedtype ST: Stencil
    associatedtype V: Vertex
    
    static func size(for scale: Scale) -> Int
    
    var adjacent: OrderedSet<Self> { get }
    
    var corners: OrderedSet<C> { get }
    var edges: OrderedSet<E> { get }
    
    var vertex: V { get }
    
    init(_ vector: Vector,
         _ lattice: Double)
    
    func contains(_ vector: Vector,
                  _ scale: Scale,
                  _ lattice: Double) -> Bool
    
    func disc(_ radius: Int) -> Set<Self>
    
    func neighbour(_ edge: E) -> Self
    func vertex(_ corner: C,
                _ scale: Scale) -> V
    
    func vertices(_ scale: Scale) -> OrderedSet<V>
    
    func corner(_ vertex: V,
                _ scale: Scale) -> C?
    
    func closest(vertex vector: Vector,
                 _ scale: Scale,
                 _ lattice: Double) -> V
    
    func child(_ size: Int) -> Self
    func parent(_ size: Int) -> Self
    
    func transpose(_ from: Scale,
                   _ to: Scale) -> Self
    
    func sieve(_ scale: Scale) -> SI
    
    func stencil(_ scale: Scale) -> ST
}

public extension Tile {
    
    var adjacent: OrderedSet<Self> {
     
        OrderedSet(edges.map {
            
            neighbour($0)
        })
    }
    
    var corners: OrderedSet<C> {
        
        OrderedSet(C.allCases)
    }
    
    var edges: OrderedSet<E> {
        
        OrderedSet(E.allCases)
    }
    
    var vertex: V {
    
        .init(x, y, z)
    }
}

public extension Tile {
    
    func closest(vertex vector: Vector,
                 _ scale: Scale = .default,
                 _ lattice: Double = 1.0) -> V {
        
        let vertices = vertices(scale)
        
        var distance = Double.greatestFiniteMagnitude
        var closest = vertices.first!
        
        for match in vertices {
            
            let vertex = match.vector(lattice)
            
            let length = (vertex - vector).length
            
            if length < distance {
                
                closest = match
                
                distance = length
            }
        }
        
        return closest
    }
    
    func corner(_ vertex: V,
                _ scale: Scale = .default) -> C? {
        
        let pairs = zip(corners,
                        vertices(scale))
        
        for (corner, match) in pairs {
            
            guard vertex == match else { continue }
            
            return corner
        }
        
        return nil
    }
    
    func vertices(_ scale: Scale = .default) -> OrderedSet<V> {
        
        OrderedSet(corners.map {
            
            vertex($0,
                   scale)
        })
    }
}

public extension Collection where Element: Tile,
                                  Element.V: Vertex {
    
    func bounds(_ lattice: Double = 1.0,
                _ scale: Scale = .default) -> Bounds {
        
        var min = Vector.zero
        var max = Vector.zero
        
        forEach {
            
            for vertex in $0.vertices(scale) {
                
                let position = vertex.vector(lattice)
                
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
                   _ to: Scale) -> Set<Element> {
        Set(map {
            
            $0.transpose(from,
                         to)
        })
    }
    
    func unique(_ from: Scale,
                _ to: Scale) -> Set<Element> {
        
        Set(transpose(from,
                      to))
    }
}
