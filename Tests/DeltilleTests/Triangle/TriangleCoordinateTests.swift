//
//  CoordinateTests.swift
//
//  Created by Zack Brown on 25/05/2024.
//

import Euclid
import XCTest
@testable import Deltille

final class CoordinateTests: XCTestCase {
    
    typealias Coordinate = Grid.Triangle.Coordinate
    
    let zero = Grid.Triangle(.zero)
    let x = Grid.Triangle(-.unitX)
    let y = Grid.Triangle(-.unitY)
    let z = Grid.Triangle(-.unitZ)
    
    func testCoordinateRegionToTile() throws {
        
        let regions = [zero,
                       x,
                       y,
                       z].map { $0.position.transpose(from: .region,
                                                      to: .tile) }
        
        let coordinates = [Coordinate(0, 0, 0),
                           Coordinate(-19, 9, 9),
                           Coordinate(9, -19, 9),
                           Coordinate(9, 9, -19)]
        
        XCTAssertEqual(regions,
                       coordinates)
    }
    
    func testCoordinateRegionToChunk() throws {
        
        let regions = [zero,
                       x,
                       y,
                       z].map { $0.position.transpose(from: .region,
                                                      to: .chunk) }
        
        let coordinates = [Coordinate(0, 0, 0),
                           Coordinate(-3, 1, 1),
                           Coordinate(1, -3, 1),
                           Coordinate(1, 1, -3)]
        
        XCTAssertEqual(regions,
                       coordinates)
    }
    
    func testCoordinateChunkToRegion() throws {
        
        let regions = [Coordinate(0, 0, 0),
                       x.position,
                       y.position,
                       z.position,
                       Coordinate(-3, 1, 1),
                       Coordinate(1, -3, 1),
                       Coordinate(1, 1, -3)].map { $0.transpose(from: .chunk,
                                                                to: .region) }
        
        let coordinates = [zero,
                           zero,
                           zero,
                           zero,
                           x,
                           y,
                           z].map { $0.position }
        
        XCTAssertEqual(regions, coordinates)
        
        XCTAssertEqual(Coordinate.zero,
                       Coordinate(2, -1, -1).transpose(from: .chunk,
                                                       to: .region))
        XCTAssertEqual(Coordinate.zero,
                       Coordinate(-1, 2, -1).transpose(from: .chunk,
                                                       to: .region))
        XCTAssertEqual(Coordinate.zero,
                       Coordinate(-1, -1, 2).transpose(from: .chunk,
                                                       to: .region))
        
        XCTAssertEqual(Coordinate(-1, -1, 1),
                       Coordinate(-2, -2, 3).transpose(from: .chunk,
                                                       to: .region))
        XCTAssertEqual(Coordinate(-1, 1, -1),
                       Coordinate(-2, 3, -2).transpose(from: .chunk,
                                                       to: .region))
        XCTAssertEqual(Coordinate(1, -1, -1),
                       Coordinate(3, -2, -2).transpose(from: .chunk,
                                                       to: .region))
    }
    
    func testCoordinateChunkToTile() throws {
        
        let chunks = [zero,
                      x,
                      y,
                      z].map { $0.position.transpose(from: .chunk,
                                                     to: .tile) }
        
        let coordinates = [Coordinate(0, 0, 0),
                           Coordinate(-5, 2, 2),
                           Coordinate(2, -5, 2),
                           Coordinate(2, 2, -5)]
        
        XCTAssertEqual(chunks,
                       coordinates)
    }
    
