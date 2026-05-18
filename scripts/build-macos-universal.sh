#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC_DIR="$ROOT_DIR/fmi-native-import/src/main/cpp"
BUILD_DIR="$ROOT_DIR/build/native/macos"
JAVA_HOME="${JAVA_HOME:-$(/usr/libexec/java_home)}"

COMMON_FLAGS=(
  -std=c++11
  -dynamiclib
  -O2
  -fPIC
  "-I$JAVA_HOME/include"
  "-I$JAVA_HOME/include/darwin"
  "-I$SRC_DIR"
  "-I$SRC_DIR/fmi1"
  "-I$SRC_DIR/fmi2"
)

build_arch() {
  local arch="$1"
  local out_dir="$BUILD_DIR/$arch"
  mkdir -p "$out_dir"

  clang++ \
    -arch "$arch" \
    "${COMMON_FLAGS[@]}" \
    "$SRC_DIR/fmi1/fmi1.cpp" \
    "$SRC_DIR/fmi2/fmi2.cpp" \
    -o "$out_dir/fmi4j-import.dylib"
}

build_arch arm64
build_arch x86_64

mkdir -p "$BUILD_DIR/universal"
lipo -create \
  "$BUILD_DIR/arm64/fmi4j-import.dylib" \
  "$BUILD_DIR/x86_64/fmi4j-import.dylib" \
  -output "$BUILD_DIR/universal/fmi4j-import.dylib"

lipo -info "$BUILD_DIR/universal/fmi4j-import.dylib"

