//
//  TriangleVertexTests.swift
//
//  Created by Zack Brown on 25/05/2024.
//

import Euclid
import XCTest
@testable import Deltille

final class TriangleVertexTests: XCTestCase {
    
    typealias Coordinate = Grid.Coordinate
    typealias Triangle = Grid.Triangle
    typealias Vertex = Triangle.Vertex
    
    private let vertex = Vertex(.init(3, -1, -1))
    
    // MARK: Tiles
    
    func testVertexTiles() throws {
        
        let tiles: [Triangle] = [.init(2, -1, -1),
                                 .init(2, -2, -1),
                                 .init(3, -2, -1),
                                 .init(3, -2, -2),
                                 .init(3, -1, -2),
                                 .init(2, -1, -2)]
        
        XCTAssertEqual(vertex.tiles, tiles)
    }
    
    // MARK: Vertices
    
    func testVertexVertices() throws {
        
        let vertices: [Vertex] = [.init(2, 0, -1),
                                  .init(2, -1, 0),
                                  .init(3, -2, 0),
                                  .init(4, -2, -1),
                                  .init(4, -1, -2),
                                  .init(3, 0, -2)]
        
        XCTAssertEqual(vertex.vertices, vertices)
    }
    
    func testVertexConversion() throws {
        
        let triangle0 = Triangle(Coordinate(-3, -2, 4))
        let triangle1 = Triangle(Coordinate(-2, -2, 4))
        
        let corner0 = triangle0.vertex(.c2)
        let center0 = Vector(triangle0.vertex, .tile)
        let target0 = Vector(corner0, .tile)
        let vector0 = center0.lerp(target0, 0.9)
        let result0 = Triangle(vector0, .tile)
        
        let corner1 = triangle1.vertex(.c1)
        let center1 = Vector(triangle1.vertex, .tile)
        let target1 = Vector(corner1, .tile)
        let vector1 = center1.lerp(target1, 0.9)
        let result1 = Triangle(vector1, .tile)
        
        XCTAssertEqual(triangle0.vertex, result0.vertex)
        XCTAssertEqual(triangle1.vertex, result1.vertex)
    }
    
    // MARK: Vertex to Vector
    
    func testVertexToVectorSierpinski() throws {
        
        XCTAssertTrue(testVertexToVector(.sierpinski))
    }
    
    func testVertexToVectorTile() throws {
        
        XCTAssertTrue(testVertexToVector(.tile))
    }
    
    func testVertexToVectorChunk() throws {
        
        XCTAssertTrue(testVertexToVector(.chunk))
    }
    
    func testVertexToVectorRegion() throws {
        
        XCTAssertTrue(testVertexToVector(.region))
    }
    
    // MARK: Vector to Triangle
    
    func testVectorToTriangleSierpinski() throws {
        
        XCTAssertTrue(testVectorToTriangle(.sierpinski))
    }
    
    func testVectorToTriangleTile() throws {
        
        XCTAssertTrue(testVectorToTriangle(.tile))
    }
    
    func testVectorToTriangleChunk() throws {
        
        XCTAssertTrue(testVectorToTriangle(.chunk))
    }
    
    func testVectorToTriangleRegion() throws {
        
        XCTAssertTrue(testVectorToTriangle(.region))
    }
    
    // MARK: Vertices
    
    func testSierpinskiVertices() throws {
        
        XCTAssertTrue(testVertices(.sierpinski))
    }
    
    func testTileVertices() throws {
        
        XCTAssertTrue(testVertices(.tile))
    }
    
    func testChunkVertices() throws {
        
        XCTAssertTrue(testVertices(.chunk))
    }
    
    func testRegionVertices() throws {
        
        XCTAssertTrue(testVertices(.region))
    }
}

extension TriangleVertexTests {
    
