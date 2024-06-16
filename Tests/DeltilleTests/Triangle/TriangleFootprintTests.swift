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
    typealias Footprint = Grid.Triangle.Footprint
    
    private let coordinates: [Coordinate] = [.init(0, 0, 0),
                                             .init(-1, 0, 0),
                                             .init(-1, 0, 1),
                                             .init(-2, 0, 1),
                                             .init(-2, 1, 1),
                                             .init(-3, 1, 1),
                                             .init(-3, 2, 1)]
    
    func testFootprintCanopy() throws {
        
        let canopy = Grid.Triangle.Canopy.escher
        
        let footprint = Footprint(.zero,
                                  canopy.coordinates)
        
        XCTAssertEqual(footprint.coordinates,
                       canopy.coordinates)
    }
    
    func testFootprintSeptomino() throws {
        
        let septomino = Grid.Triangle.Septomino.asterope
        
        let footprint = Footprint(.zero,
                                  septomino.coordinates)
        
        XCTAssertEqual(footprint.coordinates,
                       septomino.coordinates)
    }
    
    func testPointyFootprintTranslation() throws {
        
        let footprint = Footprint(.init(1, -2, 1),
                                  coordinates)
        
        let translatedCoordinates: [Coordinate] = [.init(1, -2, 1),
                                                   .init(0, -2, 1),
                                                   .init(0, -2, 2),
                                                   .init(-1, -2, 2),
                                                   .init(-1, -1, 2),
                                                   .init(-2, -1, 2),
                                                   .init(-2, 0, 2)]
        
        XCTAssertEqual(footprint.coordinates,
                       translatedCoordinates)
    }
    
    func testFlatFootprintTranslation() throws {
        
        let footprint = Footprint(.init(2, -1, -2),
                                  coordinates)
        
        let translatedCoordinates: [Coordinate] = [.init(2, -1, -2),
                                                   .init(3, -1, -2),
                                                   .init(3, -1, -3),
                                                   .init(4, -1, -3),
                                                   .init(4, -2, -3),
                                                   .init(5, -2, -3),
                                                   .init(5, -3, -3)]
        
        XCTAssertEqual(footprint.coordinates,
                       translatedCoordinates)
    }
    
    func testPointyFootprintRotation() throws {
        
        let footprint = Footprint(.zero,
                                  coordinates)
        
        let leftRotation = footprint.rotate(.clockwise)
        let rightRotation = footprint.rotate(.counterClockwise)
        let inverseRotation = leftRotation.rotate(.clockwise)
        
        let leftCoordinates: [Coordinate] = [.init(0, 0, 0),
                                             .init(0, -1, 0),
                                             .init(1, -1, 0),
                                             .init(1, -2, 0),
                                             .init(1, -2, 1),
                                             .init(1, -3, 1),
                                             .init(1, -3, 2)]
        
        XCTAssertEqual(leftRotation.coordinates, leftCoordinates)
        
        let rightCoordinates: [Coordinate] = [.init(0, 0, 0),
                                              .init(0, 0, -1),
                                              .init(0, 1, -1),
                                              .init(0, 1, -2),
                                              .init(1, 1, -2),
                                              .init(1, 1, -3),
                                              .init(2, 1, -3)]
        
        XCTAssertEqual(rightRotation.coordinates,
                       rightCoordinates)
        XCTAssertEqual(inverseRotation.coordinates,
                       rightCoordinates)
    }
    
    func testPointyFootprintTranslationAndRotation() throws {
        
        let footprint = Footprint(.init(1, -2, 1),
                                  coordinates)
        
        let rotatedFootprint = footprint.rotate(.counterClockwise)
        
        let translatedAndRotatedCoordinates: [Coordinate] = [.init(1, -2, 1),
                                                             .init(1, -2, 0),
                                                             .init(1, -1, 0),
                                                             .init(1, -1, -1),
                                                             .init(2, -1, -1),
                                                             .init(2, -1, -2),
                                                             .init(3, -1, -2)]
        
        XCTAssertEqual(rotatedFootprint.coordinates,
                       translatedAndRotatedCoordinates)
    }
    
    func testFlatFootprintTranslationAndRotation() throws {
        
        let footprint = Footprint(.init(2, -1, -2),
                                  coordinates)
        
        let rotatedFootprint = footprint.rotate(.counterClockwise)
        
        let translatedAndRotatedCoordinates: [Coordinate] = [.init(2, -1, -2),
                                                             .init(2, -1, -1),
                                                             .init(2, -2, -1),
                                                             .init(2, -2, 0),
                                                             .init(1, -2, 0),
                                                             .init(1, -2, 1),
                                                             .init(0, -2, 1)]
        
        XCTAssertEqual(rotatedFootprint.coordinates,
                       translatedAndRotatedCoordinates)
    }
    
    func testFootprintIntersection() throws {
        
        let footprint = Footprint(.zero,
                                  coordinates)
        
        let lhs = Footprint(.init(2, -2, 0),
                            coordinates).rotate(.clockwise)
        
        let rhs = Footprint(.init(2, -2, 0),
                            coordinates)
        
        XCTAssertFalse(footprint.intersects(lhs))
        XCTAssertTrue(footprint.intersects(rhs))
    }
}

