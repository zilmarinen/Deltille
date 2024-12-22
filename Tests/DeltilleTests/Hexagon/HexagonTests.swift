//
//  HexagonTests.swift
//
//  Created by Zack Brown on 12/06/2024.
//

import Euclid
import XCTest
@testable import Deltille

final class HexagonTests: XCTestCase {
    
    typealias Coordinate = Grid.Coordinate
    typealias Hexagon = Grid.Hexagon
    typealias Vertex = Hexagon.Vertex
    
    private let hexagon = Hexagon(.init(2, -1, -1))
    
    // MARK: Neighbours / Adjacency / Perimeter
    
    func testNeighbours() throws {
        
        let tiles: [Hexagon] = [.init(3, -1, -2),
                                .init(2, 0, -2),
                                .init(1, 0, -1),
                                .init(1, -1, 0),
                                .init(2, -2, 0),
                                .init(3, -2, -1)]
        
        let neighbours = hexagon.edges.map { hexagon.neighbour($0) }
        
        XCTAssertEqual(neighbours, tiles)
        XCTAssertEqual(hexagon.adjacent, tiles)
        XCTAssertEqual(hexagon.perimeter, tiles)
    }
    
    // MARK: Vertices / Corners
    
    func testVertices() throws {
        
        let vertices: [Vertex] = [.init(3, -1, -1),
                                  .init(2, -1, -2),
                                  .init(2, 0, -1),
                                  .init(1, -1, -1),
                                  .init(2, -1, 0),
                                  .init(2, -2, -1)]
        
        let hexagonCorners = vertices.map { hexagon.corner($0) }
        let hexagonVertices = hexagon.corners.map { hexagon.vertex($0) }
        
        XCTAssertEqual(hexagonCorners, hexagon.corners)
        XCTAssertEqual(hexagonVertices, vertices)
        XCTAssertEqual(hexagonVertices, hexagon.vertices)
        XCTAssertEqual(nil, hexagon.corner(.zero))
    }
}
