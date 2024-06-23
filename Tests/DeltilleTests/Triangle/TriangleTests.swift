//
//  TriangleTests.swift
//
//  Created by Zack Brown on 25/05/2024.
//

import Euclid
import XCTest
@testable import Deltille

final class TriangleTests: XCTestCase {
    
    typealias Coordinate = Grid.Coordinate
    
    private let pointyTriangle = Grid.Triangle(4, -2, -2)
    private let flatTriangle = Grid.Triangle(2, -3, -2)
    private let zero = Grid.Triangle(.zero)
    private let x = Grid.Triangle(-.unitX)
    private let y = Grid.Triangle(-.unitY)
    private let z = Grid.Triangle(-.unitZ)
    
    func testUnitTriangleIsPointy() throws {
        
        XCTAssertTrue(pointyTriangle.isPointy)
        XCTAssertFalse(flatTriangle.isPointy)
    }
    
    // MARK: Adjacency
    
    func testPointyAdjacentAlongAxisX() throws {
        
        let adjacent = pointyTriangle.adjacent(.x)
        
        let coordinate = pointyTriangle.position - .unitX
        
        XCTAssertEqual(adjacent, coordinate)
    }
    
    func testPointyAdjacentAlongAxisY() throws {
        
        let adjacent = pointyTriangle.adjacent(.y)
        
        let coordinate = pointyTriangle.position - .unitY
        
        XCTAssertEqual(adjacent, coordinate)
    }
    
    func testPointyAdjacentAlongAxisZ() throws {
        
        let adjacent = pointyTriangle.adjacent(.z)
        
        let coordinate = pointyTriangle.position - .unitZ
        
        XCTAssertEqual(adjacent, coordinate)
    }
    
    func testFlatAdjacentAlongAxisX() throws {
        
        let adjacent = flatTriangle.adjacent(.x)
        
        let coordinate = flatTriangle.position + .unitX
        
        XCTAssertEqual(adjacent, coordinate)
    }
    
    func testFlatAdjacentAlongAxisY() throws {
        
        let adjacent = flatTriangle.adjacent(.y)
        
        let coordinate = flatTriangle.position + .unitY
        
        XCTAssertEqual(adjacent, coordinate)
    }
    
    func testFlatAdjacentAlongAxisZ() throws {
        
        let adjacent = flatTriangle.adjacent(.z)
        
        let coordinate = flatTriangle.position + .unitZ
        
        XCTAssertEqual(adjacent, coordinate)
    }
    
    // MARK: Diagonal
    
    func testPointyDiagonalAlongAxisX() throws {
        
        let diagonal = pointyTriangle.diagonal(.x)
        
        let coordinate = pointyTriangle.position + Coordinate(1, -1, -1)
        
        XCTAssertEqual(diagonal, coordinate)
    }
    
    func testPointyDiagonalAlongAxisY() throws {
        
        let diagonal = pointyTriangle.diagonal(.y)
        
        let coordinate = pointyTriangle.position + Coordinate(-1, 1, -1)
        
        XCTAssertEqual(diagonal, coordinate)
    }
    
    func testPointyDiagonalAlongAxisZ() throws {
        
        let diagonal = pointyTriangle.diagonal(.z)
        
        let coordinate = pointyTriangle.position + Coordinate(-1, -1, 1)
        
        XCTAssertEqual(diagonal, coordinate)
    }
    
    func testFlatDiagonalAlongAxisX() throws {
        
        let diagonal = flatTriangle.diagonal(.x)
        
        let coordinate = flatTriangle.position + Coordinate(-1, 1, 1)
        
        XCTAssertEqual(diagonal, coordinate)
    }
    
    func testFlatDiagonalAlongAxisY() throws {
        
        let diagonal = flatTriangle.diagonal(.y)
        
        let coordinate = flatTriangle.position + Coordinate(1, -1, 1)
        
        XCTAssertEqual(diagonal, coordinate)
    }
    
    func testFlatDiagonalAlongAxisZ() throws {
        
        let diagonal = flatTriangle.diagonal(.z)
        
        let coordinate = flatTriangle.position + Coordinate(1, 1, -1)
        
        XCTAssertEqual(diagonal, coordinate)
    }
    
    // MARK: Touching
    
    func testPointyTouchingAlongAxisX() throws {
        
        let touching = pointyTriangle.touching(.x)
        
        let coordinates = [pointyTriangle.position + Coordinate(1, 0, -1),
                           pointyTriangle.position + Coordinate(1, -1, 0)]
        
        XCTAssertEqual(touching.count, coordinates.count)
        XCTAssertEqual(touching, coordinates)
    }
    
