function scr_player_mach2()
{
    get_input();
    hsp = movespeed * xscale;
    var move = key_right + key_left;
    
    if (grounded)
        movespeed += 0.1;
    
    buffers.afterimageMach = approach(buffers.afterimageMach, 0, 1);
    
    if (buffers.afterimageMach == 0)
    {
        buffers.afterimageMach = 4;
        create_afterimage(sprite_index, image_index, x, y, xscale, movespeed / 12);
    }
    
    buffers.dashcloud--;
    
    if (buffers.dashcloud <= 0 && grounded)
    {
        buffers.dashcloud = 12;
        create_particleStatic(spr_dashcloud1, x, y, xscale, 1);
    }
    
    slope_momentum();
    
    if (animation_end() && sprite_index == spr_player_mach1)
    {
        image_index = 0;
        sprite_index = spr_player_mach2;
    }
    
    if (animation_end() && sprite_index == spr_player_rollgetup)
    {
        image_index = 0;
        sprite_index = spr_player_mach2;
    }
    
    if (animation_end() && sprite_index == spr_player_mach2jump)
    {
        image_index = 0;
        sprite_index = spr_player_mach2jumpend;
    }
    
    if (animation_end() && sprite_index == spr_player_longjump)
    {
        image_index = 0;
        sprite_index = spr_player_longjumpend;
    }
    
    if (animation_end() && sprite_index == spr_player_walljumpstart)
    {
        image_index = 0;
        sprite_index = spr_player_walljump;
    }
    
    if (grounded && (sprite_index == spr_player_mach2jump || sprite_index == spr_player_mach2jumpend || sprite_index == spr_player_walljump || sprite_index == spr_player_walljumpstart || sprite_index == spr_player_longjump || sprite_index == spr_player_longjumpend))
    {
        image_index = 3;
        sprite_index = spr_player_mach2;
    }
    
    if (sprite_index == spr_player_mach2)
        image_speed = movespeed / 18;
    else
        image_speed = 0.45;
    
    if (jumpstop == false && !key_jump && vsp < grav)
    {
        jumpstop = true;
        vsp /= 20;
    }
    
    if (jumpBuffer && coyote_time)
    {
        jumpBuffer = false;
        image_index = 0;
        sprite_index = spr_player_mach2jump;
        vsp = -12;
        jumpstop = false;
        FMODevent_oneshot("event:/Sfx/Player/jump", x, y);
    }
    
    if (!key_attack && grounded)
    {
        if (sprite_index == spr_player_mach1)
        {
            state = states.normal;
            sprite_index = spr_player_idle;
            image_index = 0;
            image_speed = 0.35;
            movespeed = 0;
        }
        else
        {
            FMODevent_oneshot("event:/Sfx/Player/machend", x, y);
            state = states.machslide;
            sprite_index = spr_player_machslidestart;
            image_index = 0;
        }
    }
    
    if (move != xscale && move != 0 && grounded)
    {
        if (sprite_index == spr_player_mach1)
        {
            xscale *= -1;
        }
        else
        {
            FMODevent_oneshot("event:/Sfx/Player/machturn", x, y);
            sprite_index = spr_player_mach2turn;
            image_index = 0;
            state = states.machturn;
        }
    }
    
    if (movespeed >= 12 && grounded)
    {
        movespeed = max(movespeed, 12);
        flash = true;
        state = states.mach3;
        
        if (sprite_index != spr_player_rollgetup)
        {
            image_index = 0;
            sprite_index = spr_player_mach3;
        }
    }
    
    if (place_meeting(x + sign(hsp), y, obj_solid) && !place_meeting(x, y + 1, obj_slope) && grounded)
    {
        FMODevent_oneshot("event:/Sfx/Player/bump", x, y);
        state = states.hitwall;
        sprite_index = spr_player_wallsplat;
        image_index = 0;
    }
    
    if (key_down)
    {
        image_index = 0;
        sprite_index = spr_player_rolling;
        state = states.tumble;
        create_particleStatic(spr_grabcloud, x, y, xscale, 1);
    }
    
    if ((place_meeting(x + sign(hsp), y, obj_solid) && !grounded) || (scr_slope(x, y + 4) && place_meeting(x + sign(hsp), y - 4, obj_solid) && !place_meeting(x + hsp, y, obj_metalblock)))
    {
        if (doBump(32))
        {
            wallspeed = movespeed;
            state = states.climbwall;
            sprite_index = spr_player_wallclimb;
            image_index = 0;
        }
    }
    
    doTaunt();
    doGrab();
}
