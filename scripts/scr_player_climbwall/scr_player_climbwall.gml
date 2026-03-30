function scr_player_climbwall()
{
    get_input();
    hsp = 0;
    image_speed = 0.6;
    vsp = -wallspeed;
    var move = key_right + key_left;
    
    if (move == xscale)
        wallspeed = approach(wallspeed, 20, 0.15);
    
    buffers.afterimageBlur = approach(buffers.afterimageBlur, 0, 1);
    
    if (buffers.afterimageBlur == 0)
    {
        buffers.afterimageBlur = 4;
        create_blur_effect(sprite_index, image_index, x, y, xscale);
    }
    
    buffers.step--;
    
    if (buffers.step <= 0)
    {
        buffers.step = 10;
        create_particleStatic(spr_cloudeffect, x, y, 1, 1);
    }
    
    if ((!key_attack && wallgrab <= 0) || wallspeed <= 0)
    {
        vsp = 0;
        state = states.jump;
        movespeed = -5;
        sprite_index = spr_player_fall;
    }
    
    wallgrab--;
    
    if (!place_meeting(x + (32 * xscale), y, obj_solid))
    {
        wallgrab = 0;
        state = states.buzzsaw;
        image_index = 0;
        sprite_index = spr_player_buzzsaw;
        
        if (wallspeed < 14)
            wallspeed = 14;
        
        movespeed = wallspeed;
        vsp = -wallspeed / 1.5;
        FMODevent_oneshot("event:/Sfx/Player/airspin", x, y);
        var o_y = y;
        var rep = 0;
        
        while (!place_meeting(x + xscale, y + 1, obj_solid))
        {
            y++;
            rep++;
            
            if (rep > 32)
            {
                y = o_y;
                break;
            }
        }
    }
    
    if (jumpBuffer > 8)
    {
        jumpBuffer = false;
        FMODevent_oneshot("event:/Sfx/Player/jump", x, y);
        vsp = -11;
        xscale *= -1;
        movespeed = 10;
        state = states.mach2;
        jumpstop = false;
        sprite_index = spr_player_walljumpstart;
        image_index = 0;
    }
    
    if (key_down2)
    {
        freefallsmash = 20;
        vsp = 10;
        state = states.groundpound;
        create_particleStatic(spr_cloudeffect, x, y, 1, 1);
        buffers.crazyothereffect = 0;
        sprite_index = spr_player_groundpound;
    }
    
    if (place_meeting(x, y - 1, obj_solid))
    {
        shake_camera(15);
        sprite_index = spr_player_hitceiling;
        image_index = 0;
        state = states.freefallland;
        FMODevent_oneshot("event:/Sfx/Player/slam", x, y);
    }
}
