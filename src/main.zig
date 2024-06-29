const std = @import("std");
const rl = @import("raylib");
const g = @import("./game/globals.zig");
const ts = @import("./game/titlescreen.zig");
const player = @import("./game/player.zig");

pub fn main() anyerror!void {
    rl.initWindow(g.SCREEN_WIDTH, g.SCREEN_HEIGHT, "OMORI");
    defer rl.closeWindow();

    ts.titleImage = rl.loadTexture("./assets/img/Omori_titleScreen.png");
    defer ts.titleImage.unload();
    ts.omoriFont = rl.loadFont("./assets/fonts/OMORI_GAME2.ttf");
    defer ts.omoriFont.unload();

    player.playerImage = rl.loadTexture("./assets/img/FA_KEL.png");
    defer player.playerImage.unload();

    rl.setTargetFPS(g.FPS);
    while (!rl.windowShouldClose()) {
        rl.beginDrawing();
        defer rl.endDrawing();
        {
            if (g.GAMEMODE == g.GameMode.titleScreen) {
                ts.drawTitleScreen();
                if (rl.isKeyDown(rl.KeyboardKey.key_enter)) {
                    ts.titleImage.unload();
                    g.GAMEMODE = g.GameMode.overworld;
                }
            } else if (g.GAMEMODE == g.GameMode.overworld) player.drawPlayer();
            rl.drawFPS(10, 10);
            rl.clearBackground(rl.Color.white);
        }
    }
}
