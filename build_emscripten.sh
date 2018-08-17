#!/bin/sh

set -eu

make clean

make wasmjit

./wasmjit -o "$1" > "$1.o"

SUPPORT="static_runtime emscripten_runtime emscripten_runtime_posix runtime vector static_emscripten_runtime"
SUPPORT_FILES=""
for FILE in $SUPPORT
do
    rm -f src/wasmjit/${FILE}.o
    make src/wasmjit/${FILE}.o
    SUPPORT_FILES="$SUPPORT_FILES src/wasmjit/${FILE}.o"
done


cc -o "$1.exe" "$1.o" $SUPPORT_FILES