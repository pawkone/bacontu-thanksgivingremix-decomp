function scr_player_grab()
{
    static grabOut = function()
    {
        var move = key_right + key_left;
        
        if (key_attack)
        {
            state = states.mach2;
            sprite_index = spr_player_mach2;
            image_index = 0;
        }
        else
        {
            sprite_index = spr_player_land;
            image_index = 0;
            state = states.normal;
            
            if (move == 0)
                movespeed = 0;
        }
    };
    
    FMODSet3dPos(soundGrab, x, y);
    get_input();
    hsp = movespeed * xscale;
    var move = key_right + key_left;
    
    if (movespeed < 10)
        movespeed = approach(movespeed, 10, 1);
    
    buffers.afterimageBlur = approach(buffers.afterimageBlur, 0, 1);
    
    if (buffers.afterimageBlur == 0)
    {
        buffers.afterimageBlur = 3;
        create_blur_effect(sprite_index, image_index, x, y, xscale);
    }
    
    image_speed = 0.35;
    
    if (!grounded && sprite_index == spr_player_grab)
    {
        image_index = 0;
        sprite_index = spr_player_airgrabstart;
    }
    
    if (grounded && (sprite_index == spr_player_airgrab || sprite_index == spr_player_airgrabstart))
        grabOut();
    
    if (animation_end() && sprite_index == spr_player_grab)
        grabOut();
    
    if (animation_end() && sprite_index == spr_player_airgrabstart)
        sprite_index = spr_player_airgrab;
    
    if (key_down2 && grounded)
    {
        FMODevent_oneshot("event:/Sfx/Player/crouchslide", x, y);
        crouchslip = 25;
        sprite_index = spr_player_crouchslip;
        image_index = 0;
        state = states.tumble;
        movespeed = 11;
        create_particleStatic(spr_superdashcloud, x, y, xscale, 1);
        fmod_studio_event_instance_stop(soundGrab, states.crouch);
    }
    
    if (move != 0 && move != xscale)
    {
        movespeed = 0;
        sprite_index = spr_player_grabcancel;
        state = states.jump;
        fmod_studio_event_instance_stop(soundGrab, states.crouch);
    }
    
    if (jumpBuffer && coyote_time)
    {
        jumpBuffer = false;
        image_index = 0;
        sprite_index = spr_player_longjump;
        state = states.mach2;
        vsp = -12;
        jumpstop = false;
        FMODevent_oneshot("event:/Sfx/Player/jump", x, y);
        fmod_studio_event_instance_stop(soundGrab, states.crouch);
    }
    
    if (place_meeting(x + sign(hsp), y, obj_solid) && !grounded)
    {
        wallgrab = 10;
        wallspeed = movespeed;
        state = states.climbwall;
        sprite_index = spr_player_wallclimb;
        image_index = 0;
    }
    
    if (place_meeting(x + sign(hsp), y, obj_solid) && grounded)
    {
        movespeed = 0;
        hsp = 0;
        vsp = -6;
        state = states.jump;
        sprite_index = spr_player_grabbump;
        image_index = 0;
    }
}
