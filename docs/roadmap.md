# Roadmap

This fork starts from the archived FMI4j codebase and focuses on the native
runtime problem that affects real JVM deployments of FMI co-simulation projects.

Maintainer:

- **Generoso Lombardi** - creator and technical director of the SinergIA project

## Goals

1. Keep the original FMI4j import API usable for existing projects.
2. Provide reproducible builds of the JNI native importer runtime.
3. Package native runtime binaries in a way that works from Maven/Gradle without
   manual local patches.
4. Add small examples that prove the runtime can load and run FMI 2.0
   Co-Simulation FMUs.
5. Document the platform and architecture expectations clearly.

## Target Platforms

| Platform | Architecture | Runtime folder | Priority |
| --- | --- | --- | --- |
| macOS | arm64 | `native/fmi/darwin64` | High |
| macOS | x86_64 | `native/fmi/darwin64` | High |
| macOS | universal arm64+x86_64 | `native/fmi/darwin64` | High |
| Windows | x86_64 | `native/fmi/win64` | High |
| Linux | x86_64 | `native/fmi/linux64` | High |
| Linux | arm64 | `native/fmi/linux-aarch64` or agreed folder | High |

The original runtime loader currently expects established folder names such as
`darwin64`, `win64`, and `linux64`. Linux ARM64 needs a clear naming decision
before publication.

## First Milestone

- macOS universal `fmi4j-import.dylib`.
- Repackaged runtime JAR containing macOS, Windows, and Linux native libraries.
- Documentation for verifying architecture slices with `lipo` and `file`.
- Minimal JVM example that loads an FMI 2.0 Co-Simulation FMU.

## Second Milestone

- CI build matrix for macOS, Windows, and Linux.
- Linux ARM64 build documentation and, if possible, CI coverage.
- Published release artifact.

## Non-Goals For The First Milestone

- Rewriting FMI4j internals.
- Changing the public Java/Kotlin API.
- Adding new FMI standard features.
- Replacing the JNI implementation with JNA.
