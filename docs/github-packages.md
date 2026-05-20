# GitHub Packages Publication

This fork publishes the JVM artifacts to GitHub Packages before Maven Central.
That keeps the first public distribution close to the repository and avoids
manual local JAR patches.

## Coordinates

```xml
<dependency>
  <groupId>io.github.generosolombardi.fmi4j</groupId>
  <artifactId>fmi-import</artifactId>
  <version>0.38.0-multiplatform.5</version>
</dependency>
```

`fmi-import` depends on `fmi-md`, so normal Maven/Gradle resolution will pull it
transitively.

## Maven Repository

GitHub Packages Maven repositories generally require authentication, even for
public packages. Configure the repository in `pom.xml`:

```xml
<repositories>
  <repository>
    <id>github</id>
    <url>https://maven.pkg.github.com/generosolombardi-av/fmi4j-multiplatform-runtime</url>
  </repository>
</repositories>
```

Then add credentials in `~/.m2/settings.xml`:

```xml
<settings>
  <servers>
    <server>
      <id>github</id>
      <username>YOUR_GITHUB_USERNAME</username>
      <password>YOUR_GITHUB_TOKEN_WITH_READ_PACKAGES</password>
    </server>
  </servers>
</settings>
```

## Gradle Repository

```groovy
repositories {
    mavenCentral()
    maven {
        url = uri("https://maven.pkg.github.com/generosolombardi-av/fmi4j-multiplatform-runtime")
        credentials {
            username = findProperty("gpr.user") ?: System.getenv("GITHUB_ACTOR")
            password = findProperty("gpr.key") ?: System.getenv("GITHUB_TOKEN")
        }
    }
}

dependencies {
    implementation "io.github.generosolombardi.fmi4j:fmi-import:0.38.0-multiplatform.5"
}
```

## Publishing

The workflow `.github/workflows/publish-github-packages.yml` publishes `fmi-md`
and `fmi-import` when a `v*` tag is pushed, or manually through
`workflow_dispatch`.

Manual local command:

```bash
./gradlew clean :fmi-md:publish :fmi-import:publish \
  -PskipBuildNative=true \
  -PpublishToGitHubPackages=true \
  -Pgpr.user="$GITHUB_ACTOR" \
  -Pgpr.key="$GITHUB_TOKEN"
```
