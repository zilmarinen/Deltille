[![Platforms](https://img.shields.io/badge/platforms-iOS%20|%20Mac-lightgray.svg)]()
[![Swift 5.1](https://img.shields.io/badge/swift-5.1-red.svg?style=flat)](https://developer.apple.com/swift)
[![License](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://opensource.org/licenses/MIT)

- [Introduction](#deltille)
- [Installation](#installation)
- [Implementation](#implementation)
- [Examples](#examples)
- [Credits](#credits)

# Deltille
Deltille is a utility framework designed to encapsulate the mathematical principles and concepts of a coordinate system defined within a regular tiling of a triangular grid. 

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
Deltille is a lightweight wrapper for the base utility data structures required to get started working with triangular grids. By constraining triangles to a fixed `Grid`, it is possible to generate triangle vertices for any given `Scale` by leveraging the natural geometric properties of triangle subdivision. 

## Triangles
The basic building blocks of Deltille are both the `Coordinate` and `Triangle` types which are used together to model equilateral triangle vertex positions along a plane.

```swift
let triangle = Grid.Triangle(.zero)
    
//generate triangle vertices for the desired scale
let vertices = triangle.corners(for: .chunk)
```

## Hexagons
Complimentary to the `Triangle` grid is the dual `Hexagon` and `Coordinate` types which can be used to model regular hexagon vertex positions along a plane.

```swift
let hexagon = Grid.Hexagon(.unitZ)

//generate hexagon vertices
```

## Stencils
A `Stencil` can be used to subdivide a triangle into individual sub-triangles mapped to a specific grid scale.  

```swift    
//subdivide into stencil components
let stencil = triangle.stencil(for: .tile)
    
//grab the stencil center
let vertex = stencil.vertex(for: .center)
```

## Footprints
A `Footprint` defines a collection of triangles centered around a given origin.

```swift
//define a collection of triangle coordinates
let septomino = Grid.Septomino.asterope
    
//create a footprint    
let footprint = Footprint(origin: .zero,
                          coordinates: septomino.coordinates)
    
//rotate footprint around its origin
let rotated = footprint.rotate(rotation: .clockwise)
```

# Examples
[Regolith](https://github.com/zilmarinen/Regolith/) makes usage of the concepts introduced by Deltille to generate meshes for predefined tessellations of a triangle interior using [Ortho-Tiling](https://www.boristhebrave.com/2023/05/31/ortho-tiles/).

[Verdure](https://github.com/zilmarinen/Verdure/) implements additional mesh generation on top of Deltille to create stylised foliage canopies constrained to a triangular grid.

# Credits

The Deltille framework is primarily the work of [Zack Brown](https://github.com/zilmarinen).

Special thanks go to;

- [Boris the Brave](https://www.boristhebrave.com) for his extensive articles on grid systems, dual contouring, marching cubes, ortho-tiling and so much more.
- [Oskar Stalberg](https://t.co/qakKgmxfai) for inspiring posts on procedural generation and wave function collapse.
- [Amit Patel](https://www.redblobgames.com) for stimulating deep dives into hexagonal grids, coordinate systems, 
grid edge classifications and graph theory.
