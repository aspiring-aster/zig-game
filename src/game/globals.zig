pub const SCREEN_WIDTH: comptime_int = 640;
pub const SCREEN_HEIGHT: comptime_int = 480;
pub const FPS: comptime_int = 60;
pub const FRAME_SPEED: comptime_int = 3;

pub const PLAYER_FRAME_SPEED: comptime_int = 3;
pub const PLAYER_WALK_VELOCITY: comptime_float = 2;
pub const PLAYER_RUN_VELOCITY: comptime_float = 8;
pub const PLAYER_FPS: comptime_float = FPS / PLAYER_FRAME_SPEED;

pub const GameMode = enum { titleScreen, overworld };

pub var GAMEMODE: GameMode = GameMode.titleScreen;
