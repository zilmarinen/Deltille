//
//  HexagonVertexTests.swift
//
//  Created by Zack Brown on 09/12/2024.
//

import Collections
@testable import Deltille
import Euclid
import Testing

@Suite
struct HexagonVertexTests {
    
    typealias Vertex = Hexagon.Vertex
    
    // MARK: Tiles
    
    @Test
    func vertexPositiveTiles() {
        
        let vertex = Vertex(-12, 7, 6)
        
        let tiles: [Hexagon] = [.init(-13, 7, 6),
                                .init(-12, 6, 6),
                                .init(-12, 7, 5)]
        
        #expect(vertex.tiles == tiles)
    }
    
    @Test
    func vertexNegativeTiles() {
        
        let vertex = Vertex(-12, 6, 5)
        
        let tiles: [Hexagon] = [.init(-11, 6, 5),
                                .init(-12, 7, 5),
                                .init(-12, 6, 6)]
        
        #expect(vertex.tiles == tiles)
    }
    
    // MARK: Vertices
    
    @Test
    func vertexPositiveVertices() {
        
        let vertex = Vertex(-12, 7, 6)
        
        let vertices: [Vertex] = [.init(-12, 6, 5),
                                  .init(-13, 7, 5),
                                  .init(-13, 6, 6)]
        
        #expect(vertex.vertices == vertices)
    }
    
    @Test
    func vertexNegativeVertices() {
        
        let vertex = Vertex(-12, 6, 5)
        
        let vertices: [Vertex] = [.init(-12, 7, 6),
                                  .init(-11, 6, 6),
                                  .init(-11, 7, 5)]
        
        #expect(vertex.vertices == vertices)
    }
}
