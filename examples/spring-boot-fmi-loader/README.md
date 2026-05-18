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
binaries/linux64/<modelIdentifier>.so
binaries/aarch64-linux-gnu/<modelIdentifier>.so
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

Until this fork is published to Maven Central, install the runtime artifact into
your local Maven repository and use the coordinates configured in `pom.xml`.

The example intentionally stays small so it can be used as a repeatable smoke
test for every published runtime artifact.

