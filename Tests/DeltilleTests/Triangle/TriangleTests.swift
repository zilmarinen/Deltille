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
    
    // MARK: Edges
    
    func testEdges() throws {
        
        let triangle = Triangle.zero
        
        for edge in triangle.edges {
            
            let adjacent = triangle.neighbour(edge)
            
            let vertices = Set(edge.corners.map {
                
                triangle.vertex($0)
            })
            
            XCTAssertTrue(vertices.isSubset(of: adjacent.vertices()))
        }
    }
    
    // MARK: Distance
    
    func testDistance() throws {
        
        let lhs = Triangle(-3, 2, 0)
        let rhs = Triangle(2, -1, 2)
        
        XCTAssertEqual(lhs.distance(lhs), 0)
        XCTAssertEqual(rhs.distance(rhs), 0)
        XCTAssertEqual(lhs.distance(.zero), 5)
        XCTAssertEqual(lhs.distance(rhs), 10)
    }
    
    func testDisc() throws {
        
        let triangle = Triangle.zero
        
        XCTAssertEqual(triangle.disc(0).count, 1)
        XCTAssertEqual(triangle.disc(1).count, 4)
        XCTAssertEqual(triangle.disc(2).count, 10)
        XCTAssertEqual(triangle.disc(3).count, 19)
    }
    
    // MARK: Contains Vector
    
    func testTriangleContainsVector() throws {
        
        let triangle = Triangle(-2, -1, 3)
        
        XCTAssertTrue(triangle.contains(triangle.vector,
                                        .tile))
        XCTAssertFalse(triangle.contains(.zero,
                                         .tile))
        
        XCTAssertTrue(triangle.contains(triangle.vertex(.c0).vector,
                                        .tile))
        XCTAssertTrue(triangle.contains(triangle.vertex(.c1).vector,
                                        .tile))
        XCTAssertTrue(triangle.contains(triangle.vertex(.c1).vector,
                                        .tile))
    }
    
    func testVertexConversion() throws {
        
        let lhs = Triangle.zero
        let rhs = Triangle.zero
        
        let corner0 = lhs.vertex(.c2)
        let center0 = lhs.vector
        let target0 = Vector(corner0)
        let vector0 = center0.lerp(target0, 0.9)
        let result0 = Triangle(vector0)
        
        let corner1 = rhs.vertex(.c1)
        let center1 = rhs.vector
        let target1 = Vector(corner1)
        let vector1 = center1.lerp(target1, 0.9)
        let result1 = Triangle(vector1)
        
        XCTAssertEqual(lhs.vector,
                       result0.vector)
        
        XCTAssertEqual(rhs.vector,
                       result1.vector)
    }
    
    func testClosestVertex() throws {
        
        let scale = Triangle.Scale.tile
        let triangle = Triangle(-3, 2, 1)
        
        let center = triangle.vector
        let vertex = triangle.vertex(.c0)
        
        let vector = center.mid(vertex.vector)
        
        XCTAssertEqual(triangle.closest(vertex: vector,
                                        scale), vertex)
    }
    
    // MARK: Pointy / Flat
    
    func testUnitTriangleIsPointy() throws {
        
        let lhs = Triangle.zero
        let rhs = Triangle(-11, 5, 5)
        
        XCTAssertTrue(lhs.isPointy)
        XCTAssertFalse(rhs.isPointy)
    }
    
    // MARK: Neighbours
    
    func testPointyNeighboursAdjacency() throws {
        
        let triangle = Triangle(-11, 5, 5)
        
        let tiles: [Triangle] = [.init(-10, 5, 5),
                                 .init(-11, 6, 5),
                                 .init(-11, 5, 6)]
        
        let neighbours = triangle.edges.map {
            
            triangle.neighbour($0)
        }
        
        XCTAssertEqual(neighbours,
                       tiles)
        
        XCTAssertEqual(triangle.adjacent,
                       tiles)
    }
    
    func testFlatNeighboursAdjacency() throws {
        
        let triangle = Triangle(16, -16, 0)
        
        let tiles: [Triangle] = [.init(15, -16, 0),
                                 .init(16, -17, 0),
                                 .init(16, -16, -1)]
        
        let neighbours = triangle.edges.map {
            
            triangle.neighbour($0)
        }
        
        XCTAssertEqual(neighbours,
                       tiles)
        
        XCTAssertEqual(triangle.adjacent,
                       tiles)
    }
    
    // MARK: Vertices / Corners
    
    func testVertices() throws {
        
        let triangle = Triangle(-11, 5, 5)
        
        let vertices: [Vertex] = [.init(-12, 5, 5),
                                  .init(-11, 4, 5),
                                  .init(-11, 5, 4)]
        
        let triangleCorners = vertices.map {
            
            triangle.corner($0)
        }
        
        let triangleVertices = triangle.corners.map {
            
            triangle.vertex($0)
        }
        
        XCTAssertEqual(triangleCorners,
                       triangle.corners)
        
        XCTAssertEqual(triangleVertices,
                       vertices)
        
        XCTAssertEqual(triangleVertices,
                       triangle.vertices())
        
        XCTAssertEqual(nil,
                       triangle.corner(.zero))
    }
    
    // MARK: Transposing
    
    func testTransposeRegionToTile() throws {
        
        // Regions at the corner of a region
        let regions: [Triangle] = [.init(-1, 0, 0),
                                   .init(-1, 1, 0),
                                   .init(-1, 1, -1),
                                   .init(0, 1, -1),
                                   .init(0, 0, -1),
                                   .zero]
            
        let transposed = regions.transpose(.region,
                                           .tile)
        
        // Tiles in the center of a region
        let tiles: [Triangle] = [.init(-11, 5, 5),
                                 .init(-16, 16, 0),
                                 .init(-11, 21, -11),
                                 .init(0, 16, -16),
                                 .init(5, 5, -11),
                                 .zero]
        
        XCTAssertEqual(transposed,
                       tiles)
    }
    
    func testTransposeRegionToChunk() throws {
        
        // Regions at the corner of a region
        let regions: [Triangle] = [.init(-1, 0, 0),
                                   .init(-1, 1, 0),
                                   .init(-1, 1, -1),
                                   .init(0, 1, -1),
                                   .init(0, 0, -1),
                                   .zero]
            
        let transposed = regions.transpose(.region,
                                           .chunk)
        
        // Chunks in the center of a region
        let chunks: [Triangle] = [.init(-3, 1, 1),
                                  .init(-4, 4, 0),
                                  .init(-3, 5, -3),
                                  .init(0, 4, -4),
                                  .init(1, 1, -3),
                                  .zero]
        
        XCTAssertEqual(transposed,
                       chunks)
    }
    
    func testTransposeChunkToRegion() throws {
        
        // Chunks at the corner of a region
        let chunks: [Triangle] = [.init(-2, 2, -1),
                                  .init(-2, 3, -1),
                                  .init(-2, 3, -2),
                                  .init(-1, 3, -2),
                                  .init(-1, 2, -2),
                                  .init(-1, 2, -1)]
        
        let transposed = chunks.transpose(.chunk,
                                          .region)
        
        // Regions at the corner of a region
        let regions: [Triangle] = [.init(-1, 0, 0),
                                   .init(-1, 1, 0),
                                   .init(-1, 1, -1),
                                   .init(0, 1, -1),
                                   .init(0, 0, -1),
                                   .zero]
        
        XCTAssertEqual(transposed,
                       regions)
    }
    
    func testTransposeChunkToTile() throws {
        
        // Chunks at the corner of a region
        let chunks: [Triangle] = [.init(-2, 2, -1),
                                  .init(-2, 3, -1),
                                  .init(-2, 3, -2),
                                  .init(-1, 3, -2),
                                  .init(-1, 2, -2),
                                  .init(-1, 2, -1)]
            
        let transposed = chunks.transpose(.chunk,
                                          .tile)
        
        // Tiles in the center of a chunk
        let tiles: [Triangle] = [.init(-7, 9, -3),
                                 .init(-8, 12, -4),
                                 .init(-7, 13, -7),
                                 .init(-4, 12, -8),
                                 .init(-3, 9, -7),
                                 .init(-4, 8, -4)]
        
        XCTAssertEqual(transposed,
                       tiles)
    }
    
    func testTransposeTileToChunk() throws {
        
        // Tiles at the corner of a region
        let tiles: [Triangle] = [.init(-6, 10, -5),
                                 .init(-6, 11, -5),
                                 .init(-6, 11, -6),
                                 .init(-5, 11, -6),
                                 .init(-5, 10, -6),
                                 .init(-5, 10, -5)]
            
        let transposed = tiles.transpose(.tile,
                                         .chunk)
        
        // Chunks at the corner of a region
        let chunks: [Triangle] = [.init(-2, 2, -1),
                                  .init(-2, 3, -1),
                                  .init(-2, 3, -2),
                                  .init(-1, 3, -2),
                                  .init(-1, 2, -2),
                                  .init(-1, 2, -1)]
            
        XCTAssertEqual(transposed,
                       chunks)
    }
    
    func testTransposeTileToRegion() throws {
        
        // Tiles at the corner of a region
        let tiles: [Triangle] = [.init(-6, 10, -5),
                                 .init(-6, 11, -5),
                                 .init(-6, 11, -6),
                                 .init(-5, 11, -6),
                                 .init(-5, 10, -6),
                                 .init(-5, 10, -5)]
            
        let transposed = tiles.transpose(.tile,
                                         .region)
        
        // Regions at the corner of a region
        let regions: [Triangle] = [.init(-1, 0, 0),
                                   .init(-1, 1, 0),
                                   .init(-1, 1, -1),
                                   .init(0, 1, -1),
                                   .init(0, 0, -1),
                                   .zero]
        
        XCTAssertEqual(transposed,
                       regions)
    }
    
    // MARK: Sieve
    
    func testPointyTileSieve() throws {
        
        let triangle = Triangle.zero
        let sieve = triangle.sieve(.tile)
        
        XCTAssertEqual(sieve.origin,
                       triangle)
        
        XCTAssertEqual(sieve.scale, .tile)
        XCTAssertEqual(sieve.triangles.count, 1)
        XCTAssertEqual(sieve.vertices.count, 3)
        XCTAssertTrue(sieve.triangles.contains(triangle))
    }
    
    func testFlatTileSieve() throws {
        
        let triangle = Triangle.zero
        let sieve = triangle.sieve(.tile)
        
        XCTAssertEqual(sieve.origin,
                       triangle)
        
        XCTAssertEqual(sieve.scale, .tile)
        XCTAssertEqual(sieve.triangles.count, 1)
        XCTAssertEqual(sieve.vertices.count, 3)
        XCTAssertTrue(sieve.triangles.contains(triangle))
    }
    
    func testPointyChunkSieve() throws {
        
        let triangle = Triangle.zero
        let sieve = triangle.sieve(.chunk)
        let tile = triangle.transpose(.chunk,
                                      .tile)
        
        XCTAssertEqual(sieve.origin,
                       triangle)
        
        XCTAssertEqual(sieve.scale, .chunk)
        XCTAssertEqual(sieve.triangles.count, 16)
        XCTAssertEqual(sieve.vertices.count, 15)
        XCTAssertTrue(sieve.triangles.contains(tile))
    }
    
    func testFlatChunkSieve() throws {
        
        let triangle = Triangle.zero
        let sieve = triangle.sieve(.chunk)
        let tile = triangle.transpose(.chunk,
                                      .tile)
        
        XCTAssertEqual(sieve.origin,
                       triangle)
        
        XCTAssertEqual(sieve.scale, .chunk)
        XCTAssertEqual(sieve.triangles.count, 16)
        XCTAssertEqual(sieve.vertices.count, 15)
        XCTAssertTrue(sieve.triangles.contains(tile))
    }
    
    func testPointyRegionSieve() throws {
        
        let triangle = Triangle.zero
        let sieve = triangle.sieve(.region)
        let tile = triangle.transpose(.region,
                                      .tile)
        
        XCTAssertEqual(sieve.origin,
                       triangle)
        
        XCTAssertEqual(sieve.scale, .region)
        XCTAssertEqual(sieve.triangles.count, 256)
        XCTAssertEqual(sieve.vertices.count, 153)
        XCTAssertTrue(sieve.triangles.contains(tile))
    }
    
    func testFlatRegionSieve() throws {
        
        let triangle = Triangle.zero
        let sieve = triangle.sieve(.region)
        let tile = triangle.transpose(.region,
                                      .tile)
        
        XCTAssertEqual(sieve.origin,
                       triangle)
        
        XCTAssertEqual(sieve.scale, .region)
        XCTAssertEqual(sieve.triangles.count, 256)
        XCTAssertEqual(sieve.vertices.count, 153)
        XCTAssertTrue(sieve.triangles.contains(tile))
    }
}