    private func testVertices(_ scale: Triangle.Scale) -> Bool {
        
        let zero = Triangle(Vertex.zero)
        let x = Triangle(-.unitX)
        let y = Triangle(-.unitY)
        let z = Triangle(-.unitZ)
        
        let edgeLength = scale.edgeLength
        let halfEdgeLength = edgeLength / 2.0
        let sqrt3d2 = .sqrt3d2 * edgeLength
        
        let v0 = Vector(-halfEdgeLength, 0.0, .sqrt3d2 * edgeLength)
        let v1 = Vector(edgeLength,      0.0, 0.0)
        let v2 = Vector(-halfEdgeLength, 0.0, -.sqrt3d2 * edgeLength)
        
        let v3 = Vector(edgeLength,        0.0, -sqrt3d2 * 2.0)
        let v4 = Vector(-edgeLength * 2.0, 0.0, 0.0)
        let v5 = Vector(edgeLength,        0.0, sqrt3d2 * 2.0)
        
        let px = Vector(halfEdgeLength, 0.0, -sqrt3d2)
        let py = Vector(-edgeLength, 0.0, 0.0)
        let pz = Vector(halfEdgeLength,  0.0, sqrt3d2)
        
        guard   Vector(zero.vertex,
                       scale).isEqual(to: .zero),
                Vector(zero.vertex(.c0),
                       scale).isEqual(to: v0),
                Vector(zero.vertex(.c1),
                       scale).isEqual(to: v1),
                Vector(zero.vertex(.c2),
                       scale).isEqual(to: v2),
              
                Vector(x.vertex,
                       scale).isEqual(to: px),
                Vector(x.vertex(.c0),
                       scale).isEqual(to: v3),
                Vector(x.vertex(.c1),
                       scale).isEqual(to: v2),
                Vector(x.vertex(.c2),
                       scale).isEqual(to: v1),
        
                Vector(y.vertex,
                       scale).isEqual(to: py),
                Vector(y.vertex(.c0),
                       scale).isEqual(to: v2),
                Vector(y.vertex(.c1),
                       scale).isEqual(to: v4),
                Vector(y.vertex(.c2),
                       scale).isEqual(to: v0),
        
                Vector(z.vertex,
                       scale).isEqual(to: pz),
                Vector(z.vertex(.c0),
                       scale).isEqual(to: v1),
                Vector(z.vertex(.c1),
                       scale).isEqual(to: v0),
                Vector(z.vertex(.c2),
                       scale).isEqual(to: v5) else { return false }
        
        return true
    }
    
    private func testVertexToVector(_ scale: Triangle.Scale) -> Bool {
        
        let triangles: [Triangle] = [.zero,
                                     .init(-.unitX),
                                     .init(-.unitY),
                                     .init(-.unitZ)]
        
        let interpolation = 0.9999
        
        for triangle in triangles {
            
            let center = triangle.vertex.position(scale)
            
            for corner in triangle.corners {
                
                let vertex = triangle.vertex(corner)
                
                let position = center.lerp(vertex.position(scale),
                                           interpolation)
                
                let result = Triangle(position,
                                      scale)
                
                if result.vertex != triangle.vertex {
                    
                    return false
                }
            }
        }
        
        return true
    }
    
    private func testVectorToTriangle(_ scale: Triangle.Scale) -> Bool {
        
        let edgeLength = scale.edgeLength
        let sqrt3d2 = .sqrt3d2 * edgeLength
        
        let c0 = Coordinate(-2, -2, 4)
        let c1 = Coordinate(-2, 4, -2)
        let c2 = Coordinate(4, -2, -2)
        
        let c3 = Coordinate(-3, -3, 6)
        let c4 = Coordinate(-3, 6, -3)
        let c5 = Coordinate(6, -3, -3)
        
        let v0 = Vector(-edgeLength * 3.0, 0.0, -sqrt3d2 * 6.0)
        let v1 = Vector( edgeLength * 6.0, 0.0,  0.0)
        let v2 = Vector(-edgeLength * 3.0, 0.0,  sqrt3d2 * 6.0)
        let v3 = Vector(-edgeLength * 4.5, 0.0, -sqrt3d2 * 9.0)
        let v4 = Vector( edgeLength * 9.0, 0.0, 0.0)
        let v5 = Vector(-edgeLength * 4.5, 0.0,  sqrt3d2 * 9.0)
        
        guard   Triangle(v0, scale).vertex.position == c0,
                Triangle(v1, scale).vertex.position == c1,
                Triangle(v2, scale).vertex.position == c2,
                Triangle(v3, scale).vertex.position == c3,
                Triangle(v4, scale).vertex.position == c4,
                Triangle(v5, scale).vertex.position == c5 else { return false }
        
        return true
    }
}
