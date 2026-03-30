function scr_player_tumble()
{
    get_input();
    hsp = movespeed * xscale;
    
    if (sprite_index != spr_player_dive)
        image_speed = movespeed / 18;
    else
        image_speed = 0.5;
    
    buffers.afterimageBlur = approach(buffers.afterimageBlur, 0, 1);
    buffers.dashcloud--;
    
    if (buffers.dashcloud <= 0 && grounded)
    {
        buffers.dashcloud = 12;
        create_particleStatic(spr_dashcloud1, x, y, xscale, 1);
    }
    
    if (buffers.afterimageBlur == 0)
    {
        buffers.afterimageBlur = 3;
        create_blur_effect(sprite_index, image_index, x, y, xscale);
    }
    
    slope_momentum();
    crouchslip--;
    
    if ((sprite_index == spr_player_rolling || sprite_index == spr_player_crouchslip) && !grounded)
    {
        FMODevent_oneshot("event:/Sfx/Player/dive", x, y);
        sprite_index = spr_player_dive;
        image_index = 0;
        vsp = 10;
    }
    
    if (sprite_index == spr_player_dive)
    {
        if (jumpBuffer && !grounded)
        {
            vsp = -6;
            sprite_index = spr_player_divebomb;
            image_index = 0;
            state = states.groundpoundstart;
        }
    }
    
    if (sprite_index == spr_player_dive && grounded)
    {
        sprite_index = spr_player_rolling;
        image_index = 0;
    }
    
    if (place_meeting(x + sign(hsp), y, obj_solid))
    {
        crouchslip = 0;
        FMODevent_oneshot("event:/Sfx/Player/bump", x, y);
        state = states.hitwall;
        sprite_index = spr_player_wallsplat;
        image_index = 0;
    }
    
    if (!key_down && !scr_solid(x, y - 16) && grounded && crouchslip <= 0)
    {
        image_index = 0;
        sprite_index = spr_player_rollgetup;
        state = states.mach2;
    }
}
