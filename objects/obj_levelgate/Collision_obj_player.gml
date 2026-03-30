var _rm = targetRoom;
var _dr = "A";

if (other.grounded && other.key_up && other.state != states.enterdoor && other.state != states.walkfront)
{
    with (other)
    {
        hallway = false;
        movespeed = 0;
        vsp = 0;
        hsp = 0;
        state = states.enterdoor;
        sprite_index = spr_player_entergate;
        image_index = 0;
        targetRoom = _rm;
        door = _dr;
        backtohubRoom = room;
        backtohubX = x;
        backtohubY = y;
    }
    
    with (obj_music)
        stop_music();
}

with (other)
{
    if (image_index == (image_number - 1) && sprite_index == spr_player_entergate && !instance_exists(obj_fadeout))
    {
        state = states.enterdoor;
        sprite_index = spr_player_entergate;
        image_index = image_number - 1;
        generalReset();
        global.level = other.level;
        global.resetRoom = _rm;
        
        if (!instance_exists(obj_titlecard))
            instance_create_depth(0, 0, 0, obj_titlecard);
    }
}
