// /*******************************************************************************************
// *
// *   raylib [core] example - input keys
// *
// *   Example complexity rating: [★☆☆☆] 1/4
// *
// *   Example originally created with raylib 1.0, last time updated with raylib 1.0
// *
// *   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
// *   BSD-like license that allows static linking with closed source software
// *
// *   Copyright (c) 2014-2025 Ramon Santamaria (@raysan5)
// *
// ********************************************************************************************/

const c = @cImport({
    @cInclude("raylib.h");
    @cInclude("raymath.h");
});

pub fn main() void {
    //value declaration
    const screenWidth = 800;
    const screenHeight = 450;
    const FPS: i32 = 60;

    const radius: f32 = 50.0;
    const speed: f32 = 4.0;

    c.InitWindow(screenWidth, screenHeight, "raylib [core] example - input keys");

    defer c.CloseWindow();

    var ballPosition = c.Vector2{
        // use @as to provide explicit result type
        .x = @as(f32, @floatFromInt(screenWidth)) / 2.0,
        .y = @as(f32, @floatFromInt(screenHeight)) / 2.0,
    };

    c.SetTargetFPS(FPS);

    while (!c.WindowShouldClose()) {
        if (c.IsKeyDown(c.KEY_RIGHT) or c.IsKeyDown(c.KEY_D)) ballPosition.x += speed;
        if (c.IsKeyDown(c.KEY_LEFT) or c.IsKeyDown(c.KEY_A)) ballPosition.x -= speed;
        if (c.IsKeyDown(c.KEY_UP) or c.IsKeyDown(c.KEY_W)) ballPosition.y -= speed;
        if (c.IsKeyDown(c.KEY_DOWN) or c.IsKeyDown(c.KEY_S)) ballPosition.y += speed;

        // left edge
        if (ballPosition.x - radius < 0.0) {
            ballPosition.x = radius;
        }
        // right edge
        if (ballPosition.x + radius > screenWidth) {
            ballPosition.x = screenWidth - radius;
        }
        // up edge
        if (ballPosition.y - radius < 0.0) {
            ballPosition.y = radius;
        }
        // down edge
        if (ballPosition.y + radius > screenHeight) {
            ballPosition.y = screenHeight - radius;
        }

        c.BeginDrawing();

        defer c.EndDrawing();

        c.ClearBackground(c.RAYWHITE);

        c.DrawText("move the ball with arrow keys or wasd", 10, 10, 20, c.DARKGRAY);

        c.DrawCircleV(ballPosition, 50.0, c.MAROON);

        const posText = c.TextFormat("ball Position: [%.1f, %.1f]", ballPosition.x, ballPosition.y);

        c.DrawText(posText, 10, 40, 20, c.RED);

        c.DrawFPS(10, 70);
    }
}
