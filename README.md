# Odin-Raylib-WASM-Template
A Template for using Raylib on Desktop, and WASM using Emscripten

## Features
* Works well in Windows (It probably also works for the other desktop platforms but I didn't test it)
* Logging on WASM Works!
* Hot Reloading (Tested on Windows)

## What won't work
* Most of Core Libraries (fmt, os, time, etc.)

## Building

### Windows
```batch
:: For Hot Reloading
.\build_reload.bat

:: For Releasing
.\build_release.bat
```

### WASM

#### Requirements
1. [emsdk](https://emscripten.org/docs/getting_started/downloads.html)

```batch
.\build_wasm
cd wasm_build

:: Run the a local http server
python -m http.server
```

## References
* [Caedo's raylib_wasm_odin](https://github.com/Caedo/raylib_wasm_odin)
* [Karl Zylinski's Odin Raylib Hot Reload Game Template](https://github.com/karl-zylinski/odin-raylib-hot-reload-game-template/)
