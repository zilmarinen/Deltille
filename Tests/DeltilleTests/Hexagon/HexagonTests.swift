//
//  HexagonTests.swift
//
//  Created by Zack Brown on 12/06/2024.
//

import Euclid
import XCTest
@testable import Deltille

final class HexagonTests: XCTestCase {
    
    typealias Vertex = Hexagon.Vertex
    
    private let precision = 0.9999
    
    // MARK: Edges
    
    func testEdges() throws {
        
        let hexagon = Hexagon.zero
        
        for edge in hexagon.edges {
            
            let adjacent = hexagon.neighbour(edge)
            
            let vertices = Set(edge.corners.map {
                
                hexagon.vertex($0)
            })
            
            XCTAssertTrue(vertices.isSubset(of: adjacent.vertices()))
        }
    }
    
    // MARK: Distance
    
    func testDistance() throws {
        
        let lhs = Hexagon(2, -2, 0)
        let rhs = Hexagon(-1, 2, -1)
        
        XCTAssertEqual(lhs.distance(lhs), 0)
        XCTAssertEqual(lhs.distance(rhs), 4)
    }
    
    func testDisc() throws {
        
        let hexagon = Hexagon.zero
        
        XCTAssertEqual(hexagon.disc(0).count, 1)
        XCTAssertEqual(hexagon.disc(1).count, 7)
        XCTAssertEqual(hexagon.disc(2).count, 19)
        XCTAssertEqual(hexagon.disc(3).count, 37)
    }
    
    // MARK: Contains Vector
    
    func testHexagonTileContainsVector() throws {
        
        let scale = Hexagon.Scale.tile
        let hexagon = Hexagon(19, 0, -19)
        let center = hexagon.vertex.vector
        let neighbour = hexagon.neighbour(.e0)
        let outside = neighbour.vertex.vector
        
        XCTAssertTrue(hexagon.contains(center,
                                       scale))
        
        XCTAssertFalse(hexagon.contains(.zero,
                                        scale))
        
        XCTAssertFalse(hexagon.contains(outside,
                                        scale))
        
        for corner in hexagon.corners {
            
            let vertex = hexagon.vertex(corner,
                                        scale)
            
            XCTAssertTrue(hexagon.contains(vertex.vector,
                                           scale))
        }
    }
    
    func testHexagonChunkContainsVector() throws {
        
        let scale = Hexagon.Scale.chunk
        let hexagon = Hexagon(5, -3, -2)
        let center = hexagon.transpose(.chunk,
                                       .tile).vertex.vector
        let neighbour = hexagon.neighbour(.e0)
        let outside = neighbour.transpose(.chunk,
                                          .tile).vertex.vector
        
        XCTAssertTrue(hexagon.contains(center,
                                       scale))
        
        XCTAssertFalse(hexagon.contains(.zero,
                                        scale))
        
        XCTAssertFalse(hexagon.contains(outside,
                                        scale))
        
        for corner in hexagon.corners {
            
            let vertex = hexagon.vertex(corner,
                                        scale)
            
            XCTAssertTrue(hexagon.contains(vertex.vector,
                                           scale))
        }
    }
    
    func testVertexConversion() throws {
        
        let lhs = Hexagon(3, -2, -1)
        let rhs = Hexagon(-5, 2, 3)
        
        let corner0 = lhs.vertex(.c2)
        let center0 = lhs.vertex.vector
        let target0 = corner0.vector
        let vector0 = center0.lerp(target0,
                                   precision)
        let result0 = Hexagon(vector0)
        
        let corner1 = rhs.vertex(.c1)
        let center1 = rhs.vertex.vector
        let target1 = corner1.vector
        let vector1 = center1.lerp(target1,
                                   precision)
        let result1 = Hexagon(vector1)
        
        XCTAssertEqual(lhs.vertex.vector,
                       result0.vertex.vector)
        
        XCTAssertEqual(rhs.vertex.vector,
                       result1.vertex.vector)
    }
    
