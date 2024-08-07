package game

import rl "../../raylib"

Rect :: rl.Rectangle
Vec2 :: [2]f32
Vec2i :: [2]i32

GameState :: struct {
	player_pos: Vec2,
}

g_state: ^GameState

init :: proc() {
	g_state^ = GameState {
		player_pos = {100, 200},
	}
}

update :: proc() {
	dt := rl.GetFrameTime()
	if rl.IsKeyDown(.S) do g_state.player_pos.y += 300 * dt
	if rl.IsKeyDown(.W) do g_state.player_pos.y -= 300 * dt
	if rl.IsKeyDown(.D) do g_state.player_pos.x += 300 * dt
	if rl.IsKeyDown(.A) do g_state.player_pos.x -= 300 * dt
}

draw :: proc() {
	rl.BeginDrawing()
	rl.ClearBackground(rl.BLACK)

	rect := Rect {
		g_state.player_pos.x,
		g_state.player_pos.y,
		100, 100,
	}
	rl.DrawRectangleRec(rect, rl.GREEN)

	rl.EndDrawing()
}
