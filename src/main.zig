const std = @import("std");
const rl = @import("raylib");
const g = @import("./game/globals.zig");
const ts = @import("./game/titlescreen.zig");

pub fn main() anyerror!void {
    rl.initWindow(g.SCREEN_WIDTH, g.SCREEN_HEIGHT, "OMORI");
    defer rl.closeWindow();

    ts.titleImage = rl.loadTexture("./src/assets/img/Omori_titleScreen.png");
    defer ts.titleImage.unload();
    ts.omoriFont = rl.loadFont("./src/assets/fonts/OMORI_GAME2.ttf");
    defer ts.omoriFont.unload();
    ts.updateTitleRec();

    rl.setTargetFPS(g.FPS);
    while (!rl.windowShouldClose()) {
        rl.beginDrawing();
        defer rl.endDrawing();

        {
            ts.drawTitleScreen();
            rl.drawFPS(10, 10);
            rl.clearBackground(rl.Color.white);
        }
    }
}
