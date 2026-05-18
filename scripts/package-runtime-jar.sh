#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DYLIB_PATH="${1:-$ROOT_DIR/build/native/macos/universal/fmi4j-import.dylib}"
TARGET_DIR="$ROOT_DIR/fmi-import/src/main/resources/native/fmi/darwin64"

if [[ ! -f "$DYLIB_PATH" ]]; then
  echo "Missing dylib: $DYLIB_PATH" >&2
  exit 1
fi

mkdir -p "$TARGET_DIR"
cp "$DYLIB_PATH" "$TARGET_DIR/fmi4j-import.dylib"

if command -v lipo >/dev/null 2>&1; then
  lipo -info "$TARGET_DIR/fmi4j-import.dylib" || true
fi

cd "$ROOT_DIR"
./gradlew clean :fmi-import:jar -PskipBuildNative=true

echo "Built: $ROOT_DIR/fmi-import/build/libs"

