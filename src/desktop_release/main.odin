package desktop_rel

import rl "../../raylib"

import "../game"

main :: proc() {
	rl.SetConfigFlags({.WINDOW_RESIZABLE, .VSYNC_HINT})
	rl.InitWindow(1280, 720, "SDun")
	defer rl.CloseWindow()

	rl.SetTargetFPS(144)

	game.game_init()
	defer game.game_destroy()

	for game.game_frame() {
		free_all(context.temp_allocator)
	}
}