    func testPointyTouchingAlongAxisY() throws {
        
        let touching = pointyTriangle.touching(.y)
        
        let coordinates = [pointyTriangle.position + Coordinate(0, 1, -1),
                           pointyTriangle.position + Coordinate(-1, 1, 0)]
        
        XCTAssertEqual(touching.count, coordinates.count)
        XCTAssertEqual(touching, coordinates)
    }
    
    func testPointyTouchingAlongAxisZ() throws {
        
        let touching = pointyTriangle.touching(.z)
        
        let coordinates = [pointyTriangle.position + Coordinate(0, -1, 1),
                           pointyTriangle.position + Coordinate(-1, 0, 1)]
        
        XCTAssertEqual(touching.count, coordinates.count)
        XCTAssertEqual(touching, coordinates)
    }
    
    func testFlatTouchingAlongAxisX() throws {
        
        let touching = flatTriangle.touching(.x)
        
        let coordinates = [flatTriangle.position + Coordinate(-1, 0, 1),
                           flatTriangle.position + Coordinate(-1, 1, 0)]
        
        XCTAssertEqual(touching.count, coordinates.count)
        XCTAssertEqual(touching, coordinates)
    }
    
    func testFlatTouchingAlongAxisY() throws {
        
        let touching = flatTriangle.touching(.y)
        
        let coordinates = [flatTriangle.position + Coordinate(0, -1, 1),
                           flatTriangle.position + Coordinate(1, -1, 0)]
        
        XCTAssertEqual(touching.count, coordinates.count)
        XCTAssertEqual(touching, coordinates)
    }
    
    func testFlatTouchingAlongAxisZ() throws {
        
        let touching = flatTriangle.touching(.z)
        
        let coordinates = [flatTriangle.position + Coordinate(0, 1, -1),
                           flatTriangle.position + Coordinate(1, 0, -1)]
        
        XCTAssertEqual(touching.count, coordinates.count)
        XCTAssertEqual(touching, coordinates)
    }
    
    // MARK: Vertices
    
    func testPointyVertices() throws {
        
        let c0 = pointyTriangle.corner(.c0)
        let c1 = pointyTriangle.corner(.c1)
        let c2 = pointyTriangle.corner(.c2)
        
        XCTAssertEqual(c0, pointyTriangle.position + .unitX)
        XCTAssertEqual(c1, pointyTriangle.position + .unitY)
        XCTAssertEqual(c2, pointyTriangle.position + .unitZ)
    }
    
    func testFlatVertices() throws {
        
        let c0 = flatTriangle.corner(.c0)
        let c1 = flatTriangle.corner(.c1)
        let c2 = flatTriangle.corner(.c2)
        
        XCTAssertEqual(c0, flatTriangle.position + Coordinate(0, 1, 1))
        XCTAssertEqual(c1, flatTriangle.position + Coordinate(1, 0, 1))
        XCTAssertEqual(c2, flatTriangle.position + Coordinate(1, 1, 0))
    }
    
    func testPointyCorners() throws {
        
        let c0 = Vector(0.0, 0.0, .sqrt3d3)
        let c1 = Vector(0.5, 0.0, -.sqrt3d6)
        let c2 = Vector(-0.5, 0.0, -.sqrt3d6)
        
        XCTAssertEqual(c0, zero.vertex(.c0, .tile))
        XCTAssertEqual(c1, zero.vertex(.c1, .tile))
        XCTAssertEqual(c2, zero.vertex(.c2, .tile))
    }
    
    func testFlatCorners() throws {
        
        let c0 = Vector(0.0, 0.0, -(.sqrt3d2 + .sqrt3d6))
        let c1 = Vector(-0.5, 0.0, -.sqrt3d6)
        let c2 = Vector(0.5, 0.0, -.sqrt3d6)
        
        XCTAssertEqual(c0, x.vertex(.c0, .tile))
        XCTAssertEqual(c1, x.vertex(.c1, .tile))
        XCTAssertEqual(c2, x.vertex(.c2, .tile))
    }
    
    // MARK: Transposing
    
    func testCoordinateRegionToTile() throws {
        
        let regions = [zero,
                       x,
                       y,
                       z].map { $0.transpose(.region,
                                             .tile) }
        
        let triangles: [Grid.Triangle] = [.init(0, 0, 0),
                                          .init(-19, 9, 9),
                                          .init(9, -19, 9),
                                          .init(9, 9, -19)]
        
        XCTAssertEqual(regions,
                       triangles)
    }
    
