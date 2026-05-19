# Windows ARM64 Runtime Guide

Windows ARM64 support has two separate native pieces:

1. the FMI4j JNI importer runtime;
2. the FMU model binary itself.

Both must match the running JVM architecture. A Windows ARM64 JDK needs a
Windows ARM64 `fmi4j-import.dll`.

## FMI4j Runtime Folder

This fork uses the following runtime resource folder for Windows ARM64:

```text
native/fmi/win-arm64/fmi4j-import.dll
```

The runtime loader maps:

```text
os.name = Windows
os.arch = aarch64 or arm64
```

to:

```text
win-arm64
```

## FMU Binary Folders

For FMU model binaries, the loader tries:

```text
binaries/win-arm64/<modelIdentifier>.dll
binaries/win64/<modelIdentifier>.dll
```

The first existing file wins. For a native Windows ARM64 JVM, the FMU model
binary should also be compiled for ARM64.

## Native Build

The verified Windows ARM64 DLL included in this fork was built on Windows ARM64
with Microsoft Visual C++ ARM64 tools and Microsoft OpenJDK 17.

Manual build summary from a Visual Studio ARM64 developer prompt:

```bat
set JAVA_HOME=C:\Program Files\Microsoft\jdk-17.0.19.10-hotspot
set PATH=%JAVA_HOME%\bin;%PATH%
cd %USERPROFILE%\Desktop\fmi4j-multiplatform-runtime
scripts\build-windows-arm64.bat
```

Verify the binary architecture:

```bat
dumpbin /headers build\native\win-arm64\fmi4j-import.dll | findstr machine
```

The verified Windows ARM64 runtime included in this fork reports:

```text
AA64 machine (ARM64)
```
