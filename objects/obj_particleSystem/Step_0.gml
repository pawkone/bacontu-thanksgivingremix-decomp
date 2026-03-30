if (!ds_list_empty(particles))
{
    for (var i = 0; i < ds_list_size(particles); i++)
    {
        var q = ds_list_find_value(particles, i);
        
        with (q)
        {
            image_index += image_speed;
            
            if (floor(image_index) == (sprite_get_number(sprite_index) - 1) && image_speed != 0)
            {
                with (other)
                {
                    q = undefined;
                    ds_list_delete(particles, i);
                    i--;
                }
            }
            
            x += hsp;
            y += vsp;
            vsp += grav;
            
            if (!point_in_rectangle(x, y, camera_get_view_x(view_camera[0]) - 128, camera_get_view_y(view_camera[0]) - 128, camera_get_view_x(view_camera[0]) + obj_screensizer.displayWidth + 128, camera_get_view_y(view_camera[0]) + obj_screensizer.displayHeight + 128))
            {
                with (other)
                {
                    q = undefined;
                    ds_list_delete(particles, i);
                    i--;
                }
            }
        }
    }
}
