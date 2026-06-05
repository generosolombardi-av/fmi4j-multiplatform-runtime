# Spring Boot FMI Loader Example

Minimal Spring Boot smoke test for the FMI4j runtime.

Maintainer: **Generoso Lombardi**.

The example:

- prints Java OS/architecture details at startup;
- loads an FMI 2.0 Co-Simulation FMU from the classpath;
- exposes a status endpoint;
- initializes the FMU;
- executes one `doStep`.

## Prepare The FMU

Place a test FMU here:

```text
src/main/resources/fmu/sample.fmu
```

The FMU must contain a native binary compatible with the running platform.

Examples:

```text
binaries/darwin64/<modelIdentifier>.dylib
binaries/win64/<modelIdentifier>.dll
binaries/win-arm64/<modelIdentifier>.dll
binaries/linux64/<modelIdentifier>.so
binaries/aarch64-linux-gnu/<modelIdentifier>.so
binaries/linux-aarch64/<modelIdentifier>.so
```

## Run

```bash
mvn spring-boot:run
```

## API

Status:

```bash
curl -i http://localhost:8080/fmi/status
```

Initialize:

```bash
curl -i -X POST http://localhost:8080/fmi/init
```

Step:

```bash
curl -i -X POST "http://localhost:8080/fmi/step?size=1.0"
```

## Dependency Note

This example uses the fork coordinates prepared for Maven Central:

```text
io.github.generosolombardi-av.fmi4j:fmi-import
```

Maven Central publication does not require a custom repository entry in the
consumer `pom.xml`. See `docs/maven-central.md` in the repository root.

The example intentionally stays small so it can be used as a repeatable smoke
test for every published runtime artifact.
