//
//  TriangleVertexTests.swift
//
//  Created by Zack Brown on 25/05/2024.
//

import Euclid
import XCTest
@testable import Deltille

final class TriangleVertexTests: XCTestCase {
    
    typealias Vertex = Triangle.Vertex
    
    private let vertex = Vertex(.init(3, -1, -1))
    
    // MARK: Tiles
    
    func testVertexTiles() throws {
        
        let tiles: [Triangle] = [.init(2, -1, -1),
                                 .init(2, -2, -1),
                                 .init(3, -2, -1),
                                 .init(3, -2, -2),
                                 .init(3, -1, -2),
                                 .init(2, -1, -2)]
        
        XCTAssertEqual(vertex.tiles,
                       tiles)
    }
    
    // MARK: Vertices
    
    func testVertexVertices() throws {
        
        let vertices: [Vertex] = [.init(2, 0, -1),
                                  .init(2, -1, 0),
                                  .init(3, -2, 0),
                                  .init(4, -2, -1),
                                  .init(4, -1, -2),
                                  .init(3, 0, -2)]
        
        XCTAssertEqual(vertex.vertices,
                       vertices)
    }
}
