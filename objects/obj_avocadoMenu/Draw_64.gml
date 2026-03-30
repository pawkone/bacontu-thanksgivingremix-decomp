draw_sprite_tiled(checkerboard, 0, checkerX, 0);

with (avocadoLogo)
    draw_sprite_ext(sprite, 0, x, y, size, size, 0, c_white, 1);

draw_set_color(c_white);
draw_set_alpha(whiteBack);
draw_rectangle(0, 0, obj_screensizer.displayWidth, obj_screensizer.displayHeight, false);
draw_set_alpha(1);

for (var i = 0; i < array_length(menus); i++)
{
    draw_set_halign(fa_center);
    var q = menus[i];
    draw_set_font(font_caption);
    draw_set_color(c_black);
    var _yy = q.y;
    draw_text(obj_screensizer.displayWidth / 2, _yy + 50, menus[i].header);
    var m = menus[i].menu;
    var _textYspacing = 0;
    
    for (var w = 0; w < array_length(m); w++)
    {
        var _seltY = (obj_screensizer.displayHeight / 2) + _textYspacing;
        draw_text(obj_screensizer.displayWidth / 2, _seltY + _yy, m[w].name);
        _textYspacing += (string_height(m[w].name) * 1.4);
        
        if (selecting == w)
        {
            if (scene == 2)
            {
                cursorY = lerp(cursorY, _seltY, 0.1);
                cursorX = lerp(cursorX, (obj_screensizer.displayWidth / 2) - string_width(m[w].name) - 16, 0.05);
            }
        }
    }
    
    draw_text(cursorX, cursorY, ">");
    draw_set_color(c_white);
}

draw_set_color(c_white);
draw_set_alpha(screenFlash);
draw_rectangle(0, 0, obj_screensizer.displayWidth, obj_screensizer.displayHeight, false);
draw_set_alpha(1);
draw_set_color(c_black);
draw_set_alpha(dark);
draw_rectangle(0, 0, obj_screensizer.displayWidth, obj_screensizer.displayHeight, false);
draw_set_alpha(1);
draw_set_color(c_white);
