// #include <emscripten/emscripten.h>
// #include <raylib.h>

// #include <stdio.h>
#include <stdlib.h>

#include <emscripten/emscripten.h>

extern void InitWindow(int width, int height, const char *title);

extern void game_init(void *game_memory);
extern void game_frame();

#define Byte 1
#define Kilobyte 1024 * Byte
#define Megabyte 1024 * Kilobyte
#define Gigabyte 1024 * Megabyte
#define Terabyte 1024 * Gigabyte
#define Petabyte 1024 * Terabyte
#define Exabyte 1024 * Petabyte

#define MEGABYTE

int main(void) {
  InitWindow(1280, 720, "SDun.exe");
  char *game_state = (char *)malloc(Megabyte * 64);
  game_init(game_state);

  emscripten_set_main_loop(game_frame, 0, 1);
  return 0;
}

// int main() {
//   void *game_memory = malloc();
//   // SetConfigFlags()
//   InitWindow(1280, 720, "SDun");

//   game_init(game_memory);

//   emscripten_set_main_loop(game_frame, 0, 1);
//   return 0;
// }