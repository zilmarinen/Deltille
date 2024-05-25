//
//  FootprintTests.swift
//
//  Created by Zack Brown on 25/05/2024.
//

import Euclid
import XCTest
@testable import Deltille

final class FootprintTests: XCTestCase {
    
    let coordinates = [Coordinate(0, 0, 0),
                       Coordinate(-1, 0, 0),
                       Coordinate(-1, 0, 1),
                       Coordinate(-2, 0, 1),
                       Coordinate(-2, 1, 1),
                       Coordinate(-3, 1, 1),
                       Coordinate(-3, 2, 1)]
    
    func testFootprintCanopy() throws {
        
        let canopy = Grid.Canopy.escher
        
        let footprint = Footprint(origin: .zero,
                                  coordinates: canopy.coordinates)
        
        XCTAssertEqual(footprint.coordinates,
                       canopy.coordinates)
    }
    
    func testFootprintSeptomino() throws {
        
        let septomino = Grid.Septomino.asterope
        
        let footprint = Footprint(origin: .zero,
                                  coordinates: septomino.coordinates)
        
        XCTAssertEqual(footprint.coordinates,
                       septomino.coordinates)
    }
    
    func testPointyFootprintTranslation() throws {
        
        let footprint = Footprint(origin: .init(Coordinate(1, -2, 1)),
                                  coordinates: coordinates)
        
        let translatedCoordinates = [Coordinate(1, -2, 1),
                                     Coordinate(0, -2, 1),
                                     Coordinate(0, -2, 2),
                                     Coordinate(-1, -2, 2),
                                     Coordinate(-1, -1, 2),
                                     Coordinate(-2, -1, 2),
                                     Coordinate(-2, 0, 2)]
        
        XCTAssertEqual(footprint.coordinates,
                       translatedCoordinates)
    }
    
    func testFlatFootprintTranslation() throws {
        
        let footprint = Footprint(origin: .init(Coordinate(2, -1, -2)),
                                  coordinates: coordinates)
        
        let translatedCoordinates = [Coordinate(2, -1, -2),
                                     Coordinate(3, -1, -2),
                                     Coordinate(3, -1, -3),
                                     Coordinate(4, -1, -3),
                                     Coordinate(4, -2, -3),
                                     Coordinate(5, -2, -3),
                                     Coordinate(5, -3, -3)]
        
        XCTAssertEqual(footprint.coordinates,
                       translatedCoordinates)
    }
    
    func testPointyFootprintRotation() throws {
        
        let footprint = Footprint(origin: .zero,
                                  coordinates: coordinates)
        
        let leftRotation = footprint.rotate(rotation: .clockwise)
        let rightRotation = footprint.rotate(rotation: .counterClockwise)
        let inverseRotation = leftRotation.rotate(rotation: .clockwise)
        
        let leftCoordinates = [Coordinate(0, 0, 0),
                               Coordinate(0, -1, 0),
                               Coordinate(1, -1, 0),
                               Coordinate(1, -2, 0),
                               Coordinate(1, -2, 1),
                               Coordinate(1, -3, 1),
                               Coordinate(1, -3, 2)]
        
        XCTAssertEqual(leftRotation.coordinates, leftCoordinates)
        
        let rightCoordinates = [Coordinate(0, 0, 0),
                                Coordinate(0, 0, -1),
                                Coordinate(0, 1, -1),
                                Coordinate(0, 1, -2),
                                Coordinate(1, 1, -2),
                                Coordinate(1, 1, -3),
                                Coordinate(2, 1, -3)]
        
        XCTAssertEqual(rightRotation.coordinates,
                       rightCoordinates)
        XCTAssertEqual(inverseRotation.coordinates,
                       rightCoordinates)
    }
    
    func testPointyFootprintTranslationAndRotation() throws {
        
        let footprint = Footprint(origin: .init(Coordinate(1, -2, 1)),
                                  coordinates: coordinates)
        
        let rotatedFootprint = footprint.rotate(rotation: .counterClockwise)
        
        let translatedAndRotatedCoordinates = [Coordinate(1, -2, 1),
                                               Coordinate(1, -2, 0),
                                               Coordinate(1, -1, 0),
                                               Coordinate(1, -1, -1),
                                               Coordinate(2, -1, -1),
                                               Coordinate(2, -1, -2),
                                               Coordinate(3, -1, -2)]
        
        XCTAssertEqual(rotatedFootprint.coordinates,
                       translatedAndRotatedCoordinates)
    }
    
    func testFlatFootprintTranslationAndRotation() throws {
        
        let footprint = Footprint(origin: .init(Coordinate(2, -1, -2)),
                                  coordinates: coordinates)
        
        let rotatedFootprint = footprint.rotate(rotation: .counterClockwise)
        
        let translatedAndRotatedCoordinates = [Coordinate(2, -1, -2),
                                     Coordinate(2, -1, -1),
                                     Coordinate(2, -2, -1),
                                     Coordinate(2, -2, 0),
                                     Coordinate(1, -2, 0),
                                     Coordinate(1, -2, 1),
                                     Coordinate(0, -2, 1)]
        
        XCTAssertEqual(rotatedFootprint.coordinates,
                       translatedAndRotatedCoordinates)
    }
    
    func testFootprintIntersection() throws {
        
        let footprint = Footprint(origin: .zero,
                                  coordinates: coordinates)
        
        let lhs = Footprint(origin: .init(Coordinate(2, -2, 0)),
                            coordinates: coordinates).rotate(rotation: .clockwise)
        
        let rhs = Footprint(origin: .init(Coordinate(2, -2, 0)),
                            coordinates: coordinates)
        
        XCTAssertFalse(footprint.intersects(rhs: lhs))
        XCTAssertTrue(footprint.intersects(rhs: rhs))
    }
}

