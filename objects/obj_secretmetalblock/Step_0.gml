with (obj_player)
{
    var _block = other;
    
    if (state == states.mach3 || state == states.buzzsaw || (state == states.groundpound && freefallsmash >= 10))
    {
        var _y = y;
        var _x = x + (xscale * 5);
        
        if (state == states.groundpound)
        {
            _y = y + vsp;
            _x = x;
        }
        
        if (state == states.buzzsaw)
        {
            _y = y + vsp;
            _x = x + (xscale * 5);
        }
        
        if (place_meeting(_x, _y, _block))
        {
            with (_block)
                instance_destroy();
            
            if (state == states.groundpound)
            {
                sprite_index = spr_player_groundpoundland;
                image_index = 0;
                vsp = 0;
                hsp = 0;
                state = states.freefallland;
                movespeed = abs(hsp);
                FMODevent_oneshot("event:/Sfx/Player/slam", x, y);
            }
        }
    }
}
