if (currentRoom == room)
{
    draw_sprite_ext(sprite_index, image_index, x, y, xscale, 1, image_angle, image_blend, image_alpha);
    pal_swap_set(spr_palette, palIndex, false);
    draw_sprite_ext(sprite_index, image_index, x, y, xscale, 1, image_angle, image_blend, image_alpha);
    shader_reset();
    pattern_draw(sprite_index, image_index, x, y, xscale, 1, image_angle, image_blend, image_alpha, global.patternSpr, spr_playerPatColors, spr_palette, palIndex);
    
    if (flash)
    {
        shader_set(shd_flash);
        draw_sprite_ext(sprite_index, image_index, x, y, xscale, 1, image_angle, image_blend, image_alpha);
        shader_reset();
    }
    
    draw_sprite_ext(sprite_index, image_index, x, y, xscale, 1, image_angle, c_black, alpha);
    draw_set_font(global.smallfont);
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_textEX(x, y - 64, string_lower(name));
    draw_set_color(c_white);
}
