# Add GitHub Actions multiplatform build matrix

## Title

```text
Add GitHub Actions multiplatform build matrix
```

## Body

```text
Add a CI matrix for building and verifying the native runtime on multiple operating systems.

Initial matrix:
- macOS latest
- Ubuntu latest
- Windows latest

Tasks:
- Build JVM modules.
- Build native runtime where possible.
- Upload native runtime artifacts.
- Verify macOS universal dylib architecture with lipo.
- Keep workflow output readable for contributors.

Target outcome:
- Runtime builds become reproducible and verifiable from GitHub Actions.
```

