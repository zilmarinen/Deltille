//
//  HexagonTests.swift
//
//  Created by Zack Brown on 12/06/2024.
//

import Collections
@testable import Deltille
import Euclid
import Testing

@Suite
struct HexagonTests {
    
    typealias Vertex = Hexagon.Vertex
    
    private let precision = 0.9999
    
    // MARK: Edges
    
    @Test
    func testEdges() {
        
        let hexagon = Hexagon.zero
        
        for edge in hexagon.edges {
            
            let adjacent = hexagon.neighbour(edge)
            
            let vertices = Set(edge.corners.map {
                
                hexagon.vertex($0)
            })
            
            #expect(vertices.isSubset(of: adjacent.vertices()))
        }
    }
    
    // MARK: Distance
    
    @Test
    func testDistance() {
        
        let lhs = Hexagon(2, -2, 0)
        let rhs = Hexagon(-1, 2, -1)
        
        #expect(lhs.distance(lhs) == 0)
        #expect(lhs.distance(rhs) == 4)
    }
    
    @Test
    func testDisc() {
        
        let hexagon = Hexagon.zero
        
        #expect(hexagon.disc(0).count == 1)
        #expect(hexagon.disc(1).count == 7)
        #expect(hexagon.disc(2).count == 19)
        #expect(hexagon.disc(3).count == 37)
    }
    
    // MARK: Contains Vector
    
