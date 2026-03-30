if (global.escape.active)
{
    if (!gotoplayer)
        y = ystart + (sin((current_time * 0.001) + (0.1 * randomwaveNum)) * 4);
    
    if (distance_to_object(obj_player) < 120 && obj_player.super)
        super = true;
    
    if (distance_to_object(obj_player) < (!obj_player.super ? 32 : 64))
        gotoplayer = true;
    
    if (gotoplayer && canmove)
    {
        var point = point_direction(x, y, obj_player.x, obj_player.y);
        x += lengthdir_x(movespeed, point);
        y += lengthdir_y(movespeed, point);
        movespeed += 0.5;
    }
}

image_alpha = global.escape.active ? 1 : 0.5;
