//
//  TriangleTests.swift
//
//  Created by Zack Brown on 25/05/2024.
//

import Collections
@testable import Deltille
import Euclid
import Testing

@Suite
struct TriangleTests {
    
    typealias Vertex = Triangle.Vertex
    
    // MARK: Edges
    
    @Test
    func testEdges() {
        
        let triangle = Triangle.zero
        
        for edge in triangle.edges {
            
            let adjacent = triangle.neighbour(edge)
            
            let vertices = Set(edge.corners.map {
                
                triangle.vertex($0)
            })
            
            #expect(vertices.isSubset(of: adjacent.vertices()))
        }
    }
    
    // MARK: Distance
    
    @Test
    func testDistance() {
        
        let lhs = Triangle(-3, 2, 0)
        let rhs = Triangle(2, -1, 2)
        
        #expect(lhs.distance(lhs) == 0)
        #expect(rhs.distance(rhs) == 0)
        #expect(lhs.distance(.zero) == 5)
        #expect(lhs.distance(rhs) == 10)
    }
    
    @Test
    func testDisc() {
        
        let triangle = Triangle.zero
        
        #expect(triangle.disc(0).count == 1)
        #expect(triangle.disc(1).count == 4)
        #expect(triangle.disc(2).count == 10)
        #expect(triangle.disc(3).count == 19)
    }
    
    // MARK: Contains Vector
    
