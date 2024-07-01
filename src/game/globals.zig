pub const SCREEN_WIDTH: comptime_int = 640;
pub const SCREEN_HEIGHT: comptime_int = 480;
pub const FPS: comptime_int = 60;
pub const FRAME_SPEED: comptime_int = 3;

pub const PLAYER_FRAME_SPEED: comptime_int = 3;
pub const PLAYER_WALK_VELOCITY: comptime_float = 2 * GRID_SIZE;
pub const PLAYER_RUN_VELOCITY: comptime_float = 8;
pub const PLAYER_FPS: comptime_float = FPS / PLAYER_FRAME_SPEED;

pub const GameMode = enum { titleScreen, overworld };
pub const Direction = enum { up, down, left, right };

pub var GAMEMODE: GameMode = GameMode.titleScreen;
pub const GRID_SIZE: comptime_float = 32;
pub const MOVE_DELAY: comptime_float = 0.006; // Adjust this to control movement speed (in seconds)

pub const ENEMY_MAP_VELOCITY: comptime_float = 1.2;