    func testCoordinateRegionToChunk() throws {
        
        let regions = [zero,
                       x,
                       y,
                       z].map { $0.transpose(.region,
                                             .chunk) }
        
        let triangles: [Grid.Triangle] = [.init(0, 0, 0),
                                          .init(-3, 1, 1),
                                          .init(1, -3, 1),
                                          .init(1, 1, -3)]
        
        XCTAssertEqual(regions,
                       triangles)
    }
    
    func testCoordinateChunkToRegion() throws {
        
        let regions = [Grid.Triangle(0, 0, 0),
                       x,
                       y,
                       z,
                       Grid.Triangle(-3, 1, 1),
                       Grid.Triangle(1, -3, 1),
                       Grid.Triangle(1, 1, -3)].map { $0.transpose(.chunk,
                                                                   .region) }
        
        let triangles = [zero,
                         zero,
                         zero,
                         zero,
                         x,
                         y,
                         z]
        
        XCTAssertEqual(regions, triangles)
        
        XCTAssertEqual(Grid.Triangle.zero,
                       Grid.Triangle(2, -1, -1).transpose(.chunk,
                                                          .region))
        XCTAssertEqual(Grid.Triangle.zero,
                       Grid.Triangle(-1, 2, -1).transpose(.chunk,
                                                          .region))
        XCTAssertEqual(Grid.Triangle.zero,
                       Grid.Triangle(-1, -1, 2).transpose(.chunk,
                                                          .region))
        
        XCTAssertEqual(Grid.Triangle(-1, -1, 1),
                       Grid.Triangle(-2, -2, 3).transpose(.chunk,
                                                          .region))
        XCTAssertEqual(Grid.Triangle(-1, 1, -1),
                       Grid.Triangle(-2, 3, -2).transpose(.chunk,
                                                          .region))
        XCTAssertEqual(Grid.Triangle(1, -1, -1),
                       Grid.Triangle(3, -2, -2).transpose(.chunk,
                                                          .region))
    }
    
    func testCoordinateChunkToTile() throws {
        
        let chunks = [zero,
                      x,
                      y,
                      z].map { $0.transpose(.chunk,
                                            .tile) }
        
        let triangles = [Grid.Triangle(0, 0, 0),
                         Grid.Triangle(-5, 2, 2),
                         Grid.Triangle(2, -5, 2),
                         Grid.Triangle(2, 2, -5)]
        
        XCTAssertEqual(chunks,
                       triangles)
    }
    
    func testCoordinateTileToChunk() throws {
        
        let tiles = [Grid.Triangle(0, 0, 0),
                     x,
                     y,
                     z,
                     Grid.Triangle(-5, 2, 2),
                     Grid.Triangle(2, -5, 2),
                     Grid.Triangle(2, 2, -5)].map { $0.transpose(.tile,
                                                                 .chunk) }
        
        let triangles = [zero,
                         zero,
                         zero,
                         zero,
                         x,
                         y,
                         z]
        
        XCTAssertEqual(tiles, triangles)
        
        XCTAssertEqual(Grid.Triangle.zero,
                       Grid.Triangle(2, -1, -1).transpose(.tile,
                                                          .chunk))
        XCTAssertEqual(Grid.Triangle.zero,
                       Grid.Triangle(-1, 2, -1).transpose(.tile,
                                                          .chunk))
        XCTAssertEqual(Grid.Triangle.zero,
                       Grid.Triangle(-1, -1, 2).transpose(.tile,
                                                          .chunk))
        
        XCTAssertEqual(Grid.Triangle.zero,
                       Grid.Triangle(-2, -2, 4).transpose(.tile,
                                                          .chunk))
        XCTAssertEqual(Grid.Triangle.zero,
                       Grid.Triangle(-2, 4, -2).transpose(.tile,
                                                          .chunk))
        XCTAssertEqual(Grid.Triangle.zero,
                       Grid.Triangle(4, -2, -2).transpose(.tile,
                                                          .chunk))
    }
    
    func testCoordinateTileToRegion() throws {
        
        let tiles = [Grid.Triangle(0, 0, 0),
                     x,
                     y,
                     z,
                     Grid.Triangle(-19, 9, 9),
                     Grid.Triangle(9, -19, 9),
                     Grid.Triangle(9, 9, -19)].map { $0.transpose(.tile,
                                                               .region) }
        
        let triangles = [zero,
                         zero,
                         zero,
                         zero,
                         x,
                         y,
                         z]
        
        XCTAssertEqual(tiles,
                       triangles)
    }
}