    func testClosestTileVertex() throws {
        
        let scale = Hexagon.Scale.tile
        let triangle = Hexagon(19, 0, -19)
        
        let center = triangle.vertex.vector
        let vertex = triangle.vertex(.c0,
                                     scale)
        
        let vector = center.mid(vertex.vector)
        
        XCTAssertEqual(triangle.closest(vertex: vector,
                                        scale), vertex)
    }
    
    func testClosestChunkVertex() throws {
        
        let scale = Hexagon.Scale.chunk
        let triangle = Hexagon(-3, 2, 1)
        
        let center = triangle.vertex.vector
        let vertex = triangle.vertex(.c0,
                                     scale)
        
        let vector = center.mid(vertex.vector)
        
        XCTAssertEqual(triangle.closest(vertex: vector,
                                        scale), vertex)
    }
    
    // MARK: Neighbours
    
    func testNeighbours() throws {
        
        let hexagon = Hexagon(2, -1, -1)
        
        let tiles: [Hexagon] = [.init(3, -1, -2),
                                .init(2, 0, -2),
                                .init(1, 0, -1),
                                .init(1, -1, 0),
                                .init(2, -2, 0),
                                .init(3, -2, -1)]
        
        let neighbours = hexagon.edges.map {
            
            hexagon.neighbour($0)
        }
        
        XCTAssertEqual(neighbours,
                       tiles)
        
        XCTAssertEqual(hexagon.adjacent,
                       tiles)
    }
    
    // MARK: Vertices / Corners
    
    func testTileVerticesAndCorners() throws {
        
        let hexagon = Hexagon(-3, 2, 1)
        
        let vertices: [Vertex] = [.init(-2, 2, 1),
                                  .init(-3, 2, 0),
                                  .init(-3, 3, 1),
                                  .init(-4, 2, 1),
                                  .init(-3, 2, 2),
                                  .init(-3, 1, 1)]
        
        let hexagonCorners = vertices.map {
            
            hexagon.corner($0,
                           .tile)
        }
        
        let hexagonVertices = hexagon.corners.map {
            
            hexagon.vertex($0,
                           .tile)
        }
        
        XCTAssertEqual(hexagonCorners,
                       hexagon.corners)
        
        XCTAssertEqual(hexagonVertices,
                       vertices)
        
        XCTAssertEqual(hexagonVertices,
                       hexagon.vertices(.tile))
        
        XCTAssertEqual(nil,
                       hexagon.corner(.zero))
    }
    
    func testChunkVerticesAndCorners() throws {
        
        let hexagon = Hexagon(5, -3, -2)
        
        let vertices: [Vertex] = [.init(22, 1, -21),
                                  .init(18, 2, -22),
                                  .init(17, 3, -18),
                                  .init(16, -1, -17),
                                  .init(20, -2, -16),
                                  .init(21, -3, -20)]

        let hexagonCorners = vertices.map {
            
            hexagon.corner($0,
                           .chunk)
        }
        
        let hexagonVertices = hexagon.corners.map {
            
            hexagon.vertex($0,
                           .chunk)
        }
        
        XCTAssertEqual(hexagonCorners,
                       hexagon.corners)
        
        XCTAssertEqual(hexagonVertices,
                       vertices)
        
        XCTAssertEqual(hexagonVertices,
                       hexagon.vertices(.chunk))
        
        XCTAssertEqual(nil,
                       hexagon.corner(.zero))
    }
    
    // MARK: Transposing
    
    func testTransposeRegionToTile() throws {
        
        // Regions at the corner of a region
        let regions: [Hexagon] = [.init(1, 0, -1),
                                  .init(1, -1, 0),
                                  .init(2, -1, -1)]
            
        let transposed = regions.transpose(.region,
                                           .tile)
        
        // Tiles in the center of a region
        let tiles: [Hexagon] = [.init(9, 4, -13),
                                .init(13, -9, -4),
                                .init(22, -5, -17)]
        
        XCTAssertEqual(transposed,
                       tiles)
    }
    
