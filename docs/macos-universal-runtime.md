# macOS Universal Runtime Guide

This guide builds the FMI4j native importer for both Apple Silicon and Intel
macOS, then combines both slices into one universal dylib.

## Requirements

- macOS with Xcode Command Line Tools.
- JDK installed locally.
- `clang++`.
- `lipo`.

Check tools:

```bash
xcode-select -p
clang++ --version
/usr/libexec/java_home -V
```

## Build

From the repository root:

```bash
scripts/build-macos-universal.sh
```

The script writes:

```text
build/native/macos/arm64/fmi4j-import.dylib
build/native/macos/x86_64/fmi4j-import.dylib
build/native/macos/universal/fmi4j-import.dylib
```

## Verify

```bash
lipo -info build/native/macos/universal/fmi4j-import.dylib
file build/native/macos/universal/fmi4j-import.dylib
```

Expected result:

```text
Architectures in the fat file: fmi4j-import.dylib are: x86_64 arm64
```

## Package Into Runtime JAR

```bash
scripts/package-runtime-jar.sh build/native/macos/universal/fmi4j-import.dylib
```

The script copies the dylib into:

```text
fmi-import/src/main/resources/native/fmi/darwin64/fmi4j-import.dylib
```

and builds the project with Gradle.

