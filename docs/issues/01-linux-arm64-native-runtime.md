# Add Linux ARM64 native runtime build

## Title

```text
Add Linux ARM64 native runtime build
```

## Body

```text
The fork should support Linux ARM64 as a first-class target for JVM FMU import.

Tasks:
- Decide the runtime resource folder name for Linux ARM64.
- Build libfmi4j-import.so for aarch64.
- Verify the runtime loader can resolve the Linux ARM64 native library.
- Document build requirements.
- Add the artifact to the runtime JAR packaging process.

Target outcome:
- Java applications running on Linux ARM64 can load FMI4j without manual native runtime patching.
```

