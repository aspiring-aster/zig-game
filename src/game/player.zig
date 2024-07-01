const rl = @import("raylib");
const g = @import("./globals.zig");
const std = @import("std");

pub var playerImage: rl.Texture2D = undefined;

pub var pos: rl.Vector2 = rl.Vector2.init(32, 32);
var targetPos: rl.Vector2 = rl.Vector2.init(32, 32);

// Assume PlayerSprite is always the same so I can use comptime
// image size:384/256
// for now sprite is 32X32
const spriteWidth: comptime_float = 32;
const spriteHeight: comptime_float = 32;
var frameRec: rl.Rectangle = rl.Rectangle.init(0, 0, spriteWidth, spriteHeight);

var frameCount: u8 = 0;
var currentXFrame: f32 = 0;
var currentYFrame: f32 = 0;
var isMoving: bool = false;

var lastMoveTime: f64 = 0;

pub fn drawPlayer() void {
    const dt: f32 = rl.getFrameTime();
    const currentTime = rl.getTime();

    if (!isMoving) {
        if (currentTime - lastMoveTime >= g.MOVE_DELAY) {
            if (rl.isKeyDown(rl.KeyboardKey.key_up)) {
                targetPos.y -= g.GRID_SIZE;
                currentYFrame = 3;
                isMoving = true;
                lastMoveTime = currentTime;
            } else if (rl.isKeyDown(rl.KeyboardKey.key_down)) {
                targetPos.y += g.GRID_SIZE;
                currentYFrame = 0;
                isMoving = true;
                lastMoveTime = currentTime;
            } else if (rl.isKeyDown(rl.KeyboardKey.key_left)) {
                targetPos.x -= g.GRID_SIZE;
                currentYFrame = 1;
                isMoving = true;
                lastMoveTime = currentTime;
            } else if (rl.isKeyDown(rl.KeyboardKey.key_right)) {
                targetPos.x += g.GRID_SIZE;
                currentYFrame = 2;
                isMoving = true;
                lastMoveTime = currentTime;
            }
        }
    }

    if (isMoving) {
        const dx = targetPos.x - pos.x;
        const dy = targetPos.y - pos.y;
        const distance = @sqrt(dx * dx + dy * dy);

        if (distance > 0.1) {
            const moveAmount = @min(g.PLAYER_WALK_VELOCITY * dt, distance);
            pos.x += dx / distance * moveAmount;
            pos.y += dy / distance * moveAmount;

            frameCount += 1;
            if (frameCount >= g.PLAYER_FPS) {
                frameCount = 0;
                currentXFrame += 1;
                if (currentXFrame > 2) currentXFrame = 0;
            }
            frameRec.x = currentXFrame * spriteWidth;
        } else {
            pos = targetPos;
            isMoving = false;
        }
    } else {
        frameRec.x = spriteWidth;
        frameCount = 0;
        currentXFrame = 0;
    }

    frameRec.y = currentYFrame * spriteHeight;
    rl.drawTextureRec(playerImage, frameRec, pos, rl.Color.white);
}
