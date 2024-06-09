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
        
        let adjacent = pointyTriangle.adjacent(.x)
        
        let coordinate = pointyTriangle.position + Coordinate(-1, 0, 0)
        
        XCTAssertEqual(adjacent, coordinate)
    }
    
    func testPointyAdjacentAlongAxisY() throws {
        
        let adjacent = pointyTriangle.adjacent(.y)
        
        let coordinate = pointyTriangle.position + Coordinate(0, -1, 0)
        
        XCTAssertEqual(adjacent, coordinate)
    }
    
    func testPointyAdjacentAlongAxisZ() throws {
        
        let adjacent = pointyTriangle.adjacent(.z)
        
        let coordinate = pointyTriangle.position + Coordinate(0, 0, -1)
        
        XCTAssertEqual(adjacent, coordinate)
    }
    
    func testFlatAdjacentAlongAxisX() throws {
        
        let adjacent = flatTriangle.adjacent(.x)
        
        let coordinate = flatTriangle.position + Coordinate(1, 0, 0)
        
        XCTAssertEqual(adjacent, coordinate)
    }
    
    func testFlatAdjacentAlongAxisY() throws {
        
        let adjacent = flatTriangle.adjacent(.y)
        
        let coordinate = flatTriangle.position + Coordinate(0, 1, 0)
        
        XCTAssertEqual(adjacent, coordinate)
    }
    
    func testFlatAdjacentAlongAxisZ() throws {
        
        let adjacent = flatTriangle.adjacent(.z)
        
        let coordinate = flatTriangle.position + Coordinate(0, 0, 1)
        
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
        
        XCTAssertEqual(.c0, pointyTriangle.corner(v0))
        XCTAssertEqual(.c1, pointyTriangle.corner(v1))
        XCTAssertEqual(.c2, pointyTriangle.corner(v2))
        XCTAssertEqual(nil, pointyTriangle.corner(.zero))
    }
    
    func testFlatVertexIndices() throws {
        
        let v0 = flatTriangle.position + Coordinate(0, 1, 1)
        let v1 = flatTriangle.position + Coordinate(1, 0, 1)
        let v2 = flatTriangle.position + Coordinate(1, 1, 0)
        
        XCTAssertEqual(.c0, flatTriangle.corner(v0))
        XCTAssertEqual(.c1, flatTriangle.corner(v1))
        XCTAssertEqual(.c2, flatTriangle.corner(v2))
        XCTAssertEqual(nil, flatTriangle.corner(.zero))
    }
}
