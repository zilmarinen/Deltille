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
    
    // MARK: Triangle Coordinate to Vector
    
    func testCoordinateConversion() throws {
        
        let triangle0 = Grid.Triangle(.init(-3, -2, 4))
        let triangle1 = Grid.Triangle(.init(-2, -2, 4))
        
        let corner0 = triangle0.corner(.c2)
        let center0 = Vector(triangle0.position, Grid.Triangle.Scale.tile)
        let target0 = Vector(corner0, Grid.Triangle.Scale.tile)
        let vector0 = center0.lerp(target0, 0.9)
        let coordinate0 = Coordinate(vector0, Grid.Triangle.Scale.tile)
        
        let corner1 = triangle1.corner(.c1)
        let center1 = Vector(triangle1.position, Grid.Triangle.Scale.tile)
        let target1 = Vector(corner1, Grid.Triangle.Scale.tile)
        let vector1 = center1.lerp(target1, 0.9)
        let coordinate1 = Coordinate(vector1, Grid.Triangle.Scale.tile)
        
        XCTAssertEqual(triangle0.position, coordinate0)
        XCTAssertEqual(triangle1.position, coordinate1)
    }
    
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
    
    // MARK: Hexagon Coordinate to Vector
    
    func testHexagonTileCoordinateToVector() throws {
        
        XCTAssertTrue(testHexagonCoordinateToVector(.tile))
    }
    
    func testHexagonChunkCoordinateToVector() throws {
        
        XCTAssertTrue(testHexagonCoordinateToVector(.chunk))
    }
    
    func testHexagonRegionCoordinateToVector() throws {
        
        XCTAssertTrue(testHexagonCoordinateToVector(.region))
    }
    
    // MARK: Vector to Hexagon Coordinate
    
    func testHexagonTileVectorToCoordinate() throws {
        
        XCTAssertTrue(testVectorToHexagonCoordinate(.tile))
    }
    
    func testHexagonChunkVectorToCoordinate() throws {
        
        XCTAssertTrue(testVectorToHexagonCoordinate(.chunk))
    }
    
    func testHexagonRegionVectorToCoordinate() throws {
        
        XCTAssertTrue(testVectorToHexagonCoordinate(.region))
    }
    
    // MARK: Hexagon Vertices
    
    func testHexagonTileVertices() throws {
        
        XCTAssertTrue(testHexagonVertices(.tile))
    }
    
    func testHexagonChunkVertices() throws {
        
        XCTAssertTrue(testHexagonVertices(.chunk))
    }
    
    func testHexagonRegionVertices() throws {
        
        XCTAssertTrue(testHexagonVertices(.region))
    }
}

// MARK: Triangle

extension CoordinateTests {
    
    private func testTriangleVertices(_ scale: Grid.Triangle.Scale) -> Bool {
        
        let zero = Grid.Triangle(.zero)
        let x = Grid.Triangle(-.unitX)
        let y = Grid.Triangle(-.unitY)
        let z = Grid.Triangle(-.unitZ)
        
        let edgeLength = scale.edgeLength
        let halfEdgeLength = edgeLength / 2.0
        let sqrt3d6 = .sqrt3d6 * edgeLength
        let sqrt3d3 = .sqrt3d3 * edgeLength
        
        let v0 = Vector(0.0,             0.0, sqrt3d6 * 2.0)
        let v1 = Vector(halfEdgeLength,  0.0, -sqrt3d6)
        let v2 = Vector(-halfEdgeLength, 0.0, -sqrt3d6)
        
        let v3 = Vector(0.0,         0.0, -sqrt3d3 * 2.0)
        let v4 = Vector(-edgeLength, 0.0, sqrt3d3)
        let v5 = Vector(edgeLength,  0.0, sqrt3d3)
        
        let px = Vector(0.0,             0.0, -sqrt3d3)
        let py = Vector(-halfEdgeLength, 0.0, sqrt3d6)
        let pz = Vector(halfEdgeLength,  0.0, sqrt3d6)
        
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
        
        let triangles: [Grid.Triangle] = [.zero,
                                          .init(-.unitX),
                                          .init(-.unitY),
                                          .init(-.unitZ)]
        
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
                              scale) != triangle.position { 
                    
                    print("Testing -> \(vector.id)")
                    print(vertex.id)
                    print(Coordinate(vector,
                                     scale).id)
                    
                    return false }
            }
        }
        
        return true
    }
    
    private func testVectorToTriangleCoordinate(_ scale: Grid.Triangle.Scale) -> Bool {
        
        let edgeLength = scale.edgeLength
        let sqrt3 = .sqrt3 * edgeLength
        
        let c0 = Coordinate(-2, -2, 4)
        let c1 = Coordinate(-2, 4, -2)
        let c2 = Coordinate(4, -2, -2)
        
        let c3 = Coordinate(-3, -3, 6)
        let c4 = Coordinate(-3, 6, -3)
        let c5 = Coordinate(6, -3, -3)
        
        let v0 = Vector(-edgeLength * 3.0, 0.0, -sqrt3)
        let v1 = Vector( edgeLength * 3.0, 0.0, -sqrt3)
        let v2 = Vector(              0.0, 0.0,  sqrt3 * 2.0)
        let v3 = Vector(-edgeLength * 4.5, 0.0, -sqrt3 * 1.5)
        let v4 = Vector( edgeLength * 4.5, 0.0, -sqrt3 * 1.5)
        let v5 = Vector(              0.0, 0.0,  sqrt3 * 3.0)
        
        guard   Coordinate(v0, scale) == c0,
                Coordinate(v1, scale) == c1,
                Coordinate(v2, scale) == c2,
                Coordinate(v3, scale) == c3,
                Coordinate(v4, scale) == c4,
                Coordinate(v5, scale) == c5 else { return false }
        
        return true
    }
}

