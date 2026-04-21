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
    
    func testVertexConversion() throws {
        
        let hexagon0 = Hexagon(Coordinate(3, -1, -2))
        let hexagon1 = Hexagon(Coordinate(2, 0, -2))
        
        let corner0 = hexagon0.vertex(.c2)
        let center0 = Vector(hexagon0.vertex, .tile)
        let target0 = Vector(corner0, .tile)
        let vector0 = center0.lerp(target0, 0.9)
        let result0 = Hexagon(vector0, .tile)
        
        let corner1 = hexagon1.vertex(.c1)
        let center1 = Vector(hexagon1.vertex, .tile)
        let target1 = Vector(corner1, .tile)
        let vector1 = center1.lerp(target1, 0.9)
        let result1 = Hexagon(vector1, .tile)
        
        XCTAssertEqual(hexagon0.vertex, result0.vertex)
        XCTAssertEqual(hexagon1.vertex, result1.vertex)
    }
    
    func testClosestVertex() throws {
        
        let scale = Hexagon.Scale.tile
        let triangle = Hexagon(Coordinate(3, -1, -2))
        
        let center = triangle.position(scale)
        let vertex = triangle.vertex(.c0)
        
        let vector = center.mid(vertex.position(scale))
        
        XCTAssertEqual(triangle.closest(vector,
                                        scale), vertex)
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
        
        let length = scale.length
        let halfLength = length / 2.0
        let sqrt3d2 = .sqrt3d2 * length
        
        let v0 = Vector(0.0,      0.0, length)
        let v1 = Vector(sqrt3d2,  0.0, halfLength)
        let v2 = Vector(sqrt3d2,  0.0, -halfLength)
        let v3 = Vector(0.0,      0.0, -length)
        let v4 = Vector(-sqrt3d2, 0.0, -halfLength)
        let v5 = Vector(-sqrt3d2, 0.0, halfLength)
        
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
        
        let length = scale.length
        let halfLength = length / 2.0
        let sqrt3d2 = .sqrt3d2 * length
        
        let c0 = Coordinate(-1, 1, 0)
        let c1 = Coordinate(1, 0, -1)
        let c2 = Coordinate(0, -1, 1)
        
        let c3 = Coordinate(2, -2, 0)
        let c4 = Coordinate(-2, 0, 2)
        let c5 = Coordinate(0, 2, -2)
        let c6 = Coordinate.zero
        
        let v0 = Vector(sqrt3d2,        0.0, -(length + halfLength))
        let v1 = Vector(sqrt3d2,        0.0, length + halfLength)
        let v2 = Vector(-sqrt3d2 * 2.0, 0.0, 0.0)
        let v3 = Vector(-sqrt3d2 * 2.0, 0.0, (length + halfLength) * 2.0)
        let v4 = Vector(-sqrt3d2 * 2.0, 0.0, -(length + halfLength) * 2.0)
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
