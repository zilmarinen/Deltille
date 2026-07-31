//
//  HexagonVertexTests.swift
//
//  Created by Zack Brown on 09/12/2024.
//

import Euclid
import XCTest
@testable import Deltille

final class HexagonVertexTests: XCTestCase {
    
    typealias Vertex = Hexagon.Vertex
    
    private let vertex = Vertex(2, -2, 1)
    
    // MARK: Tiles
    
    func testVertexTiles() throws {
        
        let tiles: [Hexagon] = [.init(1, -2, 1),
                                .init(2, -3, 1),
                                .init(2, -2, 0)]
        
        XCTAssertEqual(vertex.tiles,
                       tiles)
    }
    
    // MARK: Vertices
    
    func testVertexVertices() throws {
        
        let vertices: [Vertex] = [.init(2, -3, 0),
                                  .init(1, -2, 0),
                                  .init(1, -3, 1)]
        
        XCTAssertEqual(vertex.vertices,
                       vertices)
    }
}
