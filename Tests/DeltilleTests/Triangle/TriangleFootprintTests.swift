//
//  TriangleFootprintTests.swift
//
//  Created by Zack Brown on 25/05/2024.
//

import Euclid
import XCTest
@testable import Deltille

final class TriangleFootprintTests: XCTestCase {
    
    typealias Coordinate = Grid.Coordinate
    typealias Triangle = Grid.Triangle
    typealias Footprint = Triangle.Footprint
    
    private let pointyTriangle = Triangle(1, -2, 1)
    private let flatTriangle = Triangle(2, -1, -2)
    
    private let offsets: [Coordinate] = [.init(0, 0, 0),
                                         .init(0, 0, -1),
                                         .init(1, 0, -1),
                                         .init(1, 0, -2),
                                         .init(1, 1, -2),
                                         .init(1, 1, -3),
                                         .init(2, 1, -3)]
    
    // MARK: Translation
    
    func testFootprintTranslationPointy() throws {
        
        let footprint = Footprint(pointyTriangle,
                                  offsets)
        
        let tiles: [Triangle] = [.init(1, -2, 1),
                                 .init(1, -2, 0),
                                 .init(2, -2, 0),
                                 .init(2, -2, -1),
                                 .init(2, -1, -1),
                                 .init(2, -1, -2),
                                 .init(3, -1, -2)]
        
        XCTAssertEqual(footprint.tiles,
                       tiles)
    }
    
    func testFootprintTranslationFlat() throws {
        
        let footprint = Footprint(flatTriangle,
                                  offsets)
        
        let tiles: [Triangle] = [.init(2, -1, -2),
                                 .init(2, -1, -1),
                                 .init(1, -1, -1),
                                 .init(1, -1, 0),
                                 .init(1, -2, 0),
                                 .init(1, -2, 1),
                                 .init(0, -2, 1)]
        
        XCTAssertEqual(footprint.tiles,
                       tiles)
    }
    
    // MARK: Rotation
    
    func testFootprintRotationPointy() throws {
        
        let footprint = Footprint(pointyTriangle,
                                  offsets)
        
        let clockwiseRotation = footprint.rotate(.clockwise)
        let counterClockwiseRotation = footprint.rotate(.counterClockwise)
        
        let clockwiseTiles: [Triangle] = [.init(1, -2, 1),
                                          .init(1, -3, 1),
                                          .init(1, -3, 2),
                                          .init(1, -4, 2),
                                          .init(2, -4, 2),
                                          .init(2, -5, 2),
                                          .init(2, -5, 3)]
        
        let counterClockwiseTiles: [Triangle] = [.init(1, -2, 1),
                                                 .init(0, -2, 1),
                                                 .init(0, -1, 1),
                                                 .init(-1, -1, 1),
                                                 .init(-1, -1, 2),
                                                 .init(-2, -1, 2),
                                                 .init(-2, 0, 2)]
        
        XCTAssertEqual(clockwiseRotation.tiles,
                       clockwiseTiles)
        XCTAssertEqual(counterClockwiseRotation.tiles,
                       counterClockwiseTiles)
    }
    
    func testFootprintRotationFlat() throws {
        
        let footprint = Footprint(flatTriangle,
                                  offsets)
        
        let clockwiseRotation = footprint.rotate(.clockwise)
        let counterClockwiseRotation = footprint.rotate(.counterClockwise)
        
        let clockwiseTiles: [Triangle] = [.init(2, -1, -2),
                                          .init(2, 0, -2),
                                          .init(2, 0, -3),
                                          .init(2, 1, -3),
                                          .init(1, 1, -3),
                                          .init(1, 2, -3),
                                          .init(1, 2, -4)]
        
        let counterClockwiseTiles: [Triangle] = [.init(2, -1, -2),
                                                 .init(3, -1, -2),
                                                 .init(3, -2, -2),
                                                 .init(4, -2, -2),
                                                 .init(4, -2, -3),
                                                 .init(5, -2, -3),
                                                 .init(5, -3, -3)]
        
        XCTAssertEqual(clockwiseRotation.tiles,
                       clockwiseTiles)
        XCTAssertEqual(counterClockwiseRotation.tiles,
                       counterClockwiseTiles)
    }
    
    // MARK: Intersection
    
    func testFootprintIntersection() throws {
        
        let footprint = Footprint(.zero,
                                  [Coordinate.zero])
        
        let lhs = Footprint(pointyTriangle,
                            offsets)
        
        let rhs = Footprint(flatTriangle,
                            offsets)
        
        XCTAssertFalse(footprint.intersects(lhs))
        XCTAssertFalse(footprint.intersects(rhs))
        XCTAssertTrue(lhs.intersects(rhs))
        XCTAssertTrue(rhs.intersects(lhs))
    }
}

