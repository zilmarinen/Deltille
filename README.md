[![Platforms](https://img.shields.io/badge/platforms-iOS%20|%20Mac-lightgray.svg)]()
[![Swift 6.1](https://img.shields.io/badge/swift-6.1-red.svg?style=flat)](https://developer.apple.com/swift)
[![Swift Package Manager](https://img.shields.io/badge/Swift_Package_Manager-compatible-red?style=flat)](https://www.swift.org/documentation/package-manager/)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](https://opensource.org/licenses/MIT)

- [Introduction](#deltille)
- [Installation](#installation)
- [Implementation](#implementation)
- [Examples](#examples)
- [Credits](#credits)

# Deltille
Deltille is a Swift library for working with hexagonal and triangular grid systems. It provides robust data structures and utilities to make grid based development simple, accurate and efficient.

Hexagonal and triangular grids are deeply related through duality:

- Every hexagonal grid can be subdivided into equilateral triangles forming a triangular grid.
- Conversely; The dual graph of a triangular grid is a hexagonal grid and vice versa.
- This makes them complementary representations of the same underlying space. You can often solve problems easily by switching between them.

By supporting both grid types in a unified API, Deltille lets you take advantage of this relationship making it easier to build flexible systems for geometry, navigation, or procedural generation.

## Features
- Hexagonal & Triangular Grids:
  - Unified support for both coordinate systems with consistent APIs.
  - Models both grid space and dual grid representations.
- Coordinate Conversion:
  - Easily convert between 2D Cartesian coordinates and 3D hexagonal grid coordinates.
  - Seamless bridging between triangle and hexagon grid spaces.
- Neighbour & Vertex Navigation:
  - Convenient methods for traversing edge neighbours and corner vertices.
  - Determine Manhattan distance between tiles in grid space.
- Scaling & Transformations:
  - Built-in support for scaling grid space and handling math such as subdivision and tessellation.
  - Effortless rotation and intersection of triangle and hexagonal footprints.
- Composable API:
  - Designed to integrate cleanly into games, simulations and visualization tools.
- Unit Tested:
  - Backed by a robust suite of unit tests covering all common use cases.

# Installation
To install using Swift Package Manager, add this to the `dependencies:` section in your Package.swift file:

```swift
.package(url: "https://github.com/zilmarinen/Deltille.git", branch: "main"),
```

## Dependencies
[Euclid](https://github.com/nicklockwood/Euclid) is a Swift library for creating and manipulating 3D geometry and is used extensively within this project for mesh generation and vector operations.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

# Implementation
Deltille defines a `Tile` archetype to which both `Triangle` and `Hexagon` conform to provide high level utility methods for grid based operations. Each `Tile` type defines a `Vertex` array which represents positions in grid space.

## Triangles & Hexagons
Both `Triangle` and `Hexagon` `Tile` types can be used to model vertex positions along the `xz` plane.

```swift
// MARK: Triangle
let triangle = Triangle.zero
    
let adjacent = Triangle(0, 1, -1)
```

```swift
// MARK: Hexagon
let hexagon = Hexagon.zero

let adjacent = Hexagon(0, 1, -1)
```

## Vertices
Vertices are the basic building blocks for defining `Tile` types. Vertices define the perimeter of a tile and their relationships between neighbouring tiles and vertices. 

```swift
// MARK: Vertex
let triangle = Triangle.zero

//explore neighbouring tiles
let tiles = triangle.adjacent

//gather corner vertex
let vertex = triangle.vertex(.c0)

//explore neighbouring vertices
let vertices = vertex.vertices
```  

## Scales
Vertices can be translated to and from constrained grid sizes using the `Scale` types.

```swift
// MARK: Triangle
//calculate tile vertices for the desired scale
let vertices = triangle.vertices.position(.tile)

// MARK: Hexagon
//calculate tile vertex for the desired scale
let vertices = hexagon.vertex.position(.chunk)
``` 

## Stencils & Sieves
Both a `Stencil` or `Sieve` can be used to subdivide a triangle into individual sub-triangles mapped to a specific grid scale.
 - `Stencil` defines a discrete set of subdivided triangles and their vertices in world space.
 - `Sieve` calculates a dynamic range of subdivided triangles and their vertices in grid space.

```swift
// MARK: Stencil
let stencil = triangle.stencil(.tile)

//gather perimeter vertices
let vertices = stencil.perimeter

//stencil vertex in world space
let vector = stencil.vertex(.center)
```

```swift
//MARK: Sieve
let sieve = triangle.sieve(for: .chunk)

//sub divided triangles in grid space
let triangles = sieve.tiles

//triangle vertices in grid space
let vertices = sieve.vertices
```

## Rotations
A `Tile` `Rotation` encodes a sequence of fixed step turns around the world origin, wrapped to a non-negative value.

```swift
//MARK: Triangle
let rotated = triangle.rotate(.clockwise)

// MARK: Hexagon
let rotated = hexagon.rotate(.counterClockwise)

```

## Footprints
A `Footprint` defines a collection of tiles which can be intersected and rotated around a given origin.

```swift
//MARK: Footprint
let coordinates: [Coordinate] = [.zero,
                                 -.unitX,
                                 -.unitY,
                                 -.unitZ]

let footprint = Triangle.Footprint(.zero,
                                   coordinates)

//rotate footprint around its origin
let rotated = footprint.rotate(.init(turns: -1)) //wrapped to a non-negative value

//explore footprint perimeter
let perimeter = rotated.perimeter
```

# Examples
[Regolith](https://github.com/zilmarinen/Regolith/) makes use of the concepts introduced by Deltille to generate meshes for predefined tessellations of a triangle interior using [Ortho-Tiling](https://www.boristhebrave.com/2023/05/31/ortho-tiles/).

[Verdure](https://github.com/zilmarinen/Verdure/) implements additional mesh generation on top of Deltille to create stylised foliage canopies constrained to a triangular grid.

# Credits

The Deltille framework is primarily the work of [Zack Brown](https://github.com/zilmarinen).

Special thanks go to;

- [Boris the Brave](https://www.boristhebrave.com) for his extensive articles on grid systems, dual contouring, marching cubes, ortho-tiling and so much more.
- [Oskar Stalberg](https://t.co/qakKgmxfai) for inspiring posts on procedural generation, wave function collapse and dual grid systems.
- [Amit Patel](https://www.redblobgames.com) for stimulating deep dives into hexagonal grids, coordinate systems, grid edge classifications and graph theory.