// MARK: Hexagon

extension CoordinateTests {
    
    private func testHexagonVertices(_ scale: Grid.Hexagon.Scale) -> Bool {
        
        let zero = Grid.Hexagon.zero
        
        let edgeLength = scale.edgeLength
        let halfEdgeLength = edgeLength / 2.0
        let sqrt3d2 = .sqrt3d2 * edgeLength
        
        let v0 = Vector(-halfEdgeLength, 0.0, sqrt3d2)
        let v1 = Vector(halfEdgeLength,  0.0, sqrt3d2)
        let v2 = Vector(edgeLength,      0.0, 0.0)
        let v3 = Vector(halfEdgeLength,  0.0, -sqrt3d2)
        let v4 = Vector(-halfEdgeLength, 0.0, -sqrt3d2)
        let v5 = Vector(-edgeLength,     0.0, 0.0)
        
        guard   Vector(zero.position,
                       scale).isEqual(to: .zero),
                Vector(zero.corner(.c0),
                       scale).isEqual(to: v0),
                Vector(zero.corner(.c1),
                       scale).isEqual(to: v1),
                Vector(zero.corner(.c2),
                       scale).isEqual(to: v2),
                Vector(zero.corner(.c3),
                       scale).isEqual(to: v3),
                Vector(zero.corner(.c4),
                       scale).isEqual(to: v4),
                Vector(zero.corner(.c5),
                       scale).isEqual(to: v5) else { return false }
        
        return true
    }
    
    private func testHexagonCoordinateToVector(_ scale: Grid.Hexagon.Scale) -> Bool {
        
        let hexagons: [Grid.Hexagon] = [.zero,
                                        .init(.unitX - .unitZ),
                                        .init(.unitX - .unitY),
                                        .init(-.unitY + .unitZ),
                                        .init(-.unitX + .unitZ),
                                        .init(-.unitX + .unitY),
                                        .init(.unitY - .unitZ)]
        
        let delta = 0.99
        
        for hexagon in hexagons {
            
            let position = Vector(hexagon.position,
                                  scale)
            
            for corner in Grid.Hexagon.Corner.allCases {
                
                let vertex = Vector(hexagon.corner(corner),
                                    scale)
                
                let vector = position.lerp(vertex, delta)
                
                if Coordinate(vector,
                              scale) != hexagon.position { return false }
            }
        }
        
        return true
    }
    
    private func testVectorToHexagonCoordinate(_ scale: Grid.Hexagon.Scale) -> Bool {
        
        let edgeLength = scale.edgeLength
        let halfEdgeLength = edgeLength / 2.0
        let sqrt3d2 = .sqrt3d2 * edgeLength
        
        let c0 = Coordinate(-1, 1, 0)
        let c1 = Coordinate(1, 0, -1)
        let c2 = Coordinate(0, -1, 1)
        
        let c3 = Coordinate(2, -2, 0)
        let c4 = Coordinate(-2, 0, 2)
        let c5 = Coordinate(0, 2, -2)
        let c6 = Coordinate.zero
        
        let v0 = Vector((edgeLength + halfEdgeLength),  0.0, -sqrt3d2)
        let v1 = Vector(0.0,                            0.0, sqrt3d2 * 2.0)
        let v2 = Vector(-(edgeLength + halfEdgeLength), 0.0, -sqrt3d2)
        let v3 = Vector(-edgeLength * 3.0, 0.0, sqrt3d2 * 2.0)
        let v4 = Vector( 0.0,              0.0, -sqrt3d2 * 4.0)
        let v5 = Vector( edgeLength * 3.0, 0.0,  sqrt3d2 * 2.0)
        let v6 = Vector.zero
        
        guard   Coordinate(v0, scale) == c0,
                Coordinate(v1, scale) == c1,
                Coordinate(v2, scale) == c2,
                Coordinate(v3, scale) == c3,
                Coordinate(v4, scale) == c4,
                Coordinate(v5, scale) == c5,
                Coordinate(v6, scale) == c6 else { return false }
        
        return true
    }
}