    func testCoordinateTileToChunk() throws {
        
        let tiles = [Coordinate(0, 0, 0),
                     x.position,
                     y.position,
                     z.position,
                     Coordinate(-5, 2, 2),
                     Coordinate(2, -5, 2),
                     Coordinate(2, 2, -5)].map { $0.transpose(from: .tile,
                                                              to: .chunk) }
        
        let coordinates = [zero,
                           zero,
                           zero,
                           zero,
                           x,
                           y,
                           z].map { $0.position }
        
        XCTAssertEqual(tiles, coordinates)
        
        XCTAssertEqual(Coordinate.zero,
                       Coordinate(2, -1, -1).transpose(from: .tile,
                                                       to: .chunk))
        XCTAssertEqual(Coordinate.zero,
                       Coordinate(-1, 2, -1).transpose(from: .tile,
                                                       to: .chunk))
        XCTAssertEqual(Coordinate.zero,
                       Coordinate(-1, -1, 2).transpose(from: .tile,
                                                       to: .chunk))
        
        XCTAssertEqual(Coordinate.zero,
                       Coordinate(-2, -2, 4).transpose(from: .tile,
                                                       to: .chunk))
        XCTAssertEqual(Coordinate.zero,
                       Coordinate(-2, 4, -2).transpose(from: .tile,
                                                       to: .chunk))
        XCTAssertEqual(Coordinate.zero,
                       Coordinate(4, -2, -2).transpose(from: .tile,
                                                       to: .chunk))
    }
    
    func testCoordinateTileToRegion() throws {
        
        let tiles = [Coordinate(0, 0, 0),
                     x.position,
                     y.position,
                     z.position,
                     Coordinate(-19, 9, 9),
                     Coordinate(9, -19, 9),
                     Coordinate(9, 9, -19)].map { $0.transpose(from: .tile,
                                                               to: .region) }
        
        let coordinates = [zero,
                           zero,
                           zero,
                           zero,
                           x,
                           y,
                           z].map { $0.position }
        
        XCTAssertEqual(tiles,
                       coordinates)
    }
    
    // MARK: Coordinate to Vector
    
    func testSierpinskiCoordinateToVector() throws {
        
        XCTAssertTrue(testCoordinateToVector(at: .sierpinski))
    }
    
    func testTileCoordinateToVector() throws {
        
        XCTAssertTrue(testCoordinateToVector(at: .tile))
    }
    
    func testChunkCoordinateToVector() throws {
        
        XCTAssertTrue(testCoordinateToVector(at: .chunk))
    }
    
    func testRegionCoordinateToVector() throws {
        
        XCTAssertTrue(testCoordinateToVector(at: .region))
    }
    
    // MARK: Vector to Coordinate
    
    func testSierpinskiVectorToCoordinate() throws {
        
        XCTAssertTrue(testVectorToCoordinate(at: .sierpinski))
    }
    
    func testTileVectorToCoordinate() throws {
        
        XCTAssertTrue(testVectorToCoordinate(at: .tile))
    }
    
    func testChunkVectorToCoordinate() throws {
        
        XCTAssertTrue(testVectorToCoordinate(at: .chunk))
    }
    
    func testRegionVectorToCoordinate() throws {
        
        XCTAssertTrue(testVectorToCoordinate(at: .region))
    }
    
    // MARK: Vertices
    
    func testSierpinskiVertices() throws {
        
        XCTAssertTrue(testVertices(at: .sierpinski))
    }
    
    func testTileVertices() throws {
        
        XCTAssertTrue(testVertices(at: .tile))
    }
    
    func testChunkVertices() throws {
        
        XCTAssertTrue(testVertices(at: .chunk))
    }
    
    func testRegionVertices() throws {
        
        XCTAssertTrue(testVertices(at: .region))
    }
}

extension CoordinateTests {
    
