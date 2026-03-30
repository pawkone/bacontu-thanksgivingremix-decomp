with (instance_place(x, y - 1, obj_player))
{
    if ((key_up && place_meeting(x, y, obj_ladder)) || (key_down && grounded && place_meeting(x, y + 1, obj_ladder) && !place_meeting(x, y + 1, obj_solid) && state != states.tumble))
    {
        state = states.ladder;
        hsp = 0;
        movespeed = 0;
        x = other.x + 16;
        
        if (key_down && grounded)
            y = other.y + 1;
    }
}
