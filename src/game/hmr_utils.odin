//+private
//+build windows, linux, darwin
package game

@(export)
game_memory :: proc() -> rawptr {
	return g_state
}

@(export)
game_memory_size :: proc() -> int {
	return size_of(GameState)
}

@(export)
game_hot_reloaded :: proc(mem: rawptr) {
	g_state = (^GameState)(mem)
}
