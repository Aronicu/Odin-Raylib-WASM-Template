package main

import "core:c/libc"
import "core:dynlib"
import "core:fmt"
import "core:os"
import "core:time"

import rl "../../raylib"

GameAPI :: struct {
	init:         proc(),
	destroy:      proc(),
	frame:        proc() -> bool,
	memory:       proc() -> rawptr,
	memory_size:  proc() -> int,
	hot_reloaded: proc(mem: rawptr),
	session:      int,
	mod_time:     os.File_Time,
	_lib:         dynlib.Library,
}

game: GameAPI

main :: proc() {
	rl.SetConfigFlags({.WINDOW_RESIZABLE, .VSYNC_HINT})
	rl.InitWindow(1280, 720, "Hello World!")
	defer rl.CloseWindow()

	rl.SetTargetFPS(144)

	if !load_game_api(&game) {
		fmt.eprintf("Uh oh...")
	}
	defer unload_game_api(game)

	game.init()

	for game.frame() {
		free_all(context.temp_allocator)
		current_mod_time, _ := os.last_write_time_by_name("game.dll")
		reload := current_mod_time != game.mod_time
		if reload {
			new_game: GameAPI
			if load_game_api(&new_game) {
				if new_game.memory_size() == game.memory_size() {
					g_state := game.memory()
					new_game.hot_reloaded(g_state)
					unload_game_api(game)
					game = new_game
					fmt.println("Hot Reloaded")
				} else {
					game.destroy()
					unload_game_api(game)
					game = new_game
					game.init()
					fmt.println("Restart Game State")
				}
			}
		}
	}
}

load_game_api :: proc(game_api: ^GameAPI) -> (ok: bool) {
	@(static)
	session: int
	current_mod_time, _ := os.last_write_time_by_name("game.dll")

	dll_to_load := fmt.tprintf("temp_{}.dll", session)

	for !copy_dll(dll_to_load) do time.accurate_sleep(10)

	symbols_loaded, d_ok := dynlib.initialize_symbols(game_api, dll_to_load, "game_", "_lib")
	if !d_ok {
		fmt.eprintfln("Failed to load '{0}' {1}", dll_to_load, dynlib.last_error())
		return false
	}
	fmt.printfln("Game DLL Loaded with %d Symbols!", symbols_loaded)

	game_api.mod_time = current_mod_time
	game_api.session = session
	session += 1

	return true
}

unload_game_api :: proc(game_api: GameAPI) {
	dynlib.unload_library(game_api._lib)
	for libc.system(fmt.ctprintf("del temp_{0}.dll", game_api.session)) != 0 do time.accurate_sleep(10)
}

copy_dll :: proc(dll_to_load: string) -> (ok: bool) {
	dll_data := os.read_entire_file("game.dll", context.temp_allocator) or_return

	return os.write_entire_file(dll_to_load, dll_data)
}