    @Test
    func triangleTileContainsVector() {
        
        let scale = Scale.tile
        let triangle = Triangle(-6, 11, -6)
        let center = triangle.vertex.vector()
        let neighbour = triangle.neighbour(.e0)
        let outside = neighbour.vertex.vector()
        
        #expect(triangle.contains(center,
                                  scale))
        
        #expect(!triangle.contains(.zero,
                                   scale))
        
        #expect(!triangle.contains(outside,
                                   scale))
        
        for corner in triangle.corners {
            
            let vertex = triangle.vertex(corner,
                                         scale)
            
            #expect(triangle.contains(vertex.vector(),
                                      scale))
        }
    }
    
    @Test
    func triangleChunkContainsVector() {
        
        let scale = Scale.chunk
        let triangle = Triangle(-2, 3, -2)
        let center = triangle.transpose(scale,
                                        .tile).vertex.vector()
        let neighbour = triangle.neighbour(.e0)
        let outside = neighbour.transpose(scale,
                                          .tile).vertex.vector()
        
        #expect(triangle.contains(center,
                                  scale))
        
        #expect(!triangle.contains(.zero,
                                   scale))
        
        #expect(!triangle.contains(outside,
                                   scale))
        
        for corner in triangle.corners {
            
            let vertex = triangle.vertex(corner,
                                         scale)
            
            #expect(triangle.contains(vertex.vector(),
                                      scale))
        }
    }
    
    @Test
    func triangleRegionContainsVector() {
        
        let scale = Scale.region
        let triangle = Triangle(-1, 1, -1)
        let center = triangle.transpose(scale,
                                        .tile).vertex.vector()
        let neighbour = triangle.neighbour(.e0)
        let outside = neighbour.transpose(scale,
                                          .tile).vertex.vector()
        
        #expect(triangle.contains(center,
                                  scale))
        
        #expect(!triangle.contains(.zero,
                                   scale))
        
        #expect(!triangle.contains(outside,
                                   scale))
        
        for corner in triangle.corners {
            
            let vertex = triangle.vertex(corner,
                                         scale)
            
            #expect(triangle.contains(vertex.vector(),
                                      scale))
        }
    }
    
    @Test
    func vertexConversion() {
        
        let lhs = Triangle.zero
        let rhs = Triangle.zero
        
        let corner0 = lhs.vertex(.c2)
        let center0 = lhs.vertex.vector()
        let target0 = Vector(corner0)
        let vector0 = center0.lerp(target0, 0.9)
        let result0 = Triangle(vector0)
        
        let corner1 = rhs.vertex(.c1)
        let center1 = rhs.vertex.vector()
        let target1 = Vector(corner1)
        let vector1 = center1.lerp(target1, 0.9)
        let result1 = Triangle(vector1)
        
        #expect(lhs.vertex.vector() == result0.vertex.vector())
        
        #expect(rhs.vertex.vector() == result1.vertex.vector())
    }
    
    @Test
    func closestTileVertex() {
        
        let scale = Scale.tile
        let tile = Triangle(-3, 2, 1)
        
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
        let tile = Triangle(-3, 2, 1)
        
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
        let tile = Triangle(-3, 2, 1)
        
        let center = tile.transpose(scale,
                                    .tile).vertex.vector()
        let vertex = tile.vertex(.c0,
                                 scale)
        
        let vector = center.mid(vertex.vector())
        
        #expect(tile.closest(vertex: vector,
                             scale) == vertex)
    }
    
    // MARK: Pointy / Flat
    
    @Test
    func unitTriangleIsPointy() {
        
        let lhs = Triangle.zero
        let rhs = Triangle(-11, 5, 5)
        
        #expect(lhs.isPointy)
        #expect(!rhs.isPointy)
    }
    
    // MARK: Neighbours
    
    @Test
    func pointyNeighboursAdjacency() {
        
        let triangle = Triangle(-11, 5, 5)
        
        let tiles: OrderedSet<Triangle> = [.init(-10, 5, 5),
                                           .init(-11, 6, 5),
                                           .init(-11, 5, 6)]
        
        let neighbours = OrderedSet(triangle.edges.map {
            
            triangle.neighbour($0)
        })
        
        #expect(neighbours == tiles)
        
        #expect(triangle.adjacent == tiles)
    }
    
    @Test
    func flatNeighboursAdjacency() {
        
        let triangle = Triangle(16, -16, 0)
        
        let tiles: OrderedSet<Triangle> = [.init(15, -16, 0),
                                           .init(16, -17, 0),
                                           .init(16, -16, -1)]
        
        let neighbours = OrderedSet(triangle.edges.map {
            
            triangle.neighbour($0)
        })
        
        #expect(neighbours == tiles)
        
        #expect(triangle.adjacent == tiles)
    }
    
    // MARK: Vertices / Corners
    
    @Test
    func pointyVerticesAndCorners() {
        
        let triangle = Triangle(-5, 10, -5)
        
        let vertices: OrderedSet<Vertex> = [.init(-4, 10, -5),
                                            .init(-5, 11, -5),
                                            .init(-5, 10, -4)]
        
        let triangleCorners = OrderedSet(vertices.map {
            
            triangle.corner($0,
                            .tile)!
        })
        
        let triangleVertices = OrderedSet(triangle.corners.map {
            
            triangle.vertex($0,
                            .tile)
        })
        
        #expect(triangle.isPointy)
        
        #expect(triangleCorners == triangle.corners)
        
        #expect(triangleVertices == vertices)
        
        #expect(triangleVertices == triangle.vertices(.tile))
        
        #expect(triangle.corner(.zero) == nil)
    }
    
    @Test
    func flatVerticesAndCorners() {
        
        let triangle = Triangle(-13, 8, 4)
        
        let vertices: OrderedSet<Vertex> = [.init(-13, 9, 5),
                                            .init(-12, 8, 5),
                                            .init(-12, 9, 4)]
        
        let triangleCorners = OrderedSet(vertices.map {
            
            triangle.corner($0,
                            .tile)!
        })
        
        let triangleVertices = OrderedSet(triangle.corners.map {
            
            triangle.vertex($0,
                            .tile)
        })
        
        #expect(!triangle.isPointy)
        
        #expect(triangleCorners == triangle.corners)
        
        #expect(triangleVertices == vertices)
        
        #expect(triangleVertices == triangle.vertices(.tile))
        
        #expect(triangle.corner(.zero) == nil)
    }
    
    @Test
    func pointyChunkVertices() {
        
        let triangle = Triangle(-4, 4, 0)
        
        let vertices: OrderedSet<Vertex> = [.init(-13, 15, -1),
                                            .init(-17, 19, -1),
                                            .init(-17, 15, 3)]
        
        let triangleVertices = OrderedSet(triangle.corners.map {
            
            triangle.vertex($0,
                            .chunk)
        })
        
        #expect(triangle.isPointy)
        
        #expect(triangleVertices == vertices)
        
        #expect(triangleVertices == triangle.vertices(.chunk))
    }
    
    @Test
    func flatRegionVertices() {
        
        let triangle = Triangle(1, -1, -1)
        
        let vertices: OrderedSet<Vertex> = [.init(11, -5, -5),
                                            .init(27, -21, -5),
                                            .init(27, -5, -21)]
        
        let triangleVertices = OrderedSet(triangle.corners.map {
            
            triangle.vertex($0,
                            .region)
        })
        
        #expect(!triangle.isPointy)
        
        #expect(triangleVertices == vertices)
        
        #expect(triangleVertices == triangle.vertices(.region))
    }
    
    // MARK: Transposing
    
    @Test
    func transposeRegionToTile() {
        
        // Regions at the corner of a region
        let regions: Set<Triangle> = [.init(-1, 0, 0),
                                      .init(-1, 1, 0),
                                      .init(-1, 1, -1),
                                      .init(0, 1, -1),
                                      .init(0, 0, -1),
                                      .zero]
        
        let transposed = regions.transpose(.region,
                                           .tile)
        
        // Tiles in the center of a region
        let tiles: Set<Triangle> = [.init(-11, 5, 5),
                                    .init(-16, 16, 0),
                                    .init(-11, 21, -11),
                                    .init(0, 16, -16),
                                    .init(5, 5, -11),
                                    .zero]
        
        #expect(transposed == tiles)
    }
    
    @Test
    func transposeRegionToChunk() {
        
        // Regions at the corner of a region
        let regions: Set<Triangle> = [.init(-1, 0, 0),
                                      .init(-1, 1, 0),
                                      .init(-1, 1, -1),
                                      .init(0, 1, -1),
                                      .init(0, 0, -1),
                                      .zero]
        
        let transposed = regions.transpose(.region,
                                           .chunk)
        
        // Chunks in the center of a region
        let chunks: Set<Triangle> = [.init(-3, 1, 1),
                                     .init(-4, 4, 0),
                                     .init(-3, 5, -3),
                                     .init(0, 4, -4),
                                     .init(1, 1, -3),
                                     .zero]
        
        #expect(transposed == chunks)
    }
    
    @Test
    func transposeChunkToRegion() {
        
        // Chunks at the corner of a region
        let chunks: Set<Triangle> = [.init(-2, 2, -1),
                                     .init(-2, 3, -1),
                                     .init(-2, 3, -2),
                                     .init(-1, 3, -2),
                                     .init(-1, 2, -2),
                                     .init(-1, 2, -1)]
        
        let transposed = chunks.transpose(.chunk,
                                          .region)
        
        // Regions at the corner of a region
        let regions: Set<Triangle> = [.init(-1, 0, 0),
                                      .init(-1, 1, 0),
                                      .init(-1, 1, -1),
                                      .init(0, 1, -1),
                                      .init(0, 0, -1),
                                      .zero]
        
        #expect(transposed == regions)
    }
    
    @Test
    func transposeChunkToTile() {
        
        // Chunks at the corner of a region
        let chunks: Set<Triangle> = [.init(-2, 2, -1),
                                     .init(-2, 3, -1),
                                     .init(-2, 3, -2),
                                     .init(-1, 3, -2),
                                     .init(-1, 2, -2),
                                     .init(-1, 2, -1)]
        
        let transposed = chunks.transpose(.chunk,
                                          .tile)
        
        // Tiles in the center of a chunk
        let tiles: Set<Triangle> = [.init(-7, 9, -3),
                                    .init(-8, 12, -4),
                                    .init(-7, 13, -7),
                                    .init(-4, 12, -8),
                                    .init(-3, 9, -7),
                                    .init(-4, 8, -4)]
        
        #expect(transposed == tiles)
    }
    
    @Test
    func transposeTileToChunk() {
        
        // Tiles at the corner of a region
        let tiles: Set<Triangle> = [.init(-6, 10, -5),
                                    .init(-6, 11, -5),
                                    .init(-6, 11, -6),
                                    .init(-5, 11, -6),
                                    .init(-5, 10, -6),
                                    .init(-5, 10, -5)]
        
        let transposed = tiles.transpose(.tile,
                                         .chunk)
        
        // Chunks at the corner of a region
        let chunks: Set<Triangle> = [.init(-2, 2, -1),
                                     .init(-2, 3, -1),
                                     .init(-2, 3, -2),
                                     .init(-1, 3, -2),
                                     .init(-1, 2, -2),
                                     .init(-1, 2, -1)]
        
        #expect(transposed == chunks)
    }
    
    @Test
    func transposeTileToRegion() {
        
        // Tiles at the corner of a region
        let tiles: Set<Triangle> = [.init(-6, 10, -5),
                                    .init(-6, 11, -5),
                                    .init(-6, 11, -6),
                                    .init(-5, 11, -6),
                                    .init(-5, 10, -6),
                                    .init(-5, 10, -5)]
        
        let transposed = tiles.transpose(.tile,
                                         .region)
        
        // Regions at the corner of a region
        let regions: Set<Triangle> = [.init(-1, 0, 0),
                                      .init(-1, 1, 0),
                                      .init(-1, 1, -1),
                                      .init(0, 1, -1),
                                      .init(0, 0, -1),
                                      .zero]
        
        #expect(transposed == regions)
    }
    
    // MARK: Sieve
    
    @Test
    func pointyTileSieve() {
        
        let triangle = Triangle.zero
        let sieve = triangle.sieve(.tile)
        
        #expect(sieve.origin == triangle)
        
        #expect(sieve.scale == .tile)
        #expect(sieve.tiles.count == 1)
        #expect(sieve.vertices.count == 3)
        #expect(sieve.tiles.contains(triangle))
    }
    
    @Test
    func flatTileSieve() {
        
        let triangle = Triangle.zero
        let sieve = triangle.sieve(.tile)
        
        #expect(sieve.origin == triangle)
        
        #expect(sieve.scale == .tile)
        #expect(sieve.tiles.count == 1)
        #expect(sieve.vertices.count == 3)
        #expect(sieve.tiles.contains(triangle))
    }
    
    @Test
    func pointyChunkSieve() {
        
        let triangle = Triangle.zero
        let sieve = triangle.sieve(.chunk)
        let tile = triangle.transpose(.chunk,
                                      .tile)
        
        #expect(sieve.origin == triangle)
        
        #expect(sieve.scale == .chunk)
        #expect(sieve.tiles.count == 16)
        #expect(sieve.vertices.count == 15)
        #expect(sieve.tiles.contains(tile))
    }
    
    @Test
    func flatChunkSieve() {
        
        let triangle = Triangle.zero
        let sieve = triangle.sieve(.chunk)
        let tile = triangle.transpose(.chunk,
                                      .tile)
        
        #expect(sieve.origin == triangle)
        
        #expect(sieve.scale == .chunk)
        #expect(sieve.tiles.count == 16)
        #expect(sieve.vertices.count == 15)
        #expect(sieve.tiles.contains(tile))
    }
    
    @Test
    func pointyRegionSieve() {
        
        let triangle = Triangle.zero
        let sieve = triangle.sieve(.region)
        let tile = triangle.transpose(.region,
                                      .tile)
        
        #expect(sieve.origin == triangle)
        
        #expect(sieve.scale == .region)
        #expect(sieve.tiles.count == 256)
        #expect(sieve.vertices.count == 153)
        #expect(sieve.tiles.contains(tile))
    }
    
    @Test
    func flatRegionSieve() {
        
        let triangle = Triangle.zero
        let sieve = triangle.sieve(.region)
        let tile = triangle.transpose(.region,
                                      .tile)
        
        #expect(sieve.origin == triangle)
        
        #expect(sieve.scale == .region)
        #expect(sieve.tiles.count == 256)
        #expect(sieve.vertices.count == 153)
        #expect(sieve.tiles.contains(tile))
    }
}
