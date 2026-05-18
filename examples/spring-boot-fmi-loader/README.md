# Spring Boot FMI Loader Example

This directory is reserved for a minimal Spring Boot example that proves the
runtime JAR can load and initialize an FMI 2.0 Co-Simulation FMU.

Maintainer: **Generoso Lombardi**.

Planned scope:

- Java 21.
- Spring Boot.
- Load FMU from classpath.
- Print Java runtime architecture.
- Print FMI4j native runtime path.
- Initialize the FMU.
- Execute one `doStep`.

The example should stay intentionally small so it can be used as a smoke test
for every published runtime artifact.
