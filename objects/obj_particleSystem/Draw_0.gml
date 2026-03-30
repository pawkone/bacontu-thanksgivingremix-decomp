if (!ds_list_empty(particles))
{
    for (var i = 0; i < ds_list_size(particles); i++)
    {
        var q = ds_list_find_value(particles, i);
        depth = q.depth;
        
        with (q)
            draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, 1, image_angle, c_white, 1);
    }
}
