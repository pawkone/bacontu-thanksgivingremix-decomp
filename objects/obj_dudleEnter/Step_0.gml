if (cutscene == true)
{
    with (obj_player)
    {
        x = other.x;
        y = other.y;
        vsp = 0;
        hsp = 0;
        xs = approach(xs, 1, 0.01);
        ys = approach(ys, 1, 0.01);
    }
    
    if (animation_end() && sprite_index == spr_dudle_open)
    {
        instance_destroy();
        FMODevent_oneshot("event:/Sfx/General/Level/Doodles/doodleget", x, y);
        create_particleDebri(spr_dudle_debri, 0, x, y, 1, -5);
        create_particleDebri(spr_dudle_debri, 1, x, y, 1, -5);
        
        with (obj_player)
        {
            jumpstop = true;
            vsp = -9;
            xscale = other.facing;
            state = states.jump;
            xs = 1;
            ys = 1;
            roomstartX = x;
            roomstartY = y;
        }
    }
}
