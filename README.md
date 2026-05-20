# FMI4j Multiplatform Runtime

This repository is a community continuation of
[NTNU-IHB/FMI4j](https://github.com/NTNU-IHB/FMI4j), with a practical focus on
keeping the FMI4j import runtime usable in modern JVM applications across
multiple native platforms.

The original FMI4j project has been archived by its author. This fork keeps the
original codebase and license intact, while adding reproducible native runtime
builds, packaging notes, and examples for current Java/Spring Boot digital twin
projects.

Fork maintainer:

- **Generoso Lombardi** - creator and technical director of the SinergIA project

Initial maintenance focus:

- macOS ARM64
- macOS x86_64
- macOS universal `darwin64` runtime
- Windows x86_64
- Windows ARM64
- Linux x86_64
- Linux ARM64

The first concrete goal is to make the `fmi-import` native JNI library available
for the architectures above without requiring each user to patch the runtime JAR
manually.

## Current Status

| Area | Status |
| --- | --- |
| Original FMI4j import API | Preserved |
| Original FMI4j model description API | Preserved |
| macOS ARM64 native runtime | Documented, script foundation added |
| macOS x86_64 native runtime | Documented, script foundation added |
| macOS universal runtime | Documented, script foundation added |
| Windows x86_64 runtime | Existing upstream support, to be repackaged |
| Windows ARM64 runtime | Verified native runtime included |
| Linux x86_64 runtime | Existing upstream support, to be repackaged |
| Linux ARM64 runtime | Verified native runtime included |
| Maven Central publication | Planned |
| Example JVM/Spring Boot FMU loader | Added |

## Documentation Added By This Fork

- [Native runtime build guide](docs/native-runtime-build.md)
- [macOS universal runtime guide](docs/macos-universal-runtime.md)
- [Linux ARM64 runtime guide](docs/linux-arm64-runtime.md)
- [Windows ARM64 runtime guide](docs/windows-arm64-runtime.md)
- [GitHub Packages publication guide](docs/github-packages.md)
- [Roadmap](docs/roadmap.md)
- [GitHub repository setup checklist](docs/github-repository-setup.md)
- [Announcement and outreach text](docs/announcement.md)

## Scripts Added By This Fork

- `scripts/build-macos-universal.sh`
- `scripts/package-runtime-jar.sh`
- `scripts/build-linux-aarch64.sh`
- `scripts/build-windows-arm64.bat`

The scripts are intentionally small and explicit. They are meant to make the
native runtime packaging process inspectable before it is automated further with
CI.

## Recommended GitHub Topics

```text
fmi
fmu
fmi4j
fmi-standard
fmi2
co-simulation
java
kotlin
jni
digital-twin
openmodelica
macos-arm64
apple-silicon
multiplatform
linux-arm64
linux-aarch64
windows-arm64
windows-aarch64
```

## Original FMI4j README

The original project description follows.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/NTNU-IHB/FMI4j/issues)

[![CI](https://github.com/NTNU-IHB/FMI4j/workflows/Build/badge.svg)](https://github.com/NTNU-IHB/FMI4j/actions)
[![Gitter](https://badges.gitter.im/NTNU-IHB/FMI4j.svg)](https://gitter.im/NTNU-IHB/FMI4j?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)


FMI4j is a software package for dealing with Functional Mock-up Units (FMUs) on the Java Virtual Machine (JVM), written in [Kotlin](https://kotlinlang.org/). 

FMI4j supports import of both [FMI](http://fmi-standard.org/) 1.0 and 2.0 for **Co-simulation**. For  **Model Exchange** version 2.0 is supported. <br/>

Compared to other FMI libraries targeting the JVM, FMI4j is **considerably faster** due to the fact that we use JNI instead of JNA. 
Considering FMI-import, a significant speedup (2-5x) compared to other open-source FMI implementations for the JVM should be expected. 

Maven artifacts are available through [Central](https://search.maven.org/search?q=g:info.laht.fmi4j)

***

### <a name="api"></a> FMI import

```java

class Demo {
    
    void main(String[] args) {
        
        Fmu fmu = Fmu.from(new File("path/to/fmu.fmu")); //URLs are also supported
        FmuSlave slave = fmu.asCoSimulationFmu().newInstance();

        slave.simpleSetup();
        
        double t = 0;
        double stop = 10;
        double stepSize = 1.0/100;
        while(t <= stop) {
            if (!slave.doStep(t, stepSize)) {
                break;
            }
            t += stepSize;
        }
        slave.terminate(); //or close, try with resources is also supported
        fmu.close();
        
    }
    
}
```

Would you rather build FMUs using a JVM language? Check out [FMU4j](https://github.com/markaren/FMU4j)! <br>
Or maybe build FMUs using Python? Check out [PythonFMU](https://github.com/NTNU-IHB/PythonFMU)! <br>
Or would you rather simulate FMUs using C++? Check out [FMI4cpp](https://github.com/NTNU-IHB/FMI4cpp)! <br>
Need to distribute your FMUs? [FMU-proxy](https://github.com/NTNU-IHB/FMU-proxy) to the rescue! <br>
Need a complete co-simulation framework with SSP support? Check out [Vico](https://github.com/NTNU-IHB/Vico) <br>
