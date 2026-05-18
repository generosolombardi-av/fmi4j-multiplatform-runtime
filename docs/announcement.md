# Announcement and Outreach Text

## Message To Lars Ivar

```text
Dear Lars Ivar,

I have created the community continuation fork here:

https://github.com/generosolombardi-av/fmi4j-multiplatform-runtime

The first published work focuses on multiplatform native runtime support, starting with a macOS universal FMI4j importer runtime for both arm64 and x86_64.

If you are comfortable with it, could you add a short note or link in the archived FMI4j repository pointing users to this community continuation fork?

Thank you again for creating FMI4j and for your reply.

Best regards,

Generoso Lombardi
```

## LinkedIn Post

```text
I have started a community continuation of FMI4j focused on multiplatform native runtime support for Java/JVM FMU import.

FMI4j is a very useful JVM library for working with Functional Mock-up Units (FMUs), but modern deployments increasingly need native runtime support across multiple CPU architectures and operating systems.

The initial focus of this fork is:
- macOS Apple Silicon / ARM64
- macOS Intel / x86_64
- macOS universal runtime binaries
- Windows x86_64
- Linux x86_64
- Linux ARM64 in the short term

This work comes from my SinergIA digital twin project, where I am integrating FMI 2.0 Co-Simulation FMUs with Java/Spring Boot for industrial digital twins.

Repository:
https://github.com/generosolombardi-av/fmi4j-multiplatform-runtime

The goal is simple: make FMI4j easier to use in real JVM projects without requiring every developer to manually rebuild or patch native runtime libraries for their platform.
```

