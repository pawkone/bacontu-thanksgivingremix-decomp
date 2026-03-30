for (var _y = 0; _y < abs(image_yscale); _y++)
{
    for (var _x = 0; _x < abs(image_xscale); _x++)
        draw_sprite_ext(sprite_index, image_index, xstart + (_x * 32), ystart + (_y * 32), 1, 1, 0, c_white, image_alpha);
}