    private func testVertices(at scale: Grid.Triangle.Scale) -> Bool {
        
        let edgeLength = scale.edgeLength
        let halfEdgeLength = edgeLength / 2.0
        let sqrt3d6 = .sqrt3d6 * edgeLength
        let sqrt3d3 = .sqrt3d3 * edgeLength
        
        let v0 = Vector(0.0, 0.0, sqrt3d6 * 2.0)
        let v1 = Vector(halfEdgeLength, 0.0, -sqrt3d6)
        let v2 = Vector(-halfEdgeLength, 0.0, -sqrt3d6)
        
        let v3 = Vector(0.0, 0.0, -sqrt3d3 * 2.0)
        let v4 = Vector(-edgeLength, 0.0, sqrt3d3)
        let v5 = Vector(edgeLength, 0.0, sqrt3d3)
        
        let px = Vector(0.0, 0.0, -sqrt3d3)
        let py = Vector(-halfEdgeLength, 0.0, sqrt3d6)
        let pz = Vector(halfEdgeLength, 0.0, sqrt3d6)
        
        guard   Vector(zero.position, 
                       scale).isEqual(to: .zero),
                Vector(zero.corner(.c0), 
                       scale).isEqual(to: v0),
                Vector(zero.corner(.c1), 
                       scale).isEqual(to: v1),
                Vector(zero.corner(.c2), 
                       scale).isEqual(to: v2),
              
                Vector(x.position, 
                       scale).isEqual(to: px),
                Vector(x.corner(.c0), 
                       scale).isEqual(to: v3),
                Vector(x.corner(.c1), 
                       scale).isEqual(to: v2),
                Vector(x.corner(.c2), 
                       scale).isEqual(to: v1),
        
                Vector(y.position, 
                       scale).isEqual(to: py),
                Vector(y.corner(.c0), 
                       scale).isEqual(to: v2),
                Vector(y.corner(.c1), 
                       scale).isEqual(to: v4),
                Vector(y.corner(.c2), 
                       scale).isEqual(to: v0),
        
                Vector(z.position, 
                       scale).isEqual(to: pz),
                Vector(z.corner(.c0), 
                       scale).isEqual(to: v1),
                Vector(z.corner(.c1), 
                       scale).isEqual(to: v0),
                Vector(z.corner(.c2), 
                       scale).isEqual(to: v5) else { return false }
        
        return true
    }
    
    private func testCoordinateToVector(at scale: Grid.Triangle.Scale) -> Bool {
        
        let triangles = [zero,
                         x,
                         y,
                         z]
        
        //TODO: resolve accuracy of coordinate / vector conversion
        let delta = 0.9
        
        for triangle in triangles {
            
            let position = Vector(triangle.position,
                                  scale)
            
            for corner in Grid.Triangle.Corner.allCases {
                
                let vertex = Vector(triangle.corner(corner),
                                    scale)
                
                let vector = position.lerp(vertex, delta)
                
                if Coordinate(vector,
                              scale) != triangle.position { return false }
            }
        }
        
        return true
    }
    
    private func testVectorToCoordinate(at scale: Grid.Triangle.Scale) -> Bool {
        
        let edgeLength = scale.edgeLength
        
        let c0 = Coordinate(-2, -2, 4)
        let c1 = Coordinate(-2, 4, -2)
        let c2 = Coordinate(4, -2, -2)
        
        let c3 = Coordinate(-3, -3, 6)
        let c4 = Coordinate(-3, 6, -3)
        let c5 = Coordinate(6, -3, -3)
        
        let v0 = Vector(-edgeLength * 3.0, 0.0, -.sqrt3 * edgeLength)
        let v1 = Vector(edgeLength * 3.0, 0.0, -.sqrt3 * edgeLength)
        let v2 = Vector(0.0, 0.0, .sqrt3 * edgeLength * 2.0)
        let v3 = Vector(-edgeLength * 4.5, 0.0, -.sqrt3 * edgeLength * 1.5)
        let v4 = Vector(edgeLength * 4.5, 0.0, -.sqrt3 * edgeLength * 1.5)
        let v5 = Vector(0.0, 0.0, .sqrt3 * edgeLength * 3.0)
        
        guard   Coordinate(v0, scale) == c0,
                Coordinate(v1, scale) == c1,
                Coordinate(v2, scale) == c2,
        
                Coordinate(v3, scale) == c3,
                Coordinate(v4, scale) == c4,
                Coordinate(v5, scale) == c5 else { return false }
        
        return true
    }
}
