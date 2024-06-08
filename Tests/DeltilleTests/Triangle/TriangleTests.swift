//
//  TriangleTests.swift
//
//  Created by Zack Brown on 25/05/2024.
//

import Euclid
import XCTest
@testable import Deltille

final class TriangleTests: XCTestCase {
    
    typealias Coordinate = Grid.Triangle.Coordinate
    
    let pointyTriangle = Grid.Triangle(.init(4, -2, -2))
    let flatTriangle = Grid.Triangle(.init(2, -3, -2))
    
    func testUnitTriangleIsPointy() throws {
        
        XCTAssertTrue(pointyTriangle.isPointy)
        XCTAssertFalse(flatTriangle.isPointy)
    }
    
    // MARK: Adjacency
    
    func testPointyAdjacentAlongAxisX() throws {
        
        let adjacent = pointyTriangle.adjacent(along: .x)
        
        let coordinate = pointyTriangle.position + Coordinate(-1, 0, 0)
        
        XCTAssertEqual(adjacent, coordinate)
    }
    
    func testPointyAdjacentAlongAxisY() throws {
        
        let adjacent = pointyTriangle.adjacent(along: .y)
        
        let coordinate = pointyTriangle.position + Coordinate(0, -1, 0)
        
        XCTAssertEqual(adjacent, coordinate)
    }
    
    func testPointyAdjacentAlongAxisZ() throws {
        
        let adjacent = pointyTriangle.adjacent(along: .z)
        
        let coordinate = pointyTriangle.position + Coordinate(0, 0, -1)
        
        XCTAssertEqual(adjacent, coordinate)
    }
    
    func testFlatAdjacentAlongAxisX() throws {
        
        let adjacent = flatTriangle.adjacent(along: .x)
        
        let coordinate = flatTriangle.position + Coordinate(1, 0, 0)
        
        XCTAssertEqual(adjacent, coordinate)
    }
    
    func testFlatAdjacentAlongAxisY() throws {
        
        let adjacent = flatTriangle.adjacent(along: .y)
        
        let coordinate = flatTriangle.position + Coordinate(0, 1, 0)
        
        XCTAssertEqual(adjacent, coordinate)
    }
    
    func testFlatAdjacentAlongAxisZ() throws {
        
        let adjacent = flatTriangle.adjacent(along: .z)
        
        let coordinate = flatTriangle.position + Coordinate(0, 0, 1)
        
        XCTAssertEqual(adjacent, coordinate)
    }
    
    // MARK: Diagonal
    
    func testPointyDiagonalAlongAxisX() throws {
        
        let diagonal = pointyTriangle.diagonal(along: .x)
        
        let coordinate = pointyTriangle.position + Coordinate(1, -1, -1)
        
        XCTAssertEqual(diagonal, coordinate)
    }
    
    func testPointyDiagonalAlongAxisY() throws {
        
        let diagonal = pointyTriangle.diagonal(along: .y)
        
        let coordinate = pointyTriangle.position + Coordinate(-1, 1, -1)
        
        XCTAssertEqual(diagonal, coordinate)
    }
    
    func testPointyDiagonalAlongAxisZ() throws {
        
        let diagonal = pointyTriangle.diagonal(along: .z)
        
        let coordinate = pointyTriangle.position + Coordinate(-1, -1, 1)
        
        XCTAssertEqual(diagonal, coordinate)
    }
    
    func testFlatDiagonalAlongAxisX() throws {
        
        let diagonal = flatTriangle.diagonal(along: .x)
        
        let coordinate = flatTriangle.position + Coordinate(-1, 1, 1)
        
        XCTAssertEqual(diagonal, coordinate)
    }
    
    func testFlatDiagonalAlongAxisY() throws {
        
        let diagonal = flatTriangle.diagonal(along: .y)
        
        let coordinate = flatTriangle.position + Coordinate(1, -1, 1)
        
        XCTAssertEqual(diagonal, coordinate)
    }
    
    func testFlatDiagonalAlongAxisZ() throws {
        
        let diagonal = flatTriangle.diagonal(along: .z)
        
        let coordinate = flatTriangle.position + Coordinate(1, 1, -1)
        
        XCTAssertEqual(diagonal, coordinate)
    }
    
