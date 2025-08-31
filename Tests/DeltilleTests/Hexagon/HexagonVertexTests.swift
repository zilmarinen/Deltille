//
//  HexagonVertexTests.swift
//
//  Created by Zack Brown on 09/12/2024.
//

import Euclid
import XCTest
@testable import Deltille

final class HexagonVertexTests: XCTestCase {
    
    typealias Coordinate = Grid.Coordinate
    typealias Hexagon = Grid.Hexagon
    typealias Vertex = Hexagon.Vertex
    
    private let vertex = Vertex(.init(2, -2, 1))
    
    // MARK: Tiles
    
    func testVertexTiles() throws {
        
        let tiles: [Hexagon] = [.init(1, -2, 1),
                                .init(2, -3, 1),
                                .init(2, -2, 0)]
        
        XCTAssertEqual(vertex.tiles, tiles)
    }
    
    // MARK: Vertices
    
    func testVertexVertices() throws {
        
        let vertices: [Vertex] = [.init(2, -3, 0),
                                  .init(1, -2, 0),
                                  .init(1, -3, 1)]
        
        XCTAssertEqual(vertex.vertices, vertices)
    }
    
    // MARK: Vertex to Vector
    
    func testVertexToVectorTile() throws {
        
        XCTAssertTrue(testVertexToVector(.tile))
    }
    
    func testVertexToVectorChunk() throws {
        
        XCTAssertTrue(testVertexToVector(.chunk))
    }
    
    func testVertexToVectorRegion() throws {
        
        XCTAssertTrue(testVertexToVector(.region))
    }
    
    // MARK: Vector to Hexagon
    
    func testVectorToHexagonTiile() throws {
        
        XCTAssertTrue(testVectorToHexagon(.tile))
    }
    
    func testVectorToHexagonChunk() throws {
        
        XCTAssertTrue(testVectorToHexagon(.chunk))
    }
    
    func testVectorToHexagonRegion() throws {
        
        XCTAssertTrue(testVectorToHexagon(.region))
    }
    
    // MARK: Vertices
    
    func testTileVertices() throws {
        
        XCTAssertTrue(testVertices(.tile))
    }
    
    func testChunkVertices() throws {
        
        XCTAssertTrue(testVertices(.chunk))
    }
    
    func testRegionVertices() throws {
        
        XCTAssertTrue(testVertices(.region))
    }
}

extension HexagonVertexTests {
    
    private func testVertices(_ scale: Hexagon.Scale) -> Bool {
        
        let zero = Hexagon.zero
        
        let edgeLength = scale.edgeLength
        let halfEdgeLength = edgeLength / 2.0
        let sqrt3d2 = .sqrt3d2 * edgeLength
        
        let v0 = Vector(0.0,      0.0, edgeLength)
        let v1 = Vector(sqrt3d2,  0.0, halfEdgeLength)
        let v2 = Vector(sqrt3d2,  0.0, -halfEdgeLength)
        let v3 = Vector(0.0,      0.0, -edgeLength)
        let v4 = Vector(-sqrt3d2, 0.0, -halfEdgeLength)
        let v5 = Vector(-sqrt3d2, 0.0, halfEdgeLength)
        
        guard   Vector(zero.vertex,
                       scale).isEqual(to: .zero),
                Vector(zero.vertex(.c0),
                       scale).isEqual(to: v0),
                Vector(zero.vertex(.c1),
                       scale).isEqual(to: v1),
                Vector(zero.vertex(.c2),
                       scale).isEqual(to: v2),
                Vector(zero.vertex(.c3),
                       scale).isEqual(to: v3),
                Vector(zero.vertex(.c4),
                       scale).isEqual(to: v4),
                Vector(zero.vertex(.c5),
                       scale).isEqual(to: v5) else { return false }
        
        return true
    }
    
    private func testVertexToVector(_ scale: Hexagon.Scale) -> Bool {
        
        let hexagons: [Hexagon] = [.zero,
                                   .init(.unitX - .unitZ),
                                   .init(.unitX - .unitY),
                                   .init(-.unitY + .unitZ),
                                   .init(-.unitX + .unitZ),
                                   .init(-.unitX + .unitY),
                                   .init(.unitY - .unitZ)]
        
        let delta = 0.9999
        
        for hexagon in hexagons {
            
            let position = Vector(hexagon.vertex,
                                  scale)
            
            for corner in Hexagon.Corner.allCases {
                
                let vertex = Vector(hexagon.vertex(corner),
                                    scale)
                
                let vector = position.lerp(vertex, delta)
                
                if Hexagon(vector,
                           scale).vertex != hexagon.vertex { return false }
            }
        }
        
        return true
    }
    
    private func testVectorToHexagon(_ scale: Hexagon.Scale) -> Bool {
        
        let edgeLength = scale.edgeLength
        let halfEdgeLength = edgeLength / 2.0
        let sqrt3d2 = .sqrt3d2 * edgeLength
        
        let c0 = Coordinate(-1, 1, 0)
        let c1 = Coordinate(1, 0, -1)
        let c2 = Coordinate(0, -1, 1)
        
        let c3 = Coordinate(2, -2, 0)
        let c4 = Coordinate(-2, 0, 2)
        let c5 = Coordinate(0, 2, -2)
        let c6 = Coordinate.zero
        
        let v0 = Vector(sqrt3d2,        0.0, -(edgeLength + halfEdgeLength))
        let v1 = Vector(sqrt3d2,        0.0, edgeLength + halfEdgeLength)
        let v2 = Vector(-sqrt3d2 * 2.0, 0.0, 0.0)
        let v3 = Vector(-sqrt3d2 * 2.0, 0.0, (edgeLength + halfEdgeLength) * 2.0)
        let v4 = Vector(-sqrt3d2 * 2.0, 0.0, -(edgeLength + halfEdgeLength) * 2.0)
        let v5 = Vector(sqrt3d2 * 4.0,  0.0,  0.0)
        let v6 = Vector.zero
        
        guard   Hexagon(v0, scale).vertex.position == c0,
                Hexagon(v1, scale).vertex.position == c1,
                Hexagon(v2, scale).vertex.position == c2,
                Hexagon(v3, scale).vertex.position == c3,
                Hexagon(v4, scale).vertex.position == c4,
                Hexagon(v5, scale).vertex.position == c5,
                Hexagon(v6, scale).vertex.position == c6 else { return false }
        
        return true
    }
}
