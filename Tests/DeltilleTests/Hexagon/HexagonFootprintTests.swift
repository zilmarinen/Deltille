//
//  HexagonFootprintTests.swift
//
//  Created by Zack Brown on 19/12/2024.
//

import Euclid
import XCTest
@testable import Deltille

final class HexagonFootprintTests: XCTestCase {
    
    typealias Coordinate = Grid.Coordinate
    typealias Hexagon = Grid.Hexagon
    typealias Footprint = Hexagon.Footprint
    
    private let hexagon = Hexagon(.init(1, -2, 1))
    
    private let offsets: [Coordinate] = [.init(0, 0, 0),
                                         .init(1, 0, -1),
                                         .init(2, 0, -2),
                                         .init(1, 1, -2)]
    
    // MARK: Translation
    
    func testFootprintTranslation() throws {
    
        let footprint = Footprint(hexagon,
                                  offsets)
        
        let tiles: [Hexagon] = [.init(1, -2, 1),
                                .init(2, -2, 0),
                                .init(3, -2, -1),
                                .init(2, -1, -1)]
        
        XCTAssertEqual(footprint.tiles,
                       tiles)
    }
    
    // MARK: Rotation
    
    func testFootprintRotation() throws {
        
        let footprint = Footprint(hexagon,
                                  offsets)
        
        let clockwiseRotation = footprint.rotate(.clockwise)
        let counterClockwiseRotation = footprint.rotate(.counterClockwise)
        
        let clockwiseTiles: [Hexagon] = [.init(1, -2, 1),
                                         .init(2, -3, 1),
                                         .init(3, -4, 1),
                                         .init(3, -3, 0)]
        
        let counterClockwiseTiles: [Hexagon] = [.init(1, -2, 1),
                                                .init(1, -1, 0),
                                                .init(1, 0, -1),
                                                .init(0, 0, 0)]
        
        XCTAssertEqual(clockwiseRotation.tiles,
                       clockwiseTiles)
        XCTAssertEqual(counterClockwiseRotation.tiles,
                       counterClockwiseTiles)
    }
}
