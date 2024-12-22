//
//  TriangleTests.swift
//
//  Created by Zack Brown on 25/05/2024.
//

import Euclid
import XCTest
@testable import Deltille

final class TriangleTests: XCTestCase {
    
    typealias Coordinate = Grid.Coordinate
    typealias Triangle = Grid.Triangle
    typealias Vertex = Triangle.Vertex
    
    private let pointyTriangle = Triangle(4, -2, -2)
    private let flatTriangle = Triangle(-2, -2, 3)
    private let unitTriangle = Triangle(.zero)
    private let x = Triangle(-.unitX)
    private let y = Triangle(-.unitY)
    private let z = Triangle(-.unitZ)
    
    // MARK: Pointy / Flat
    
    func testUnitTriangleIsPointy() throws {
        
        XCTAssertTrue(unitTriangle.isPointy)
        XCTAssertTrue(pointyTriangle.isPointy)
        XCTAssertFalse(flatTriangle.isPointy)
    }
    
    // MARK: Neighbours / Adjacency
    
    func testPointyNeighboursAdjacency() throws {
        
        let tiles: [Triangle] = [.init(3, -2, -2),
                                 .init(4, -3, -2),
                                 .init(4, -2, -3)]
        
        let neighbours = pointyTriangle.edges.map { pointyTriangle.neighbour($0) }
        
        XCTAssertEqual(neighbours, tiles)
        XCTAssertEqual(pointyTriangle.adjacent, tiles)
    }
    
    func testFlatNeighboursAdjacency() throws {
        
        let tiles: [Triangle] = [.init(-1, -2, 3),
                                 .init(-2, -1, 3),
                                 .init(-2, -2, 4)]
        
        let neighbours = flatTriangle.edges.map { flatTriangle.neighbour($0) }
        
        XCTAssertEqual(neighbours, tiles)
        XCTAssertEqual(flatTriangle.adjacent, tiles)
    }
    
    // MARK: Perimeter
    
    func testPointyPerimeter() throws {
        
        let perimeter: [Triangle] = [.init(pointyTriangle.vertex.position + .init(-1, 0, 0)),
                                     .init(pointyTriangle.vertex.position + .init(-1, 1, 0)),
                                     .init(pointyTriangle.vertex.position + .init(-1, 1, -1)),
                                     .init(pointyTriangle.vertex.position + .init(0, 1, -1)),
                                     .init(pointyTriangle.vertex.position + .init(0, 0, -1)),
                                     .init(pointyTriangle.vertex.position + .init(1, 0, -1)),
                                     .init(pointyTriangle.vertex.position + .init(1, -1, -1)),
                                     .init(pointyTriangle.vertex.position + .init(1, -1, 0)),
                                     .init(pointyTriangle.vertex.position + .init(0, -1, 0)),
                                     .init(pointyTriangle.vertex.position + .init(0, -1, 1)),
                                     .init(pointyTriangle.vertex.position + .init(-1, -1, 1)),
                                     .init(pointyTriangle.vertex.position + .init(-1, 0, 1))]
        
        let lhs = Set(perimeter)
        let rhs = Set(pointyTriangle.perimeter)
        
        XCTAssertTrue(lhs.isSubset(of: rhs))
        XCTAssertEqual(perimeter.count, pointyTriangle.perimeter.count)
    }
    
    func testFlatPerimeter() throws {
        
        let perimeter: [Triangle] = [.init(flatTriangle.vertex.position + .init(1, 0, 0)),
                                     .init(flatTriangle.vertex.position + .init(1, -1, 0)),
                                     .init(flatTriangle.vertex.position + .init(1, -1, 1)),
                                     .init(flatTriangle.vertex.position + .init(0, -1, 1)),
                                     .init(flatTriangle.vertex.position + .init(0, 0, 1)),
                                     .init(flatTriangle.vertex.position + .init(-1, 0, 1)),
                                     .init(flatTriangle.vertex.position + .init(-1, 1, 1)),
                                     .init(flatTriangle.vertex.position + .init(-1, 1, 0)),
                                     .init(flatTriangle.vertex.position + .init(0, 1, 0)),
                                     .init(flatTriangle.vertex.position + .init(0, 1, -1)),
                                     .init(flatTriangle.vertex.position + .init(1, 1, -1)),
                                     .init(flatTriangle.vertex.position + .init(1, 0, -1))]
        
        let lhs = Set(perimeter)
        let rhs = Set(flatTriangle.perimeter)
        
        XCTAssertTrue(lhs.isSubset(of: rhs))
        XCTAssertEqual(perimeter.count, flatTriangle.perimeter.count)
    }
    
    // MARK: Vertices / Corners
    
