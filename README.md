[![Platforms](https://img.shields.io/badge/platforms-iOS%20|%20Mac-lightgray.svg)]()
[![Swift 5.1](https://img.shields.io/badge/swift-5.1-red.svg?style=flat)](https://developer.apple.com/swift)
[![License](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://opensource.org/licenses/MIT)

# Deltille
Deltille is a utility framework designed to encapsulate the mathmatical principles and concepts of a coordinate system defined within a regular tiling of a triangular grid. 

# Implementation
Deltille provides a lightweight wrapper for utility data structures to make it easy to get started working with triangular grids. 

## Triangles
The basic building blocks are both the `Coordinate` and `Triangle` types which are used in conjunction to model equilateral triangle vertex positions along a plane.

```swift
    //create a triangle at the world origin
    let triangle = Grid.Triangle(.zero)
    
    //generate triangle vertices for the desired scale
    let vertices = triangle.corners(for: .chunk)
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

### Examples
[Regolith](https://github.com/zilmarinen/Regolith/) makes usage of the concepts introduced by Deltille to generate meshes for predefined tessellations of a triangle interior using [Ortho-Tiling](https://www.boristhebrave.com/2023/05/31/ortho-tiles/).

[Verdure](https://github.com/zilmarinen/Verdure/) implements additional mesh generation on top of Deltille to create stylised foliage canopies constrained to a triangular grid.

# Installation
To install using Swift Package Manager, add this to the `dependencies:` section in your Package.swift file:

```swift
.package(url: "https://github.com/zilmarinen/Deltille.git", .upToNextMinor(from: "0.1.0")),
```

## Dependencies
[Euclid](https://github.com/nicklockwood/Euclid) is a Swift library for creating and manipulating 3D geometry and is used extensively within this project for mesh generation and vector operations.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
