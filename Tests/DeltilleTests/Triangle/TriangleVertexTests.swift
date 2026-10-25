//
//  TriangleVertexTests.swift
//
//  Created by Zack Brown on 25/05/2024.
//

import Collections
@testable import Deltille
import Euclid
import Testing

@Suite
struct TriangleVertexTests {
    
    typealias Vertex = Triangle.Vertex
    
    // MARK: Tiles
    
    @Test
    func vertexTiles() {
        
        let vertex = Vertex(-7, -8, 16)
        
        let tiles: [Triangle] = [.init(-8, -8, 15),
                                 .init(-8, -8, 16),
                                 .init(-8, -9, 16),
                                 .init(-7, -9, 16),
                                 .init(-7, -9, 15),
                                 .init(-7, -8, 15)]
        
        #expect(vertex.tiles == tiles)
    }
    
    // MARK: Vertices
    
    @Test
    func vertexVertices() {
        
        let vertex = Vertex(-7, -8, 16)
        
        let vertices: [Vertex] = [.init(-6, -9, 16),
                                  .init(-6, -8, 15),
                                  .init(-7, -7, 15),
                                  .init(-8, -7, 16),
                                  .init(-8, -8, 17),
                                  .init(-7, -9, 17)]
        
        #expect(vertex.vertices == vertices)
    }
}
