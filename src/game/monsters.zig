const rl = @import("raylib");
const g = @import("./globals.zig");
const std = @import("std");
const player = @import("./player.zig");

pub var enemyImage: rl.Texture2D = undefined;

var pos: rl.Vector2 = rl.Vector2.init(100, 30);
var targetPos = rl.Vector2.init(100, 30);

const spriteWidth: comptime_float = 384 / 12;
const spriteHeight: comptime_float = 256 / 8;
var frameRec: rl.Rectangle = rl.Rectangle.init(0, 0, spriteWidth, spriteHeight);
var lastMoveTime: f64 = 0;

fn move_sprite() void {
    const dt = rl.getFrameTime();
    const speed: f32 = g.ENEMY_MAP_VELOCITY * dt; // Adjust this value to change movement speed

    // Only choose a new target when we've reached the current one
    if (@abs(targetPos.x - pos.x) < 0.1 and @abs(targetPos.y - pos.y) < 0.1) {
        const player_grid_x = @round(player.pos.x / g.GRID_SIZE);
        const player_grid_y = @round(player.pos.y / g.GRID_SIZE);
        const sprite_grid_x = @round(pos.x / g.GRID_SIZE);
        const sprite_grid_y = @round(pos.y / g.GRID_SIZE);

        const x_distance: f32 = player_grid_x - sprite_grid_x;
        const y_distance: f32 = player_grid_y - sprite_grid_y;

        if (@abs(x_distance) > @abs(y_distance)) {
            // Move horizontally
            if (x_distance > 0) {
                targetPos.x = pos.x + g.GRID_SIZE;
            } else if (x_distance < 0) {
                targetPos.x = pos.x - g.GRID_SIZE;
            }
        } else if (y_distance != 0) {
            // Move vertically
            if (y_distance > 0) {
                targetPos.y = pos.y + g.GRID_SIZE;
            } else {
                targetPos.y = pos.y - g.GRID_SIZE;
            }
        }
    }

    // Move towards the target position
    const dx = targetPos.x - pos.x;
    const dy = targetPos.y - pos.y;
    const distance = @sqrt(dx * dx + dy * dy);

    if (distance > 0.1) {
        const move_amount = @min(speed, distance);
        pos.x += dx / distance * move_amount;
        pos.y += dy / distance * move_amount;
    } else {
        pos = targetPos;
    }
}
pub fn drawEnemy() void {
    move_sprite();
    rl.drawTextureRec(enemyImage, frameRec, pos, rl.Color.white);
}