    func testTransposeRegionToChunk() throws {
        
        // Regions at the corner of a region
        let regions: [Hexagon] = [.init(1, 0, -1),
                                  .init(1, -1, 0),
                                  .init(2, -1, -1)]
            
        let transposed = regions.transpose(.region,
                                           .chunk)
        
        // Chunks in the center of a region
        let chunks: [Hexagon] = [.init(3, -1, -2),
                                 .init(2, -3, 1),
                                 .init(5, -4, -1)]
        
        XCTAssertEqual(transposed,
                       chunks)
    }
    
    func testTransposeChunkToRegion() throws {
        
        // Chunks at the corner of a region
        let chunks: [Hexagon] = [.init(3, -2, -1),
                                 .init(3, -3, 0),
                                 .init(4, -3, -1)]
            
        let transposed = chunks.transpose(.chunk,
                                          .region)
        
        // Regions at the corner of a region
        let regions: [Hexagon] = [.init(1, 0, -1),
                                  .init(1, -1, 0),
                                  .init(2, -1, -1)]
        
        XCTAssertEqual(transposed,
                       regions)
    }
    
    func testTransposeChunkToTile() throws {
        
        // Chunks at the corner of a region
        let chunks: [Hexagon] = [.init(3, -2, -1),
                                 .init(3, -3, 0),
                                 .init(4, -3, -1)]
            
        let transposed = chunks.transpose(.chunk,
                                          .tile)
        
        // Tiles in the center of a chunk
        let tiles: [Hexagon] = [.init(12, -1, -11),
                                .init(15, -6, -9),
                                .init(17, -3, -14)]
        
        XCTAssertEqual(transposed,
                       tiles)
    }
    
    func testTransposeTileToChunk() throws {
        
        // Tiles at the corner of a chunk
        let tiles: [Hexagon] = [.init(14, -3, -11),
                                .init(15, -4, -11),
                                .init(15, -3, -12)]
            
        let transposed = tiles.transpose(.tile,
                                         .chunk)
        
        // Chunks at the corner of a region
        let chunks: [Hexagon] = [.init(3, -2, -1),
                                 .init(3, -3, 0),
                                 .init(4, -3, -1)]
        
        XCTAssertEqual(transposed,
                       chunks)
    }
    
    func testTransposeTileToRegion() throws {
        
        // Tiles at the corner of a chunk
        let tiles: [Hexagon] = [.init(14, -3, -11),
                                .init(15, -4, -11),
                                .init(15, -3, -12)]
            
        let transposed = tiles.transpose(.tile,
                                         .region)
        
        // Regions at the corner of a region
        let regions: [Hexagon] = [.init(1, 0, -1),
                                  .init(1, -1, 0),
                                  .init(2, -1, -1)]
        
        XCTAssertEqual(transposed,
                       regions)
    }
    
    // MARK: Sieve
    
    func testTileSieve() throws {
        
        let hexagon = Hexagon.zero
        let sieve = hexagon.sieve(.tile)
        
        XCTAssertEqual(sieve.origin,
                       hexagon)
        
        XCTAssertEqual(sieve.scale, .tile)
        XCTAssertEqual(sieve.tiles.count, 0)
        XCTAssertEqual(sieve.vertices.count, 0)
        XCTAssertTrue(sieve.tiles.contains(hexagon))
    }
    
    func testChunkSieve() throws {
        
        let hexagon = Hexagon.zero
        let sieve = hexagon.sieve(.chunk)
        
        XCTAssertEqual(sieve.origin,
                       hexagon)
        
        XCTAssertEqual(sieve.scale, .chunk)
        XCTAssertEqual(sieve.tiles.count, 0)
        XCTAssertEqual(sieve.vertices.count, 0)
        XCTAssertTrue(sieve.tiles.contains(hexagon))
    }
    
    func testRegionSieve() throws {
        
        let hexagon = Hexagon.zero
        let sieve = hexagon.sieve(.region)
        
        XCTAssertEqual(sieve.origin,
                       hexagon)
        
        XCTAssertEqual(sieve.scale, .region)
        XCTAssertEqual(sieve.tiles.count, 0)
        XCTAssertEqual(sieve.vertices.count, 0)
        XCTAssertTrue(sieve.tiles.contains(hexagon))
    }
}
