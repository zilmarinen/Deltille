//
//  HexagonTests.swift
//
//  Created by Zack Brown on 12/06/2024.
//

import Euclid
import XCTest
@testable import Deltille

final class HexagonTests: XCTestCase {
    
    typealias Vertex = Hexagon.Vertex
    
    private let hexagon = Hexagon(2, -1, -1)
    private let unitHexagon = Hexagon(Vertex.zero)
    private let x = Hexagon(1, -1, 0)
    private let y = Hexagon(0, 1, -1)
    private let z = Hexagon(-1, 0, 1)
    
    // MARK: Edges
    
    func testEdges() throws {
        
        for edge in hexagon.edges {
            
            let adjacent = hexagon.neighbour(edge)
            
            let vertices = Set(edge.corners.map { hexagon.vertex($0) })
            
            XCTAssertTrue(vertices.isSubset(of: adjacent.vertices))
        }
    }
    
    // MARK: Distance
    
    func testDistance() throws {
        
        XCTAssertEqual(hexagon.distance(hexagon), 0)
        XCTAssertEqual(hexagon.distance(.zero), 2)
    }
    
    func testDisc() throws {
        
        XCTAssertEqual(hexagon.disc(0).count, 1)
        XCTAssertEqual(hexagon.disc(1).count, 7)
        XCTAssertEqual(hexagon.disc(2).count, 19)
        XCTAssertEqual(hexagon.disc(3).count, 37)
    }
    
    // MARK: Contains Vector
    
    func testHexagonContainsVector() throws {
        
        XCTAssertTrue(hexagon.contains(hexagon.position(.chunk),
                                       .chunk))
        XCTAssertTrue(hexagon.contains(hexagon.vertex(.c0).position(.chunk),
                                       .chunk))
        XCTAssertTrue(hexagon.contains(hexagon.vertex(.c1).position(.chunk),
                                       .chunk))
        XCTAssertTrue(hexagon.contains(hexagon.vertex(.c1).position(.chunk),
                                       .chunk))
        XCTAssertTrue(hexagon.contains(hexagon.vertex(.c2).position(.chunk),
                                       .chunk))
        XCTAssertTrue(hexagon.contains(hexagon.vertex(.c3).position(.chunk),
                                       .chunk))
        XCTAssertTrue(hexagon.contains(hexagon.vertex(.c4).position(.chunk),
                                       .chunk))
        
        XCTAssertFalse(hexagon.contains(.zero, .chunk))
    }
    
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
    
    // MARK: Transposing
    
    func testTransposeRegionToChunk() throws {
        
        let regions = [unitHexagon,
                       x,
                       y,
                       z]
            
        let transposed = regions.map {
            
            $0.transpose(.region,
                         .chunk)
        }
        
        let chunks: [Hexagon] = [.zero,
                                 .init(2, -3, 1),
                                 .init(1, 2, -3),
                                 .init(-3, 1, 2)]
        
        XCTAssertEqual(transposed,
                       chunks)
    }
    
    func testTransposeChunkToRegion() throws {
        
        let chunks: [Hexagon] = [.zero,
                                 x,
                                 y,
                                 z,
                                 .init(2, -3, 1),
                                 .init(1, 2, -3),
                                 .init(-3, 1, 2)]
            
        let transposed = chunks.map {
            
            $0.transpose(.chunk,
                         .region)
        }
        
        let regions = [unitHexagon,
                       unitHexagon,
                       unitHexagon,
                       unitHexagon,
                       x,
                       y,
                       z]
        
        XCTAssertEqual(transposed,
                       regions)
    }
}