    @Test
    func hexagonTileContainsVector() {
        
        let scale = Scale.tile
        let hexagon = Hexagon(19, 0, -19)
        let center = hexagon.vertex.vector()
        let neighbour = hexagon.neighbour(.e0)
        let outside = neighbour.vertex.vector()
        
        #expect(hexagon.contains(center,
                                 scale))
        
        #expect(!hexagon.contains(.zero,
                                  scale))
        
        #expect(!hexagon.contains(outside,
                                  scale))
        
        for corner in hexagon.corners {
            
            let vertex = hexagon.vertex(corner,
                                        scale)
            
            #expect(hexagon.contains(vertex.vector(),
                                     scale))
        }
    }
    
    @Test
    func hexagonChunkContainsVector() {
        
        let scale = Scale.chunk
        let hexagon = Hexagon(5, -3, -2)
        let center = hexagon.transpose(scale,
                                       .tile).vertex.vector()
        let neighbour = hexagon.neighbour(.e0)
        let outside = neighbour.transpose(scale,
                                          .tile).vertex.vector()
        
        #expect(hexagon.contains(center,
                                 scale))
        
        #expect(!hexagon.contains(.zero,
                                  scale))
        
        #expect(!hexagon.contains(outside,
                                  scale))
        
        for corner in hexagon.corners {
            
            let vertex = hexagon.vertex(corner,
                                        scale)
            
            #expect(hexagon.contains(vertex.vector(),
                                     scale))
        }
    }
    
    @Test
    func hexagonRegionContainsVector() {
        
        let scale = Scale.region
        let hexagon = Hexagon(2, -1, -1)
        let center = hexagon.transpose(scale,
                                       .tile).vertex.vector()
        let neighbour = hexagon.neighbour(.e0)
        let outside = neighbour.transpose(scale,
                                          .tile).vertex.vector()
        
        #expect(hexagon.contains(center,
                                 scale))
        
        #expect(!hexagon.contains(.zero,
                                  scale))
        
        #expect(!hexagon.contains(outside,
                                  scale))
        
        for corner in hexagon.corners {
            
            let vertex = hexagon.vertex(corner,
                                        scale)
            
            #expect(hexagon.contains(vertex.vector(),
                                     scale))
        }
    }
    
    @Test
    func vertexConversion() {
        
        let lhs = Hexagon(3, -2, -1)
        let rhs = Hexagon(-5, 2, 3)
        
        let corner0 = lhs.vertex(.c2)
        let center0 = lhs.vertex.vector()
        let target0 = corner0.vector()
        let vector0 = center0.lerp(target0,
                                   precision)
        let result0 = Hexagon(vector0)
        
        let corner1 = rhs.vertex(.c1)
        let center1 = rhs.vertex.vector()
        let target1 = corner1.vector()
        let vector1 = center1.lerp(target1,
                                   precision)
        let result1 = Hexagon(vector1)
        
        #expect(lhs.vertex.vector() == result0.vertex.vector())
        
        #expect(rhs.vertex.vector() == result1.vertex.vector())
    }
    
    @Test
    func closestTileVertex() {
        
        let scale = Scale.tile
        let tile = Hexagon(19, 0, -19)
        
        let center = tile.vertex.vector()
        let vertex = tile.vertex(.c0,
                                 scale)
        
        let vector = center.mid(vertex.vector())
        
        #expect(tile.closest(vertex: vector,
                             scale) == vertex)
    }
    
    @Test
    func closestChunkVertex() {
        
        let scale = Scale.chunk
        let tile = Hexagon(-3, 2, 1)
        
        let center = tile.transpose(scale,
                                    .tile).vertex.vector()
        let vertex = tile.vertex(.c0,
                                 scale)
        
        let vector = center.mid(vertex.vector())
        
        #expect(tile.closest(vertex: vector,
                             scale) == vertex)
    }
    
    @Test
    func closestRegionVertex() {
        
        let scale = Scale.region
        let tile = Hexagon(2, -1, -1)
        
        let center = tile.transpose(scale,
                                    .tile).vertex.vector()
        let vertex = tile.vertex(.c0,
                                 scale)
        
        let vector = center.mid(vertex.vector())
        
        #expect(tile.closest(vertex: vector,
                             scale) == vertex)
    }
    
    // MARK: Neighbours
    
    @Test
    func testNeighbours() {
        
        let hexagon = Hexagon(2, -1, -1)
        
        let tiles: OrderedSet<Hexagon> = [.init(3, -1, -2),
                                          .init(2, 0, -2),
                                          .init(1, 0, -1),
                                          .init(1, -1, 0),
                                          .init(2, -2, 0),
                                          .init(3, -2, -1)]
        
        let neighbours = OrderedSet(hexagon.edges.map {
            
            hexagon.neighbour($0)
        })
        
        #expect(neighbours == tiles)
        
        #expect(hexagon.adjacent == tiles)
    }
    
    // MARK: Vertices / Corners
    
    @Test
    func tileVerticesAndCorners() {
        
        let hexagon = Hexagon(-3, 2, 1)
        
        let vertices: OrderedSet<Vertex> = [.init(-2, 2, 1),
                                            .init(-3, 2, 0),
                                            .init(-3, 3, 1),
                                            .init(-4, 2, 1),
                                            .init(-3, 2, 2),
                                            .init(-3, 1, 1)]
        
        let hexagonCorners = OrderedSet(vertices.map {
            
            hexagon.corner($0,
                           .tile)!
        })
        
        let hexagonVertices = OrderedSet(hexagon.corners.map {
            
            hexagon.vertex($0,
                           .tile)
        })
        
        #expect(hexagonCorners == hexagon.corners)
        
        #expect(hexagonVertices == vertices)
        
        #expect(hexagonVertices == hexagon.vertices(.tile))
        
        #expect(hexagon.corner(.zero) == nil)
    }
    
    @Test
    func chunkVerticesAndCorners() {
        
        let hexagon = Hexagon(5, -3, -2)
        
        let vertices: OrderedSet<Vertex> = [.init(22, 1, -21),
                                            .init(18, 2, -22),
                                            .init(17, 3, -18),
                                            .init(16, -1, -17),
                                            .init(20, -2, -16),
                                            .init(21, -3, -20)]
        
        let hexagonCorners = OrderedSet(vertices.map {
            
            hexagon.corner($0,
                           .chunk)!
        })
        
        let hexagonVertices = OrderedSet(hexagon.corners.map {
            
            hexagon.vertex($0,
                           .chunk)
        })
        
        #expect(hexagonCorners == hexagon.corners)
        
        #expect(hexagonVertices == vertices)
        
        #expect(hexagonVertices == hexagon.vertices(.chunk))
        
        #expect(hexagon.corner(.zero) == nil)
    }
    
    // MARK: Transposing
    
    @Test
    func transposeRegionToTile() {
        
        // Regions at the corner of a region
        let regions: Set<Hexagon> = [.init(1, 0, -1),
                                     .init(1, -1, 0),
                                     .init(2, -1, -1)]
        
        let transposed = regions.transpose(.region,
                                           .tile)
        
        // Tiles in the center of a region
        let tiles: Set<Hexagon> = [.init(9, 4, -13),
                                   .init(13, -9, -4),
                                   .init(22, -5, -17)]
        
        #expect(transposed == tiles)
    }
    
    @Test
    func transposeRegionToChunk() {
        
        // Regions at the corner of a region
        let regions: Set<Hexagon> = [.init(1, 0, -1),
                                     .init(1, -1, 0),
                                     .init(2, -1, -1)]
        
        let transposed = regions.transpose(.region,
                                           .chunk)
        
        // Chunks in the center of a region
        let chunks: Set<Hexagon> = [.init(3, -1, -2),
                                    .init(2, -3, 1),
                                    .init(5, -4, -1)]
        
        #expect(transposed == chunks)
    }
    
    @Test
    func transposeChunkToRegion() {
        
        // Chunks at the corner of a region
        let chunks: Set<Hexagon> = [.init(3, -2, -1),
                                    .init(3, -3, 0),
                                    .init(4, -3, -1)]
        
        let transposed = chunks.transpose(.chunk,
                                          .region)
        
        // Regions at the corner of a region
        let regions: Set<Hexagon> = [.init(1, 0, -1),
                                     .init(1, -1, 0),
                                     .init(2, -1, -1)]
        
        #expect(transposed == regions)
    }
    
    @Test
    func transposeChunkToTile() {
        
        // Chunks at the corner of a region
        let chunks: Set<Hexagon> = [.init(3, -2, -1),
                                    .init(3, -3, 0),
                                    .init(4, -3, -1)]
        
        let transposed = chunks.transpose(.chunk,
                                          .tile)
        
        // Tiles in the center of a chunk
        let tiles: Set<Hexagon> = [.init(12, -1, -11),
                                   .init(15, -6, -9),
                                   .init(17, -3, -14)]
        
        #expect(transposed == tiles)
    }
    
    @Test
    func transposeTileToChunk() {
        
        // Tiles at the corner of a chunk
        let tiles: Set<Hexagon> = [.init(14, -3, -11),
                                   .init(15, -4, -11),
                                   .init(15, -3, -12)]
        
        let transposed = tiles.transpose(.tile,
                                         .chunk)
        
        // Chunks at the corner of a region
        let chunks: Set<Hexagon> = [.init(3, -2, -1),
                                    .init(3, -3, 0),
                                    .init(4, -3, -1)]
        
        #expect(transposed == chunks)
    }
    
    @Test
    func transposeTileToRegion() {
        
        // Tiles at the corner of a chunk
        let tiles: Set<Hexagon> = [.init(14, -3, -11),
                                   .init(15, -4, -11),
                                   .init(15, -3, -12)]
        
        let transposed = tiles.transpose(.tile,
                                         .region)
        
        // Regions at the corner of a region
        let regions: Set<Hexagon> = [.init(1, 0, -1),
                                     .init(1, -1, 0),
                                     .init(2, -1, -1)]
        
        #expect(transposed == regions)
    }
    
    // MARK: Sieve
    
    @Test
    func tileSieve() {
        
        let hexagon = Hexagon.zero
        let sieve = hexagon.sieve(.tile)
        
        #expect(sieve.origin == hexagon)
        
        #expect(sieve.scale == .tile)
        #expect(sieve.tiles.count == 1)
        #expect(sieve.vertices.count == 6)
        #expect(sieve.tiles.contains(hexagon))
    }
    
    @Test
    func chunkSieve() {
        
        let hexagon = Hexagon.zero
        let sieve = hexagon.sieve(.chunk)
        
        #expect(sieve.origin == hexagon)
        
        #expect(sieve.scale == .chunk)
        #expect(sieve.tiles.count == 19)
        #expect(sieve.vertices.count == 54)
        #expect(sieve.tiles.contains(hexagon))
    }
    
    @Test
    func regionSieve() {
        
        let hexagon = Hexagon.zero
        let sieve = hexagon.sieve(.region)
        
        #expect(sieve.origin == hexagon)
        
        #expect(sieve.scale == .region)
        #expect(sieve.tiles.count == 133)
        #expect(sieve.vertices.count == 312)
        #expect(sieve.tiles.contains(hexagon))
    }
}
