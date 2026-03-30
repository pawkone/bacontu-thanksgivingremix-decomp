function scr_player_uppercut()
{
    get_input();
    var move = key_right + key_left;
    hsp = approach(hsp, movespeed * move, 0.8);
    
    if (move != 0)
        movespeed = 6;
    
    image_speed = 0.4;
    
    if (vsp < 0)
    {
        buffers.afterimageMach = approach(buffers.afterimageMach, 0, 1);
        
        if (buffers.afterimageMach == 0)
        {
            buffers.afterimageMach = 4;
            create_afterimage(sprite_index, image_index, x, y, xscale, 1);
        }
    }
    
    if (animation_end())
        image_index = image_number - 1;
    
    if (grounded && vsp > 0)
    {
        create_particleStatic(spr_landeffect, x, y, 1, 1);
        image_index = 0;
        sprite_index = (move != 0) ? spr_player_land2 : spr_player_land;
        state = states.normal;
        FMODevent_oneshot("event:/Sfx/Player/step", x, y);
        movespeed = abs(hsp);
        
        if (move != 0)
            xscale = move;
        
        hsp = movespeed * xscale;
    }
}
