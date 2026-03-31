# CHANGELOG

## [0.3.0](https://github.com/zilmarinen/Deltille/releases/tag/0.3.0) (12/09/2025)

- Remove `Grid` enum namespace

- Introduce methods for `Hexagon` chunking

- Introduce `.default` property for `Scale`

- Introduce `perimeter` property for `Stencil` 

- Introduce `Tile` methods for distance and proximity

- Introduce `Array` extensions for `Vertex` collections

- Refactor `Rotation` implementation for `Tile`

- Introduce codified `Stencil` subdivisions 

## [0.2.0](https://github.com/zilmarinen/Deltille/releases/tag/0.2.0) (31/08/2025)

- Introduce `Hexagon` type
    - Add `Scale` enum to define hexagon edge lengths

- Introduce `Corner` protocol

- Introduce `Edge` protocol

- Introduce `Rotation` protocol

- Introduce `Scale` protocol

- Introduce `Tile` protocol
    
- Introduce `Vertex` protocol

- Introduce `Sieve` type for triangle subdivisions

- Introduce `Hexagon` unit tests

- Remove `Canopy` enum

- Remove `Kite` enum

- Remove `Septomino` enum

## [0.1.0](https://github.com/zilmarinen/Deltille/releases/tag/0.1.0) (27/05/2024)

- Introduce `Grid` enum namespace
	- Add `Axis` enum to define world axis
	- Add `Scale` enum to define triangle edge lengths

- Introduce `Coordinate` type
	- Add `Corner` enum
	- Add `Edge` enum
	- Add `Rotation` enum

- Introduce `Triangle` type
	- Add `Stencil` type for triangle subdivisions

- Introduce `Footprint` protocol
	- Add `Canopy` enum with wound edge perimeters
	- Add `Septomino` enum with known patterns

- Introduce `Kite` enum
	- Add `Pattern` enum to define `Kite` tessellations

- Introduce `Coordinate` unit tests
- Introduce `Triangle` unit tests
- Introduce `Footprint` unit tests
