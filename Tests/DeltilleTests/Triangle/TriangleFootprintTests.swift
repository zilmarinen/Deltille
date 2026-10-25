//
//  TriangleFootprintTests.swift
//
//  Created by Zack Brown on 25/05/2024.
//

import Collections
@testable import Deltille
import Euclid
import Testing

@Suite
struct TriangleFootprintTests {
    
    typealias Footprint = Triangle.Footprint
    
    private let pointyTriangle = Triangle(1, -2, 1)
    private let flatTriangle = Triangle(2, -1, -2)
    
    private let offsets: [Triangle] = [.init(0, 0, 0),
                                       .init(0, 0, -1),
                                       .init(1, 0, -1),
                                       .init(1, 0, -2),
                                       .init(1, 1, -2),
                                       .init(1, 1, -3),
                                       .init(2, 1, -3)]
    
    // MARK: Translation
    
    @Test
    func footprintTranslationPointy() {
        
        let footprint = Footprint(pointyTriangle,
                                  offsets)
        
        let tiles: [Triangle] = [.init(1, -2, 1),
                                 .init(1, -2, 0),
                                 .init(2, -2, 0),
                                 .init(2, -2, -1),
                                 .init(2, -1, -1),
                                 .init(2, -1, -2),
                                 .init(3, -1, -2)]
        
        #expect(footprint.tiles == tiles)
    }
    
    @Test
    func footprintTranslationFlat() {
        
        let footprint = Footprint(flatTriangle,
                                  offsets)
        
        let tiles: [Triangle] = [.init(2, -1, -2),
                                 .init(2, -1, -1),
                                 .init(1, -1, -1),
                                 .init(1, -1, 0),
                                 .init(1, -2, 0),
                                 .init(1, -2, 1),
                                 .init(0, -2, 1)]
        
        #expect(footprint.tiles == tiles)
    }
    
    // MARK: Rotation
    
    @Test
    func footprintRotationPointy() {
        
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
        
        #expect(clockwiseRotation.tiles == clockwiseTiles)
        #expect(counterClockwiseRotation.tiles == counterClockwiseTiles)
    }
    
    @Test
    func footprintRotationFlat() {
        
        let footprint = Footprint(flatTriangle,
                                  offsets)
        
        let clockwiseRotation = footprint.rotate(.clockwise)
        let counterClockwiseRotation = footprint.rotate(.counterClockwise)
        
        let singleTurnClockwiseRotation = footprint.rotate(.clockwise)
        let singleTurnCounterClockwiseRotation = footprint.rotate(.counterClockwise)
        
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
        
        #expect(clockwiseRotation.tiles == clockwiseTiles)
        #expect(counterClockwiseRotation.tiles == counterClockwiseTiles)
        
        #expect(singleTurnClockwiseRotation.tiles == clockwiseTiles)
        #expect(singleTurnCounterClockwiseRotation.tiles == counterClockwiseTiles)
    }
    
    // MARK: Intersection
    
    @Test
    func footprintIntersection() {
        
        let footprint = Footprint(.zero,
                                  [.zero])
        
        let lhs = Footprint(pointyTriangle,
                            offsets)
        
        let rhs = Footprint(flatTriangle,
                            offsets)
        
        #expect(!footprint.intersects(lhs))
        #expect(!footprint.intersects(rhs))
        #expect(lhs.intersects(rhs))
        #expect(rhs.intersects(lhs))
    }
}