    // MARK: Touching
    
    func testPointyTouchingAlongAxisX() throws {
        
        let touching = pointyTriangle.touching(along: .x)
        
        let coordinates = [pointyTriangle.position + Coordinate(1, 0, -1),
                           pointyTriangle.position + Coordinate(1, -1, 0)]
        
        XCTAssertEqual(touching.count, coordinates.count)
        XCTAssertEqual(touching, coordinates)
    }
    
    func testPointyTouchingAlongAxisY() throws {
        
        let touching = pointyTriangle.touching(along: .y)
        
        let coordinates = [pointyTriangle.position + Coordinate(0, 1, -1),
                           pointyTriangle.position + Coordinate(-1, 1, 0)]
        
        XCTAssertEqual(touching.count, coordinates.count)
        XCTAssertEqual(touching, coordinates)
    }
    
    func testPointyTouchingAlongAxisZ() throws {
        
        let touching = pointyTriangle.touching(along: .z)
        
        let coordinates = [pointyTriangle.position + Coordinate(0, -1, 1),
                           pointyTriangle.position + Coordinate(-1, 0, 1)]
        
        XCTAssertEqual(touching.count, coordinates.count)
        XCTAssertEqual(touching, coordinates)
    }
    
    func testFlatTouchingAlongAxisX() throws {
        
        let touching = flatTriangle.touching(along: .x)
        
        let coordinates = [flatTriangle.position + Coordinate(-1, 0, 1),
                           flatTriangle.position + Coordinate(-1, 1, 0)]
        
        XCTAssertEqual(touching.count, coordinates.count)
        XCTAssertEqual(touching, coordinates)
    }
    
    func testFlatTouchingAlongAxisY() throws {
        
        let touching = flatTriangle.touching(along: .y)
        
        let coordinates = [flatTriangle.position + Coordinate(0, -1, 1),
                           flatTriangle.position + Coordinate(1, -1, 0)]
        
        XCTAssertEqual(touching.count, coordinates.count)
        XCTAssertEqual(touching, coordinates)
    }
    
    func testFlatTouchingAlongAxisZ() throws {
        
        let touching = flatTriangle.touching(along: .z)
        
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
        
        XCTAssertEqual(c0, pointyTriangle.position + Coordinate(1, 0, 0))
        XCTAssertEqual(c1, pointyTriangle.position + Coordinate(0, 1, 0))
        XCTAssertEqual(c2, pointyTriangle.position + Coordinate(0, 0, 1))
    }
    
    func testFlatVertices() throws {
        
        let c0 = flatTriangle.corner(.c0)
        let c1 = flatTriangle.corner(.c1)
        let c2 = flatTriangle.corner(.c2)
        
        XCTAssertEqual(c0, flatTriangle.position + Coordinate(0, 1, 1))
        XCTAssertEqual(c1, flatTriangle.position + Coordinate(1, 0, 1))
        XCTAssertEqual(c2, flatTriangle.position + Coordinate(1, 1, 0))
    }
    
    func testPointyAnchorIndices() throws {
        
        let v0 = pointyTriangle.position + Coordinate(1, 0, 0)
        let v1 = pointyTriangle.position + Coordinate(0, 1, 0)
        let v2 = pointyTriangle.position + Coordinate(0, 0, 1)
        
        XCTAssertEqual(.c0, pointyTriangle.index(of: v0))
        XCTAssertEqual(.c1, pointyTriangle.index(of: v1))
        XCTAssertEqual(.c2, pointyTriangle.index(of: v2))
        XCTAssertEqual(nil, pointyTriangle.index(of: .zero))
    }
    
    func testFlatVertexIndices() throws {
        
        let v0 = flatTriangle.position + Coordinate(0, 1, 1)
        let v1 = flatTriangle.position + Coordinate(1, 0, 1)
        let v2 = flatTriangle.position + Coordinate(1, 1, 0)
        
        XCTAssertEqual(.c0, flatTriangle.index(of: v0))
        XCTAssertEqual(.c1, flatTriangle.index(of: v1))
        XCTAssertEqual(.c2, flatTriangle.index(of: v2))
        XCTAssertEqual(nil, flatTriangle.index(of: .zero))
    }
}
