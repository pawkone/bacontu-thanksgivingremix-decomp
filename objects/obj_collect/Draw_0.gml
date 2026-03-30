if (super)
{
    for (var i = 0; i < 16; i++)
    {
        var _xx = sin((current_time * 0.001) + (2 * i)) * 2 * i;
        var _yy = cos((current_time * 0.001) + (1 * i)) * 2 * i;
        var _alpha = abs(sin((current_time * 0.001) + (5 * i))) * 0.1;
        gpu_set_blendmode(bm_add);
        draw_sprite_ext(sprite_index, image_index, x + _xx, y + _yy, 1, 1, image_angle, image_blend, image_alpha * _alpha);
        gpu_set_blendmode(bm_normal);
    }
}

draw_self();
