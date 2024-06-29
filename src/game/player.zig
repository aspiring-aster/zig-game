const rl = @import("raylib");
const g = @import("./globals.zig");

pub var playerImage: rl.Texture2D = undefined;

var pos: rl.Vector2 = rl.Vector2.init(200, 130);

// Assume PlayerSprite is always the same so I can use comptime
// image size:384/256
const spriteWidth: comptime_float = 384 / 12;
const spriteHeight: comptime_float = 256 / 8;
var frameRec: rl.Rectangle = rl.Rectangle.init(0, 0, spriteWidth, spriteHeight);

var frameCount: u8 = 0;
var currentXFrame: f32 = 0;
var currentYFrame: f32 = 0;

pub fn drawPlayer() void {
    var keyJustPressed: bool = false;
    if (rl.isKeyDown(rl.KeyboardKey.key_up)) {
        keyJustPressed = true;
        pos.y -= g.PLAYER_WALK_VELOCITY;
        currentYFrame = 3;
    } else if (rl.isKeyDown(rl.KeyboardKey.key_down)) {
        keyJustPressed = true;
        pos.y += g.PLAYER_WALK_VELOCITY;
        currentYFrame = 0;
    } else if (rl.isKeyDown(rl.KeyboardKey.key_left)) {
        keyJustPressed = true;
        pos.x -= g.PLAYER_WALK_VELOCITY;
        currentYFrame = 1;
    } else if (rl.isKeyDown(rl.KeyboardKey.key_right)) {
        keyJustPressed = true;
        pos.x += g.PLAYER_WALK_VELOCITY;
        currentYFrame = 2;
    } else frameRec.x = spriteWidth;

    if (keyJustPressed) {
        frameCount += 1;
        if (frameCount >= g.PLAYER_FPS) {
            frameCount = 0;
            currentXFrame += 1;
            if (currentXFrame > 2) currentXFrame = 0;
        }
        frameRec.x = currentXFrame * spriteWidth;
    } else {
        frameCount = 0;
        currentXFrame = 0;
    }
    frameRec.y = currentYFrame * spriteHeight;
    rl.drawTextureRec(playerImage, frameRec, pos, rl.Color.white);
}
