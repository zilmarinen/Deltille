//
//  TriangleTests.swift
//
//  Created by Zack Brown on 25/05/2024.
//

import Euclid
import XCTest
@testable import Deltille

final class TriangleTests: XCTestCase {
    
    typealias Vertex = Triangle.Vertex
    
    private let pointyTriangle = Triangle(4, -2, -2)
    private let flatTriangle = Triangle(-2, -2, 3)
    private let unitTriangle = Triangle(Vertex.zero)
    private let x = Triangle(-.unitX)
    private let y = Triangle(-.unitY)
    private let z = Triangle(-.unitZ)
    
    // MARK: Edges
    
    func testEdges() throws {
        
        for edge in unitTriangle.edges {
            
            let adjacent = unitTriangle.neighbour(edge)
            
            let vertices = Set(edge.corners.map { unitTriangle.vertex($0) })
            
            XCTAssertTrue(vertices.isSubset(of: adjacent.vertices))
        }
    }
    
    // MARK: Distance
    
    func testDistance() throws {
        
        XCTAssertEqual(pointyTriangle.distance(pointyTriangle), 0)
        XCTAssertEqual(flatTriangle.distance(flatTriangle), 0)
        XCTAssertEqual(pointyTriangle.distance(unitTriangle), 8)
        XCTAssertEqual(flatTriangle.distance(unitTriangle), 7)
    }
    
    func testDisc() throws {
        
        XCTAssertEqual(unitTriangle.disc(0).count, 1)
        XCTAssertEqual(unitTriangle.disc(1).count, 4)
        XCTAssertEqual(unitTriangle.disc(2).count, 10)
        XCTAssertEqual(unitTriangle.disc(3).count, 19)
    }
    
    // MARK: Contains Vector
    
    func testTriangleContainsVector() throws {
        
        XCTAssertTrue(unitTriangle.contains(unitTriangle.position(.tile),
                                            .tile))
        XCTAssertTrue(unitTriangle.contains(.zero,
                                            .tile))
        XCTAssertTrue(unitTriangle.contains(unitTriangle.vertex(.c0).position(.tile),
                                            .tile))
        XCTAssertTrue(unitTriangle.contains(unitTriangle.vertex(.c1).position(.tile),
                                            .tile))
        XCTAssertTrue(unitTriangle.contains(unitTriangle.vertex(.c1).position(.tile),
                                            .tile))
        
        XCTAssertTrue(flatTriangle.contains(flatTriangle.position(.tile),
                                            .tile))
        XCTAssertFalse(flatTriangle.contains(.zero,
                                             .tile))
        
        XCTAssertTrue(pointyTriangle.contains(pointyTriangle.position(.tile),
                                              .tile))
        XCTAssertFalse(pointyTriangle.contains(.zero,
                                               .tile))
    }
    
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
        
        let center = Vector(-3.0, 0.0, 5.1961)
        let triangle = Triangle(center, .tile)
        
        let triangleCorners = vertices.map { pointyTriangle.corner($0) }
        
