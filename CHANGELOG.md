# CHANGELOG

## [0.4.0](https://github.com/zilmarinen/Deltille/releases/tag/0.4.0) (2026-11-26)

- Promote `Coordinate` to a protocol
- Make `Tile` conform to `Coordinate`
- Replace per-tile `Scale` enums with a shared `Scale` enum
- Introduce dual tile associated type for `Tile`
- Introduce `Sieve` protocol
- Introduce `size(for:)` method for `Tile`
- Introduce `OrderedSet` for tile collections
- Introduce `lattice` parameter for scalable vector conversions
- Add `unique` method for `Footprint` tiles
- Reimplement `Rotation` protocol for turn-based rotation
- Refactor `Hexagon` parent/child methods for size-based transposition
- Refactor vertex coordinate conversions for flat / pointy top orientation
- Migrate unit tests from XCTest to Swift Testing
- Remove `Axis` enum
- Add `.swiftformat` config

## [0.3.0](https://github.com/zilmarinen/Deltille/releases/tag/0.3.0) (2026-04-21)

- Remove `Grid` enum namespace
- Introduce `parent` and `child` methods for `Hexagon` chunking
- Introduce `distance` and `disc` methods for `Tile`
- Introduce `.default` property for `Scale`
- Add `conway` case to `Hexagon.Scale`
- Introduce `Stencil` protocol
- Introduce `perimeter` property for `Stencil`
- Introduce codified `Stencil` subdivisions
- Refactor `Sieve` into `Triangle`
- Refactor `Footprint` into a protocol
- Refactor `Rotation` implementation for `Tile`
- Rename `Scale.edgeLength` to `Scale.length`
- Introduce `Array` extensions for `Vertex` and `Triangle` collections
- Remove path and meshing methods

## [0.2.0](https://github.com/zilmarinen/Deltille/releases/tag/0.2.0) (2025-08-31)

- Introduce `Hexagon` type conforming to `Tile`
  - Add `Scale` enum to define hexagon edge lengths
- Introduce `Tile` protocol
- Introduce `Vertex` protocol
- Promote `Corner`, `Edge`, `Rotation` and `Scale` to protocols
- Introduce `Sieve` type for triangle subdivisions
- Refactor `Triangle` to conform to `Tile`
- Refactor `Footprint` into a generic class
- Move `Coordinate` into `Grid` namespace
- Introduce `Hexagon` unit tests
- Remove `Canopy` enum
- Remove `Kite` enum
- Remove `Septomino` enum

## [0.1.0](https://github.com/zilmarinen/Deltille/releases/tag/0.1.0) (2024-05-27)

- Introduce `Grid` enum namespace
  - Add `Axis` enum to define world axes
  - Add `Scale` enum to define triangle edge lengths
- Introduce `Coordinate` type
  - Add `Rotation` enum to define rotation directions
- Introduce `Triangle` type
  - Add `Corner` and `Edge` enums
  - Add `Stencil` type for triangle subdivisions
  - Add `Kite` enum with `Pattern` tessellations
- Introduce `Footprint` type
- Add `Canopy` enum with wound coordinate loops
- Add `Septomino` enum with seven-triangle figures
- Introduce unit tests for `Coordinate`, `Triangle` and `Footprint`
