//
//  HexagonFootprintTests.swift
//
//  Created by Zack Brown on 19/12/2024.
//

import Collections
@testable import Deltille
import Euclid
import Testing

@Suite
struct HexagonFootprintTests {
    
    typealias Footprint = Hexagon.Footprint
    
    private let hexagon = Hexagon(1, -2, 1)
    
    private let offsets: [Hexagon] = [.init(0, 0, 0),
                                      .init(1, 0, -1),
                                      .init(2, 0, -2),
                                      .init(1, 1, -2)]
    
    // MARK: Translation
    
    @Test
    func footprintTranslation() {
        
        let footprint = Footprint(hexagon,
                                  offsets)
        
        let tiles: [Hexagon] = [.init(1, -2, 1),
                                .init(2, -2, 0),
                                .init(3, -2, -1),
                                .init(2, -1, -1)]
        
        #expect(footprint.tiles == tiles)
    }
    
    // MARK: Rotation
    
    @Test
    func footprintRotation() {
        
        let footprint = Footprint(hexagon,
                                  offsets)
        
        let clockwiseRotation = footprint.rotate(.clockwise)
        let counterClockwiseRotation = footprint.rotate(.counterClockwise)
        
        let singleTurnClockwise = footprint.rotate(.clockwise)
        let singleTurnCounterClockwise = footprint.rotate(.counterClockwise)
        
        let clockwiseTiles: [Hexagon] = [.init(1, -2, 1),
                                         .init(2, -3, 1),
                                         .init(3, -4, 1),
                                         .init(3, -3, 0)]
        
        let counterClockwiseTiles: [Hexagon] = [.init(1, -2, 1),
                                                .init(1, -1, 0),
                                                .init(1, 0, -1),
                                                .init(0, 0, 0)]
        
        #expect(clockwiseRotation.tiles == clockwiseTiles)
        #expect(counterClockwiseRotation.tiles == counterClockwiseTiles)
        
        #expect(singleTurnClockwise.tiles == clockwiseTiles)
        #expect(singleTurnCounterClockwise.tiles == counterClockwiseTiles)
    }
}
