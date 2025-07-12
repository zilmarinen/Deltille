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
    
    // MARK: To be removed
    // TODO: Fix vector to coordinate conversion
    
    func testVertexPosition() throws {
        
        let triangle = Triangle.zero
        
        let v0 = triangle.vertex(.c0)
        let v1 = triangle.vertex(.c1)
        let v2 = triangle.vertex(.c2)
        
        let c0 = Vector(v0, .tile)
        let c1 = Vector(v1, .tile)
        let c2 = Vector(v2, .tile)
        
        let center = Vector(triangle.vertex, .tile)
        
        let l0 = c0.lerp(center, 0.1)
        let l1 = c1.lerp(center, 0.1)
        let l2 = c2.lerp(center, 0.1)
        
        let rx = Vertex(center, .tile)
        
        let r0 = Vertex(c0, .tile)
        let r1 = Vertex(c1, .tile)
        let r2 = Vertex(c2, .tile)
        
        let t0 = Vertex(l0, .tile)
        let t1 = Vertex(l1, .tile)
        let t2 = Vertex(l2, .tile)
        
        print("-------")
        print("center: \(center.id))")
        print("v0: \(v0.id) -> \(c0.id)")
        print("v1: \(v1.id) -> \(c1.id)")
        print("v2: \(v2.id) -> \(c2.id)")
        print("-------")
        print("rx: \(center.id)) -> \(rx.id)")
        print("r0: \(c0.id)) -> \(r0.id)")
        print("r1: \(c1.id)) -> \(r1.id)")
        print("r2: \(c2.id)) -> \(r2.id)")
        print("-------")
        print("t0: \(l0.id)) -> \(t0.id)")
        print("t1: \(l1.id)) -> \(t1.id)")
        print("t2: \(l2.id)) -> \(t2.id)")
        print("-------")
    }
    
    func testVertexConversion() throws {
        
        let triangle0 = Triangle(.init(-3, -2, 4))
        let triangle1 = Triangle(.init(-2, -2, 4))
        
        let corner0 = triangle0.vertex(.c2)
        let center0 = Vector(triangle0.vertex, .tile)
        let target0 = Vector(corner0, .tile)
        let vector0 = center0.lerp(target0, 0.9)
        let coordinate0 = Vertex(vector0, .tile)
        
        let corner1 = triangle1.vertex(.c1)
        let center1 = Vector(triangle1.vertex, .tile)
        let target1 = Vector(corner1, .tile)
        let vector1 = center1.lerp(target1, 0.9)
        let coordinate1 = Vertex(vector1, .tile)
        
        XCTAssertEqual(triangle0.vertex.position, coordinate0.position)
        XCTAssertEqual(triangle1.vertex.position, coordinate1.position)
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
    
    // MARK: Vector to Triangle Coordinate
    
    func testVectorToVertexSierpinski() throws {
        
        XCTAssertTrue(testVectorToVertex(.sierpinski))
    }
    
    func testVectorToVertexTile() throws {
        
        XCTAssertTrue(testVectorToVertex(.tile))
    }
    
    func testVectorToVertexChunk() throws {
        
        XCTAssertTrue(testVectorToVertex(.chunk))
    }
    
    func testVectorToVertexRegion() throws {
        
        XCTAssertTrue(testVectorToVertex(.region))
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
        
        let zero = Triangle(.zero)
        let x = Triangle(-.unitX)
        let y = Triangle(-.unitY)
        let z = Triangle(-.unitZ)
        
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
        
        //TODO: resolve accuracy of coordinate / vector conversion
        let interpolation = 0.9
        
        for triangle in triangles {
            
            let center = Vector(triangle.vertex,
                                scale)
            
            for corner in triangle.corners {
                
                let vertex = triangle.vertex(corner)
                
                let vector = Vector(vertex,
                                    scale)
                
                let position = center.lerp(vector, interpolation)
                
                let result = Vertex(position,
                                    scale)
                
                if result.position != vertex.position { return false }
            }
        }
        
        return true
    }
    
    private func testVectorToVertex(_ scale: Triangle.Scale) -> Bool {
        
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
        
        guard   Vertex(v0, scale).position == c0,
                Vertex(v1, scale).position == c1,
                Vertex(v2, scale).position == c2,
                Vertex(v3, scale).position == c3,
                Vertex(v4, scale).position == c4,
                Vertex(v5, scale).position == c5 else { return false }
        
        return true
    }
}
