# AGENTS.md

Instructions for AI coding agents working in this repository.
Keep this file short: it is sent with every request.

## Project

Deltille is a Swift library for working with hexagonal and triangular grid systems.
Platforms: iOS 15+, macOS 17+ (see `Package.swift`).

## Layout

- `Package.swift` — package manifest. Swift tools version 6.x.
- `Sources/Deltile/` — library code. Public API lives here.
- `Tests/DeltilleTests/` — tests, mirroring the `Sources` structure.

## Commands

Run all commands from the repository root (the folder containing `Package.swift`).

- Build: `swift build`
- Test everything: `swift test`
- Lint: `swift format lint --recursive Sources Tests`

Never edit or delete anything in `.build/`.

## Code conventions

- Swift 6 language mode with strict concurrency. Fix data-race errors properly; do not silence them with `@unchecked Sendable` or `nonisolated(unsafe)` unless asked.
- Prefer value types (`struct`, `enum`) over classes. Use `actor` for shared mutable state.
- Use `async`/`await`; do not add completion-handler APIs.
- Mark types and members `public` only when they are part of the intended API.
- Every `public` declaration has a `///` doc comment.
- No force unwraps (`!`) or `try!` outside tests.

## Tests

- Use Swift Testing (`import Testing`, `@Test`, `#expect`, `#require`), not XCTest.
- Every bug fix gets a test that fails before the fix.
- Every new public API gets at least one test.
- Tests must not touch the network or real file locations; use in-memory fakes.
- If the same test still fails after two different fix attempts, stop. Summarise what you tried and what you think the cause is, and ask for guidance.
- Never retry a fix you have already tried.
- To investigate a failing test, run only that test.

## Workflow for a change

1. Read the relevant files before editing.
2. Make the smallest change that solves the task.
3. Run `swift build`, then the relevant `swift test --filter ...`.
4. Fix any errors or warnings you introduced, then run the full `swift test`.
5. Run the lint command.
6. Summarise what changed and why, listing the files touched.

## Do not

- Add, remove or upgrade dependencies in `Package.swift` without asking first.
- Edit `Package.resolved` by hand.
- Change existing `public` API signatures without asking first.
- Delete or skip failing tests to make the suite pass.
- Run `git commit`, `git push` or anything that rewrites history.

## Definition of done

`swift build` succeeds with no new warnings, `swift test` passes, lint is clean,
and the summary explains the change.
