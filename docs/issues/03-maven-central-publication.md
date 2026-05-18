# Prepare Maven Central publication

## Title

```text
Prepare Maven Central publication
```

## Body

```text
Prepare the fork for publication as a Maven artifact that can be consumed directly by Java/Kotlin projects.

Tasks:
- Decide groupId and artifactId.
- Preserve compatibility with existing FMI4j users where possible.
- Add POM metadata.
- Add source and javadoc JAR tasks.
- Add signing/release process.
- Document usage from Maven and Gradle.

Target outcome:
- Users can depend on the multiplatform runtime from Maven/Gradle without local repository workarounds.
```

