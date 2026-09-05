//
//  TriangleVertexTests.swift
//
//  Created by Zack Brown on 25/05/2024.
//

import Collections
import Euclid
import XCTest
@testable import Deltille

final class TriangleVertexTests: XCTestCase {
    
    typealias Vertex = Triangle.Vertex
    
    // MARK: Tiles
    
    func testVertexTiles() throws {
        
        let vertex = Vertex(-7, -8, 16)
        
        let tiles: [Triangle] = [.init(-8, -8, 15),
                                 .init(-8, -8, 16),
                                 .init(-8, -9, 16),
                                 .init(-7, -9, 16),
                                 .init(-7, -9, 15),
                                 .init(-7, -8, 15)]
        
        XCTAssertEqual(vertex.tiles,
                       tiles)
    }
    
    // MARK: Vertices
    
    func testVertexVertices() throws {
        
        let vertex = Vertex(-7, -8, 16)
        
        let vertices: [Vertex] = [.init(-6, -9, 16),
                                  .init(-6, -8, 15),
                                  .init(-7, -7, 15),
                                  .init(-8, -7, 16),
                                  .init(-8, -8, 17),
                                  .init(-7, -9, 17)]
        
        XCTAssertEqual(vertex.vertices,
                       vertices)
    }
}
