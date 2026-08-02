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
    
    // MARK: Tiles
    
    func testVertexPositiveTiles() throws {
        
        let vertex = Vertex(-12, 7, 6)
        
        let tiles: [Hexagon] = [.init(-13, 7, 6),
                                .init(-12, 6, 6),
                                .init(-12, 7, 5)]
        
        XCTAssertEqual(vertex.tiles,
                       tiles)
    }
    
    func testVertexNegativeTiles() throws {
        
        let vertex = Vertex(-12, 6, 5)
        
        let tiles: [Hexagon] = [.init(-11, 6, 5),
                                .init(-12, 7, 5),
                                .init(-12, 6, 6)]
        
        XCTAssertEqual(vertex.tiles,
                       tiles)
    }
    
    // MARK: Vertices
    
    func testVertexPositiveVertices() throws {
        
        let vertex = Vertex(-12, 7, 6)
        
        let vertices: [Vertex] = [.init(-12, 6, 5),
                                  .init(-13, 7, 5),
                                  .init(-13, 6, 6)]
        
        XCTAssertEqual(vertex.vertices,
                       vertices)
    }
    
    func testVertexNegativeVertices() throws {
        
        let vertex = Vertex(-12, 6, 5)
        
        let vertices: [Vertex] = [.init(-12, 7, 6),
                                  .init(-11, 6, 6),
                                  .init(-11, 7, 5)]
        
        XCTAssertEqual(vertex.vertices,
                       vertices)
    }
}