    func testPointyVertices() throws {
        
        let vertices: [Vertex] = [.init(5, -2, -2),
                                  .init(4, -1, -2),
                                  .init(4, -2, -1)]
        
        let vectors: [Vector] = [.init(0.0, 0.0, 4.0414),
                                 .init(0.5, 0.0, 3.1754),
                                 .init(-0.5, 0.0, 3.1754)]
        
        let center = Vector(0.0, 0.0, 3.4641)
        let vertex = Vertex(center, .tile)
        
        let triangleCorners = vertices.map { pointyTriangle.corner($0) }
        let triangleVertices = vectors.map { Vertex($0, .tile) }
        
        XCTAssertEqual(triangleCorners, pointyTriangle.corners)
        XCTAssertEqual(triangleVertices, pointyTriangle.vertices)
        XCTAssertEqual(vertex, pointyTriangle.vertex)
    }
    
    func testFlatVertices() throws {
        
        let vertices: [Vertex] = [.init(-2, -1, 4),
                                  .init(-1, -2, 4),
                                  .init(-1, -1, 3)]
        
        let vectors: [Vector] = [.init(-2.5, 0.0, -2.0207),
                                 .init(-3.0, 0.0, -1.1547),
                                 .init(-2.0, 0.0, -1.1547)]
        
        let center = Vector(-2.5, 0.0, -1.4433)
        let vertex = Vertex(center, .tile)
        
        let triangleCorners = vertices.map { flatTriangle.corner($0) }
        let triangleVertices = vectors.map { Vertex($0, .tile) }
        
        XCTAssertEqual(triangleCorners, flatTriangle.corners)
        XCTAssertEqual(triangleVertices, flatTriangle.vertices)
        XCTAssertEqual(vertex, flatTriangle.vertex)
        
    }
    
    // MARK: Transposing
    
    func testTransposeRegionToTile() throws {
        
        let regions = [unitTriangle,
                       x,
                       y,
                       z].map { $0.transpose(.region,
                                             .tile) }
        
        let triangles: [Triangle] = [.init(0, 0, 0),
                                     .init(-19, 9, 9),
                                     .init(9, -19, 9),
                                     .init(9, 9, -19)]
        
        XCTAssertEqual(regions,
                       triangles)
    }
    
    func testTransposeRegionToChunk() throws {
        
        let regions = [unitTriangle,
                       x,
                       y,
                       z].map { $0.transpose(.region,
                                             .chunk) }
        
        let triangles: [Triangle] = [.init(0, 0, 0),
                                     .init(-3, 1, 1),
                                     .init(1, -3, 1),
                                     .init(1, 1, -3)]
        
        XCTAssertEqual(regions,
                       triangles)
    }
    
    func testTransposeChunkToRegion() throws {
        
        let regions = [Triangle(0, 0, 0),
                       x,
                       y,
                       z,
                       Triangle(-3, 1, 1),
                       Triangle(1, -3, 1),
                       Triangle(1, 1, -3)].map { $0.transpose(.chunk,
                                                              .region) }
        
        let triangles = [unitTriangle,
                         unitTriangle,
                         unitTriangle,
                         unitTriangle,
                         x,
                         y,
                         z]
        
        XCTAssertEqual(regions, triangles)
        
        XCTAssertEqual(.zero,
                       Triangle(2, -1, -1).transpose(.chunk,
                                                     .region))
        XCTAssertEqual(.zero,
                       Triangle(-1, 2, -1).transpose(.chunk,
                                                     .region))
        XCTAssertEqual(.zero,
                       Triangle(-1, -1, 2).transpose(.chunk,
                                                     .region))
        
        XCTAssertEqual(Triangle(-1, -1, 1),
                       Triangle(-2, -2, 3).transpose(.chunk,
                                                     .region))
        XCTAssertEqual(Triangle(-1, 1, -1),
                       Triangle(-2, 3, -2).transpose(.chunk,
                                                     .region))
        XCTAssertEqual(Triangle(1, -1, -1),
                       Triangle(3, -2, -2).transpose(.chunk,
                                                     .region))
    }
    
    func testTransposeChunkToTile() throws {
        
        let chunks = [unitTriangle,
                      x,
                      y,
                      z].map { $0.transpose(.chunk,
                                            .tile) }
        
        let triangles = [Triangle(0, 0, 0),
                         Triangle(-5, 2, 2),
                         Triangle(2, -5, 2),
                         Triangle(2, 2, -5)]
        
        XCTAssertEqual(chunks,
                       triangles)
    }
    
