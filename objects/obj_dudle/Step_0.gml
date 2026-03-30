if (place_meeting(x, y, obj_player) && cutscene == false)
{
    ds_list_add(global.saveroom, id);
    cutscene = true;
    
    with (obj_player)
    {
        FMODevent_oneshot("event:/Sfx/General/Level/Progression/enterpage", x, y);
        targetRoom = other.targetRoom;
        door = "DOODLE";
        state = -4;
        sprite_index = spr_player_spinout;
        image_speed = 0.35;
    }
    
    sprite_index = spr_dudle_close;
    image_index = 0;
}

visible = !place_meeting(x, y, obj_secretmetalblock);

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
    
    if (animation_end() && sprite_index == spr_dudle_close)
    {
        sprite_index = spr_dudle_closed;
        
        if (!instance_exists(obj_fadeout))
            instance_create_depth(x, y, -1, obj_fadeout);
    }
}
