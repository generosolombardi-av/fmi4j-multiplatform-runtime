# Native Runtime Build Guide

FMI4j uses JNI for performance. This means the Java/Kotlin JAR is not enough by
itself: a native library must be available for the operating system and CPU
architecture of the running JVM.

For example:

- macOS ARM JDK needs an arm64 `fmi4j-import.dylib`.
- macOS Intel or Rosetta JDK needs an x86_64 `fmi4j-import.dylib`.
- Windows x86_64 JDK needs a `fmi4j-import.dll`.
- Linux x86_64 JDK needs a `libfmi4j-import.so`.
- Linux ARM64 JDK needs an ARM aarch64 `libfmi4j-import.so`.

## Source Files

The native importer is built from:

```text
fmi-native-import/src/main/cpp/fmi1/fmi1.cpp
fmi-native-import/src/main/cpp/fmi2/fmi2.cpp
```

and their local headers.

## Output Locations

The runtime JAR should contain native libraries under:

```text
fmi-import/src/main/resources/native/fmi/
  darwin64/fmi4j-import.dylib
  linux64/libfmi4j-import.so
  linux-aarch64/libfmi4j-import.so
  win64/fmi4j-import.dll
```

The macOS `darwin64` file can be a universal binary containing both `arm64` and
`x86_64` slices.

## macOS Manual Build Summary

Use the macOS guide for full details:

```text
docs/macos-universal-runtime.md
```

At a high level:

1. Compile arm64 dylib with `clang++ -arch arm64`.
2. Compile x86_64 dylib with `clang++ -arch x86_64`.
3. Merge them with `lipo -create`.
4. Copy the result to `native/fmi/darwin64/fmi4j-import.dylib`.
5. Rebuild or repackage the runtime JAR.

## Verification Commands

macOS:

```bash
lipo -info fmi4j-import.dylib
file fmi4j-import.dylib
```

Linux:

```bash
file libfmi4j-import.so
```

Linux ARM64:

```bash
scripts/build-linux-aarch64.sh
file build/native/linux-aarch64/libfmi4j-import.so
```

Expected architecture string:

```text
ELF 64-bit LSB shared object, ARM aarch64
```

Windows:

```powershell
dumpbin /headers fmi4j-import.dll
```
