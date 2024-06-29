const rl = @import("raylib");
const g = @import("globals.zig");
const std = @import("std");

const TITLE_IMAGE_X: comptime_float = 160;
pub var titleImage: rl.Texture2D = undefined;
pub var omoriFont: rl.Font = undefined;

// assume title_image is always 1464x1053, change if needed
// hard code this so I can use comptime for smaller exe
const imageFrameWidth: comptime_float = 1464 / 5;
pub var frameRec: rl.Rectangle = rl.Rectangle.init(0, 0, imageFrameWidth, 1053 / 3);
pub var pos: rl.Vector2 = rl.Vector2.init(TITLE_IMAGE_X, 130);
var textPos: rl.Vector2 = rl.Vector2.init(TITLE_IMAGE_X + 32, 10);

var frameCount: u8 = 0;
var currentFrame: f32 = 0;

pub fn drawTitleScreen() void {
    frameCount += 1;
    if (frameCount >= g.FPS / g.FRAME_SPEED) {
        frameCount = 0;
        currentFrame += 1;
        if (currentFrame > 1)
            currentFrame = 0;

        // look at this for type conversion later
        frameRec.x = currentFrame * imageFrameWidth;
        if (currentFrame == 0) {
            pos.x = TITLE_IMAGE_X;
        } else if (currentFrame == 1) {
            pos.x = TITLE_IMAGE_X - 10;
        } else if (currentFrame == 2) {
            pos.x = TITLE_IMAGE_X;
        }
    }
    rl.drawTextEx(omoriFont, "OMORI", textPos, 100, 5, rl.Color.black);
    rl.drawTextureRec(titleImage, frameRec, pos, rl.Color.white);
}
