//+build wasm32
package game

import "base:runtime"
import "core:c"
import "core:fmt"
import "core:log"

import rl "../../raylib"

@(default_calling_convention = "c")
foreign _ {
	puts :: proc(buffer: cstring) -> c.int ---
}

@(export)
game_init :: proc "c" (game_memory: rawptr) {
	create_wasm_context()
	context = wasm_context
	context.logger = create_wasm_logger()

	g_state = (^GameState)(game_memory)
	init()
}

@(export)
game_frame :: proc "c" () {
	context = wasm_context
	update()
	draw()
	free_all(context.temp_allocator)
}
