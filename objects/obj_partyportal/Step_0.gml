image_alpha = global.escape.active ? 1 : 0.5;

if (place_meeting(x, y, obj_player) && cutscene == false && global.escape.active)
{
    global.collect += 3000;
    ds_list_add(global.saveroom, id);
    cutscene = true;
    
    with (obj_player)
    {
        targetRoom = other.targetRoom;
        door = other.targetDoor;
        state = -4;
        sprite_index = spr_player_spinout;
        image_speed = 0.35;
    }
    
    sprite_index = spr_partydooropen;
    image_index = 0;
}

if (cutscene == true)
{
    with (obj_player)
    {
        vsp = 0;
        hsp = 0;
        x = approach(x, other.x, 3);
        y = approach(y, other.y, 3);
        xs = approach(xs, 0, 0.05);
        ys = approach(ys, 0, 0.05);
        movespeed = 0;
    }
    
    if (animation_end() && sprite_index == spr_partydooropen)
    {
        image_index = image_number - 1;
        
        if (!instance_exists(obj_fadeout))
            instance_create_depth(x, y, -1, obj_fadeout);
        
        ds_list_clear(global.escaperoom);
    }
}
