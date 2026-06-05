# Maven Central Publication

This fork is prepared for publication on Maven Central through the Sonatype
Central Portal OSSRH Staging API.

## Coordinates

Once published to Maven Central, applications can consume the runtime without a
custom Maven repository and without GitHub Packages credentials:

```xml
<dependency>
  <groupId>io.github.generosolombardi-av.fmi4j</groupId>
  <artifactId>fmi-import</artifactId>
  <version>0.38.0-multiplatform.6</version>
</dependency>
```

`fmi-import` depends on `fmi-md`, so Maven or Gradle will resolve the model
description library transitively.

## Required GitHub Secrets

The workflow `.github/workflows/publish-maven-central.yml` expects these
repository secrets:

```text
CENTRAL_USERNAME
CENTRAL_PASSWORD
SIGNING_KEY
SIGNING_PASSWORD
SIGNING_KEY_ID
```

`CENTRAL_USERNAME` and `CENTRAL_PASSWORD` are the Sonatype Central Portal user
token credentials, not the browser login password.

`SIGNING_KEY` is the ASCII-armored private GPG key block. `SIGNING_PASSWORD` is
the passphrase for that key.

## Publish Flow

1. Verify that `VERSION` contains the release version.
2. Verify that `build.gradle` uses the Central namespace group id.
3. Run the GitHub Actions workflow `Publish Maven Central` manually.
4. The workflow uploads `fmi-md` and `fmi-import` to the Central Portal staging
   repository.
5. The workflow asks Central Portal to publish the staged deployment
   automatically.
6. After Central completes validation and synchronization, the artifacts become
   available from Maven Central.

Maven Central artifacts are immutable. If a version is published with a mistake,
do not overwrite it. Release a new patch version instead.