        XCTAssertEqual(triangleCorners, pointyTriangle.corners)
        XCTAssertEqual(triangle.vertex, pointyTriangle.vertex)
    }

    func testFlatVertices() throws {
        
        let vertices: [Vertex] = [.init(-2, -1, 4),
                                  .init(-1, -2, 4),
                                  .init(-1, -1, 3)]
        
        let center = Vector(-2.5, 0.0, -4.3301)
        let triangle = Triangle(center, .tile)
        
        let triangleCorners = vertices.map { flatTriangle.corner($0) }
        
        XCTAssertEqual(triangleCorners, flatTriangle.corners)
        XCTAssertEqual(triangle.vertex, flatTriangle.vertex)
        
    }
    
    // MARK: Transposing
    
    func testTransposeRegionToTile() throws {
        
        let regions = [unitTriangle,
                       x,
                       y,
                       z]
            
        let transposed = regions.map {
            
            $0.transpose(.region,
                         .tile)
        }
        
        let tiles: [Triangle] = [.zero,
                                 .init(-19, 9, 9),
                                 .init(9, -19, 9),
                                 .init(9, 9, -19)]
        
        XCTAssertEqual(transposed,
                       tiles)
    }
    
    func testTransposeRegionToChunk() throws {
        
        let regions = [unitTriangle,
                       x,
                       y,
                       z]
            
        let transposed = regions.map {
            
            $0.transpose(.region,
                         .chunk)
        }
        
        let chunks: [Triangle] = [.zero,
                                  .init(-3, 1, 1),
                                  .init(1, -3, 1),
                                  .init(1, 1, -3)]
        
        XCTAssertEqual(transposed,
                       chunks)
    }
    
    func testTransposeChunkToRegion() throws {
        
        let chunks: [Triangle] = [.zero,
                                  x,
                                  y,
                                  z,
                                  .init(-3, 1, 1),
                                  .init(1, -3, 1),
                                  .init(1, 1, -3)]
            
        let transposed = chunks.map {
            
            $0.transpose(.chunk,
                         .region)
        }
        
        let regions = [unitTriangle,
                       unitTriangle,
                       unitTriangle,
                       unitTriangle,
                       x,
                       y,
                       z]
        
        XCTAssertEqual(transposed,
                       regions)
    }
    
    func testTransposeChunkToTile() throws {
        
        let chunks = [unitTriangle,
                      x,
                      y,
                      z]
            
        let transposed = chunks.map {
            
            $0.transpose(.chunk,
                         .tile)
        }
        
        let tiles: [Triangle] = [.zero,
                                 .init(-5, 2, 2),
                                 .init(2, -5, 2),
                                 .init(2, 2, -5)]
        
        XCTAssertEqual(transposed,
                       tiles)
    }
    
    func testTransposeTileToChunk() throws {
        
        let tiles: [Triangle] = [.zero,
                                 x,
                                 y,
                                 z,
                                 .init(-5, 2, 2),
                                 .init(2, -5, 2),
                                 .init(2, 2, -5)]
            
        let transposed = tiles.map {
            
            $0.transpose(.tile,
                         .chunk)
        }
        
        let chunks = [unitTriangle,
                      unitTriangle,
                      unitTriangle,
                      unitTriangle,
                      x,
                      y,
                      z]
            
        XCTAssertEqual(transposed,
                       chunks)
    }
    
    func testTransposeTileToRegion() throws {
        
        let tiles: [Triangle] = [.zero,
                                 x,
                                 y,
                                 z,
                                 .init(-19, 9, 9),
                                 .init(9, -19, 9),
                                 .init(9, 9, -19)]
            
        let transposed = tiles.map {
            
            $0.transpose(.tile,
                         .region)
        }
        
        let regions = [unitTriangle,
                       unitTriangle,
                       unitTriangle,
                       unitTriangle,
                       x,
                       y,
                       z]
        
        XCTAssertEqual(transposed,
                       regions)
    }
    
    // MARK: Sieve
    
    func testPointySierpinskiSieve() throws {
        
        let sieve = pointyTriangle.sieve(for: .sierpinski)
        let tile = pointyTriangle.transpose(.sierpinski,
                                            .tile)
        
        XCTAssertEqual(sieve.origin,
                       pointyTriangle)
        XCTAssertEqual(sieve.scale, .sierpinski)
        XCTAssertEqual(sieve.triangles.count, 1)
        XCTAssertEqual(sieve.vertices.count, 3)
        XCTAssertTrue(sieve.triangles.contains(tile))
    }
    
    func testFlatSierpinskiSieve() throws {
        
        let sieve = flatTriangle.sieve(for: .sierpinski)
        let tile = flatTriangle.transpose(.sierpinski,
                                          .tile)
        
        XCTAssertEqual(sieve.origin,
                       flatTriangle)
        XCTAssertEqual(sieve.scale, .sierpinski)
        XCTAssertEqual(sieve.triangles.count, 1)
        XCTAssertEqual(sieve.vertices.count, 3)
        XCTAssertTrue(sieve.triangles.contains(tile))
    }
    
    func testPointyTileSieve() throws {
        
        let sieve = pointyTriangle.sieve(for: .tile)
        
        XCTAssertEqual(sieve.origin,
                       pointyTriangle)
        XCTAssertEqual(sieve.scale, .tile)
        XCTAssertEqual(sieve.triangles.count, 1)
        XCTAssertEqual(sieve.vertices.count, 3)
        XCTAssertTrue(sieve.triangles.contains(pointyTriangle))
    }
    
    func testFlatTileSieve() throws {
        
        let sieve = flatTriangle.sieve(for: .tile)
        
        XCTAssertEqual(sieve.origin,
                       flatTriangle)
        XCTAssertEqual(sieve.scale, .tile)
        XCTAssertEqual(sieve.triangles.count, 1)
        XCTAssertEqual(sieve.vertices.count, 3)
        XCTAssertTrue(sieve.triangles.contains(flatTriangle))
    }
    
    func testPointyChunkSieve() throws {
        
        let sieve = pointyTriangle.sieve(for: .chunk)
        let tile = pointyTriangle.transpose(.chunk,
                                            .tile)
        
        XCTAssertEqual(sieve.origin,
                       pointyTriangle)
        XCTAssertEqual(sieve.scale, .chunk)
        XCTAssertEqual(sieve.triangles.count, 49)
        XCTAssertEqual(sieve.vertices.count, 36)
        XCTAssertTrue(sieve.triangles.contains(tile))
    }
    
    func testFlatChunkSieve() throws {
        
        let sieve = flatTriangle.sieve(for: .chunk)
        let tile = flatTriangle.transpose(.chunk,
                                          .tile)
        
        XCTAssertEqual(sieve.origin,
                       flatTriangle)
        XCTAssertEqual(sieve.scale, .chunk)
        XCTAssertEqual(sieve.triangles.count, 49)
        XCTAssertEqual(sieve.vertices.count, 36)
        XCTAssertTrue(sieve.triangles.contains(tile))
    }
    
    func testPointyRegionSieve() throws {
        
        let sieve = pointyTriangle.sieve(for: .region)
        let tile = pointyTriangle.transpose(.region,
                                            .tile)
        
        XCTAssertEqual(sieve.origin,
                       pointyTriangle)
        XCTAssertEqual(sieve.scale, .region)
        XCTAssertEqual(sieve.triangles.count, 784)
        XCTAssertEqual(sieve.vertices.count, 435)
        XCTAssertTrue(sieve.triangles.contains(tile))
    }
    
    func testFlatRegionSieve() throws {
        
        let sieve = flatTriangle.sieve(for: .region)
        let tile = flatTriangle.transpose(.region,
                                          .tile)
        
        XCTAssertEqual(sieve.origin,
                       flatTriangle)
        XCTAssertEqual(sieve.scale, .region)
        XCTAssertEqual(sieve.triangles.count, 784)
        XCTAssertEqual(sieve.vertices.count, 435)
        XCTAssertTrue(sieve.triangles.contains(tile))
    }
}

