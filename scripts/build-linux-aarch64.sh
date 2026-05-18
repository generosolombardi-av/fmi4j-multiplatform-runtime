#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC_DIR="$ROOT_DIR/fmi-native-import/src/main/cpp"
BUILD_DIR="$ROOT_DIR/build/native/linux-aarch64"
JAVA_HOME="${JAVA_HOME:-}"

if [[ -z "$JAVA_HOME" ]]; then
  echo "JAVA_HOME must be set to a Linux ARM64 JDK." >&2
  exit 1
fi

mkdir -p "$BUILD_DIR"

clang++ \
  -std=c++11 \
  -shared \
  -O2 \
  -fPIC \
  "-I$JAVA_HOME/include" \
  "-I$JAVA_HOME/include/linux" \
  "-I$SRC_DIR" \
  "-I$SRC_DIR/fmi1" \
  "-I$SRC_DIR/fmi2" \
  "$SRC_DIR/fmi1/fmi1.cpp" \
  "$SRC_DIR/fmi2/fmi2.cpp" \
  -o "$BUILD_DIR/libfmi4j-import.so"

file "$BUILD_DIR/libfmi4j-import.so"

