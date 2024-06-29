const rl = @import("raylib");
const g = @import("globals.zig");
const std = @import("std");

const TITLE_IMAGE_X: f32 = 160;
pub var titleImage: rl.Texture2D = undefined;
pub var omoriFont: rl.Font = undefined;
pub var frameRec: rl.Rectangle = rl.Rectangle.init(0, 0, 0, 0);

pub var pos: rl.Vector2 = rl.Vector2.init(TITLE_IMAGE_X, 130);
var textPos: rl.Vector2 = rl.Vector2.init(TITLE_IMAGE_X + 32, 10);
var frameCount: u8 = 0;
var currentFrame: f32 = 0;

pub fn updateTitleRec() void {
    frameRec.width = @as(f32, @floatFromInt(titleImage.width)) / 5;
    frameRec.height = @as(f32, @floatFromInt(titleImage.height)) / 3;
}

pub fn drawTitleScreen() void {
    frameCount += 1;
    if (frameCount >= g.FPS / g.FRAME_SPEED) {
        frameCount = 0;
        currentFrame += 1;
        if (currentFrame > 1)
            currentFrame = 0;

        // look at this for type conversion later
        frameRec.x = currentFrame * @as(f32, @floatFromInt(titleImage.width)) / 5.0;
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
