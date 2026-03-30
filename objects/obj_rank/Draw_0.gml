if (!surface_exists(rankSurf))
    rankSurf = surface_create(room_width, room_height);

surface_set_target(rankSurf);
draw_clear_alpha(c_black, 0);
draw_set_alpha(fadeAlpha);
draw_set_color(c_white);
draw_rectangle(0, 0, room_width, room_height, false);
draw_set_color(c_white);
draw_set_alpha(1);
var _xx = (obj_screensizer.displayWidth / 2) + irandom_range(shake, -shake);
var _yy = (obj_screensizer.displayHeight / 2) + irandom_range(shake, -shake);

if (showRank)
{
    draw_sprite(rankspr, rankIndex, _xx, _yy);
    pal_swap_set(obj_player.spr_palette, obj_player.palIndex, false);
    draw_sprite(rankspr, rankIndex, _xx, _yy);
    shader_reset();
    pattern_draw(rankspr, rankIndex, _xx, _yy, 1, 1, 0, 16777215, 1, global.patternSpr, spr_playerPatColors);
}

if (showRankText)
    draw_sprite(ranktextSpr, 0, _xx, _yy);

surface_reset_target();
draw_surface(rankSurf, 0, 0);

if (cutscenePart == 2)
{
    colorAlpha = approach(colorAlpha, 1, 0.1);
    shader_set(shd_fullshade);
    shader_set_uniform_f_array(uniform1, [col[0], col[1], col[2]]);
    shader_set_uniform_f_array(uniform2, [col2[0], col2[1], col2[2]]);
    draw_set_alpha(colorAlpha);
    draw_surface(rankSurf, 0, 0);
    draw_set_alpha(1);
    shader_reset();
}

draw_set_font(global.bigfont);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

for (var i = 0; i < array_length(text); i++)
{
    var t = text[i];
    
    if (t[0])
        draw_textEX(48, 48 + (32 * i), t[1]);
}