    func testTransposeTileToChunk() throws {
        
        let tiles = [Triangle(0, 0, 0),
                     x,
                     y,
                     z,
                     Triangle(-5, 2, 2),
                     Triangle(2, -5, 2),
                     Triangle(2, 2, -5)].map { $0.transpose(.tile,
                                                                 .chunk) }
        
        let triangles = [unitTriangle,
                         unitTriangle,
                         unitTriangle,
                         unitTriangle,
                         x,
                         y,
                         z]
        
        XCTAssertEqual(tiles, triangles)
        
        XCTAssertEqual(.zero,
                       Triangle(2, -1, -1).transpose(.tile,
                                                     .chunk))
        XCTAssertEqual(.zero,
                       Triangle(-1, 2, -1).transpose(.tile,
                                                     .chunk))
        XCTAssertEqual(.zero,
                       Triangle(-1, -1, 2).transpose(.tile,
                                                     .chunk))
        
        XCTAssertEqual(.zero,
                       Triangle(-2, -2, 4).transpose(.tile,
                                                     .chunk))
        XCTAssertEqual(.zero,
                       Triangle(-2, 4, -2).transpose(.tile,
                                                     .chunk))
        XCTAssertEqual(.zero,
                       Triangle(4, -2, -2).transpose(.tile,
                                                     .chunk))
    }
    
    func testTransposeTileToRegion() throws {
        
        let tiles = [Triangle(0, 0, 0),
                     x,
                     y,
                     z,
                     Triangle(-19, 9, 9),
                     Triangle(9, -19, 9),
                     Triangle(9, 9, -19)].map { $0.transpose(.tile,
                                                             .region) }
        
        let triangles = [unitTriangle,
                         unitTriangle,
                         unitTriangle,
                         unitTriangle,
                         x,
                         y,
                         z]
        
        XCTAssertEqual(tiles,
                       triangles)
    }
    
    // MARK: Sieve
    
    func testPointySierpinskiSieve() throws {
        
        let sieve = pointyTriangle.sieve(for: .sierpinski)
        
        XCTAssertEqual(sieve.origin,
                       pointyTriangle)
        XCTAssertEqual(sieve.scale, .sierpinski)
        XCTAssertEqual(sieve.triangles.count, 1)
        XCTAssertEqual(sieve.vertices.count, 3)
    }
    
    func testFlatSierpinskiSieve() throws {
        
        let sieve = flatTriangle.sieve(for: .sierpinski)
        
        XCTAssertEqual(sieve.origin,
                       flatTriangle)
        XCTAssertEqual(sieve.scale, .sierpinski)
        XCTAssertEqual(sieve.triangles.count, 1)
        XCTAssertEqual(sieve.vertices.count, 3)
    }
    
    func testPointyTileSieve() throws {
        
        let sieve = pointyTriangle.sieve(for: .tile)
        
        XCTAssertEqual(sieve.origin,
                       pointyTriangle)
        XCTAssertEqual(sieve.scale, .tile)
        XCTAssertEqual(sieve.triangles.count, 1)
        XCTAssertEqual(sieve.vertices.count, 3)
    }
    
    func testFlatTileSieve() throws {
        
        let sieve = flatTriangle.sieve(for: .tile)
        
        XCTAssertEqual(sieve.origin,
                       flatTriangle)
        XCTAssertEqual(sieve.scale, .tile)
        XCTAssertEqual(sieve.triangles.count, 1)
        XCTAssertEqual(sieve.vertices.count, 3)
    }
    
    func testPointyChunkSieve() throws {
        
        let sieve = pointyTriangle.sieve(for: .chunk)
        
        XCTAssertEqual(sieve.origin,
                       pointyTriangle)
        XCTAssertEqual(sieve.scale, .chunk)
        XCTAssertEqual(sieve.triangles.count, 49)
        XCTAssertEqual(sieve.vertices.count, 36)
    }
    
    func testFlatChunkSieve() throws {
        
        let sieve = flatTriangle.sieve(for: .chunk)
        
        XCTAssertEqual(sieve.origin,
                       flatTriangle)
        XCTAssertEqual(sieve.scale, .chunk)
        XCTAssertEqual(sieve.triangles.count, 49)
        XCTAssertEqual(sieve.vertices.count, 36)
    }
    
    func testPointyRegionSieve() throws {
        
        let sieve = pointyTriangle.sieve(for: .region)
        
        XCTAssertEqual(sieve.origin,
                       pointyTriangle)
        XCTAssertEqual(sieve.scale, .region)
        XCTAssertEqual(sieve.triangles.count, 784)
        XCTAssertEqual(sieve.vertices.count, 435)
    }
    
    func testFlatRegionSieve() throws {
        
        let sieve = flatTriangle.sieve(for: .region)
        
        XCTAssertEqual(sieve.origin,
                       flatTriangle)
        XCTAssertEqual(sieve.scale, .region)
        XCTAssertEqual(sieve.triangles.count, 784)
        XCTAssertEqual(sieve.vertices.count, 435)
    }
}
