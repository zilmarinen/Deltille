//
//  CoordinateTests.swift
//
//  Created by Zack Brown on 25/05/2024.
//

import Euclid
import XCTest
@testable import Deltille

final class CoordinateTests: XCTestCase {
    
    typealias Coordinate = Grid.Coordinate
    
    private let zero = Grid.Triangle(.zero)
    private let x = Grid.Triangle(-.unitX)
    private let y = Grid.Triangle(-.unitY)
    private let z = Grid.Triangle(-.unitZ)
    
    // MARK: Triangle Coordinate to Vector
    
    func testTriangleSierpinskiCoordinateToVector() throws {
        
        XCTAssertTrue(testTriangleCoordinateToVector(.sierpinski))
    }
    
    func testTriangleTileCoordinateToVector() throws {
        
        XCTAssertTrue(testTriangleCoordinateToVector(.tile))
    }
    
    func testTriangleChunkCoordinateToVector() throws {
        
        XCTAssertTrue(testTriangleCoordinateToVector(.chunk))
    }
    
    func testTriangleRegionCoordinateToVector() throws {
        
        XCTAssertTrue(testTriangleCoordinateToVector(.region))
    }
    
    // MARK: Vector to Triangle Coordinate
    
    func testTriangleSierpinskiVectorToCoordinate() throws {
        
        XCTAssertTrue(testVectorToTriangleCoordinate(.sierpinski))
    }
    
    func testTriangleTileVectorToCoordinate() throws {
        
        XCTAssertTrue(testVectorToTriangleCoordinate(.tile))
    }
    
    func testTriangleChunkVectorToCoordinate() throws {
        
        XCTAssertTrue(testVectorToTriangleCoordinate(.chunk))
    }
    
    func testTriangleRegionVectorToCoordinate() throws {
        
        XCTAssertTrue(testVectorToTriangleCoordinate(.region))
    }
    
    // MARK: Triangle Vertices
    
    func testTriangleSierpinskiVertices() throws {
        
        XCTAssertTrue(testTriangleVertices(.sierpinski))
    }
    
    func testTriangleTileVertices() throws {
        
        XCTAssertTrue(testTriangleVertices(.tile))
    }
    
    func testTriangleChunkVertices() throws {
        
        XCTAssertTrue(testTriangleVertices(.chunk))
    }
    
    func testTriangleRegionVertices() throws {
        
        XCTAssertTrue(testTriangleVertices(.region))
    }
}

extension CoordinateTests {
    
    private func testTriangleVertices(_ scale: Grid.Triangle.Scale) -> Bool {
        
        let edgeLength = scale.edgeLength
        let halfEdgeLength = edgeLength / 2.0
        let sqrt3d6 = .sqrt3d6 * edgeLength
        let sqrt3d3 = .sqrt3d3 * edgeLength
        
        let v0 = Vector(0.0, 0.0, sqrt3d6 * 2.0)
        let v1 = Vector(halfEdgeLength, 0.0, -sqrt3d6)
        let v2 = Vector(-halfEdgeLength, 0.0, -sqrt3d6)
        
        let v3 = Vector(0.0, 0.0, -sqrt3d3 * 2.0)
        let v4 = Vector(-edgeLength, 0.0, sqrt3d3)
        let v5 = Vector(edgeLength, 0.0, sqrt3d3)
        
        let px = Vector(0.0, 0.0, -sqrt3d3)
        let py = Vector(-halfEdgeLength, 0.0, sqrt3d6)
        let pz = Vector(halfEdgeLength, 0.0, sqrt3d6)
        
        guard   Vector(zero.position, 
                       scale).isEqual(to: .zero),
                Vector(zero.corner(.c0), 
                       scale).isEqual(to: v0),
                Vector(zero.corner(.c1), 
                       scale).isEqual(to: v1),
                Vector(zero.corner(.c2), 
                       scale).isEqual(to: v2),
              
                Vector(x.position, 
                       scale).isEqual(to: px),
                Vector(x.corner(.c0), 
                       scale).isEqual(to: v3),
                Vector(x.corner(.c1), 
                       scale).isEqual(to: v2),
                Vector(x.corner(.c2), 
                       scale).isEqual(to: v1),
        
                Vector(y.position, 
                       scale).isEqual(to: py),
                Vector(y.corner(.c0), 
                       scale).isEqual(to: v2),
                Vector(y.corner(.c1), 
                       scale).isEqual(to: v4),
                Vector(y.corner(.c2), 
                       scale).isEqual(to: v0),
        
                Vector(z.position, 
                       scale).isEqual(to: pz),
                Vector(z.corner(.c0), 
                       scale).isEqual(to: v1),
                Vector(z.corner(.c1), 
                       scale).isEqual(to: v0),
                Vector(z.corner(.c2), 
                       scale).isEqual(to: v5) else { return false }
        
        return true
    }
    
    private func testTriangleCoordinateToVector(_ scale: Grid.Triangle.Scale) -> Bool {
        
        let triangles = [zero,
                         x,
                         y,
                         z]
        
        //TODO: resolve accuracy of coordinate / vector conversion
        let delta = 0.9
        
        for triangle in triangles {
            
            let position = Vector(triangle.position,
                                  scale)
            
            for corner in Grid.Triangle.Corner.allCases {
                
                let vertex = Vector(triangle.corner(corner),
                                    scale)
                
                let vector = position.lerp(vertex, delta)
                
                if Coordinate(vector,
                              scale) != triangle.position { return false }
            }
        }
        
        return true
    }
    
    private func testVectorToTriangleCoordinate(_ scale: Grid.Triangle.Scale) -> Bool {
        
        let edgeLength = scale.edgeLength
        
        let c0 = Coordinate(-2, -2, 4)
        let c1 = Coordinate(-2, 4, -2)
        let c2 = Coordinate(4, -2, -2)
        
        let c3 = Coordinate(-3, -3, 6)
        let c4 = Coordinate(-3, 6, -3)
        let c5 = Coordinate(6, -3, -3)
        
        let v0 = Vector(-edgeLength * 3.0, 0.0, -.sqrt3 * edgeLength)
        let v1 = Vector(edgeLength * 3.0, 0.0, -.sqrt3 * edgeLength)
        let v2 = Vector(0.0, 0.0, .sqrt3 * edgeLength * 2.0)
        let v3 = Vector(-edgeLength * 4.5, 0.0, -.sqrt3 * edgeLength * 1.5)
        let v4 = Vector(edgeLength * 4.5, 0.0, -.sqrt3 * edgeLength * 1.5)
        let v5 = Vector(0.0, 0.0, .sqrt3 * edgeLength * 3.0)
        
        guard   Coordinate(v0, scale) == c0,
                Coordinate(v1, scale) == c1,
                Coordinate(v2, scale) == c2,
        
                Coordinate(v3, scale) == c3,
                Coordinate(v4, scale) == c4,
                Coordinate(v5, scale) == c5 else { return false }
        
        return true
    }
}
