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
    
    private let hexagon = Grid.Hexagon(.init(2, -1, -1))
    
    // MARK: Adjacency
    
    func testAdjacentAlongAxisX() throws {
        
        let x = hexagon.adjacent(.x)
        let inverseX = hexagon.adjacent(.inverseX)
        let delta = Coordinate(0, -1, 1)
        
        XCTAssertEqual(x,
                       hexagon.position + delta)
        
        XCTAssertEqual(inverseX,
                       hexagon.position - delta)
    }
    
    func testAdjacentAlongAxisXY() throws {
        
        let y = hexagon.adjacent(.y)
        let inverseY = hexagon.adjacent(.inverseY)
        let delta = Coordinate(1, 0, -1)
        
        XCTAssertEqual(y,
                       hexagon.position + delta)
        
        XCTAssertEqual(inverseY,
                       hexagon.position - delta)
    }
    
    func testAdjacentAlongAxisZ() throws {
        
        let z = hexagon.adjacent(.z)
        let inverseZ = hexagon.adjacent(.inverseZ)
        let delta = Coordinate(-1, 1, 0)
        
        XCTAssertEqual(z,
                       hexagon.position + delta)
        
        XCTAssertEqual(inverseZ,
                       hexagon.position - delta)
    }
    
    // MARK: Vertices
    
    func testVertices() throws {
        
        let c0 = hexagon.corner(.c0)
        let c1 = hexagon.corner(.c1)
        let c2 = hexagon.corner(.c2)
        let c3 = hexagon.corner(.c3)
        let c4 = hexagon.corner(.c4)
        let c5 = hexagon.corner(.c5)
        
        XCTAssertEqual(c0, hexagon.position + .unitX)
        XCTAssertEqual(c1, hexagon.position - .unitZ)
        XCTAssertEqual(c2, hexagon.position + .unitY)
        XCTAssertEqual(c3, hexagon.position - .unitX)
        XCTAssertEqual(c4, hexagon.position + .unitZ)
        XCTAssertEqual(c5, hexagon.position - .unitY)
    }
    
    func testCorners() throws {
        
        let v0 = hexagon.position + .unitX
        let v1 = hexagon.position - .unitZ
        let v2 = hexagon.position + .unitY
        let v3 = hexagon.position - .unitX
        let v4 = hexagon.position + .unitZ
        let v5 = hexagon.position - .unitY
        
        XCTAssertEqual(.c0, hexagon.corner(v0))
        XCTAssertEqual(.c1, hexagon.corner(v1))
        XCTAssertEqual(.c2, hexagon.corner(v2))
        XCTAssertEqual(.c3, hexagon.corner(v3))
        XCTAssertEqual(.c4, hexagon.corner(v4))
        XCTAssertEqual(.c5, hexagon.corner(v5))
        XCTAssertEqual(nil, hexagon.corner(.zero))
    }
}
