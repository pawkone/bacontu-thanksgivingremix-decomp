var doorOBJ = asset_get_index(string("obj_door{0}", door));

if (instance_exists(doorOBJ))
{
    if (hallway == 2)
    {
        var _hallway = -4;
        
        with (doorOBJ)
            _hallway = instance_place(x, y, obj_hallway_vertical);
        
        if (_hallway == -4)
            exit;
        
        var _hallway2Size = _hallway.sprite_width;
        
        if (state == states.climbwall)
            x = doorOBJ.x + (savedpos * (_hallway2Size / hallwaySize));
        else
            x = doorOBJ.x + 16 + ((savedpos * (_hallway2Size / hallwaySize)) - 16);
        
        y = doorOBJ.y - (192 * hallwayDirection);
        vsp = savedspd;
    }
    else
    {
        if (hallway)
            x = doorOBJ.x + 16 + (192 * hallwayDirection);
        else
            x = doorOBJ.x + 16;
        
        y = doorOBJ.y - 14;
    }
}

if (place_meeting(x, y + 4, obj_ballofbeer) || place_meeting(x, y - 16, obj_ballofbeer))
{
    hallway = false;
    state = states.crouch;
}

if (place_meeting(x, y, obj_door) || place_meeting(x, y, obj_exitgate))
{
    state = states.walkfront;
    image_index = 0;
    sprite_index = spr_player_walkfront;
}

with (obj_followplayer)
{
    ds_queue_clear(followqueue);
    gx = other.x;
    gy = other.y;
    x = gx;
    y = gy;
}

roomstartX = x;
roomstartY = y;
