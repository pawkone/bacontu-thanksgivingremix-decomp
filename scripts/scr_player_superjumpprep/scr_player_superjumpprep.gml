function scr_player_superjumpprep()
{
    hsp = movespeed * xscale;
    image_speed = 0.35;
    get_input();
    
    if (animation_end() && sprite_index == spr_player_superjumpprepstart)
    {
        image_index = 0;
        sprite_index = spr_player_superjumpprep;
    }
    
    if (sprite_index != spr_player_superjumpprepstart)
    {
        var move = key_right + key_left;
        
        if (move != 0)
        {
            sprite_index = spr_player_superjumpprepwalk;
            xscale = move;
            movespeed = approach(movespeed, 3, 0.5);
        }
        else
        {
            sprite_index = spr_player_superjumpprep;
            movespeed = 0;
        }
        
        if (!key_up)
        {
            state = states.superjump;
            sprite_index = spr_player_superjump;
            image_index = 0;
            SjumpVsp = -14;
            vsp = SjumpVsp;
            FMODevent_oneshot("event:/Sfx/Player/superjumprelease", x, y);
        }
    }
    else
    {
        movespeed = approach(movespeed, 0, 1);
    }
}

function scr_player_superjump()
{
    get_input();
    var move = key_right + key_left;
    
    if (sprite_index != spr_player_superjumpcancelstart)
    {
        buffers.afterimageMach = approach(buffers.afterimageMach, 0, 1);
        
        if (buffers.afterimageMach == 0)
        {
            buffers.afterimageMach = 4;
            create_afterimage(sprite_index, image_index, x, y, xscale, 1);
        }
        
        buffers.afterimageBlur = approach(buffers.afterimageBlur, 0, 1);
        
        if (buffers.afterimageBlur == 0)
        {
            buffers.afterimageBlur = 3;
            create_blur_effect(sprite_index, image_index, x, y, xscale);
        }
        
        buffers.crazyothereffect--;
        
        if (buffers.crazyothereffect <= 0)
        {
            buffers.crazyothereffect = 9;
            
            with (create_particleStatic(spr_crazyrunothereffect, x, y, 1, 1))
            {
                image_angle = 90;
                image_speed = 0.5;
            }
        }
        
        image_speed = 0.4;
        vsp = SjumpVsp;
        SjumpVsp -= 0.1;
        hsp = movespeed * move;
        
        if (move != 0)
            movespeed = approach(movespeed, 3, 0.5);
        else
            movespeed = 0;
        
        if (key_attack2 || key_slap2)
        {
            sprite_index = spr_player_superjumpcancelstart;
            image_index = 0;
            FMODevent_oneshot("event:/Sfx/Player/superjumpcancel", x, y);
        }
        
        if (place_meeting(x, y - 1, obj_solid) && !place_meeting(x, y - 1, obj_ballofbeer))
        {
            shake_camera(15);
            sprite_index = spr_player_hitceiling;
            image_index = 0;
            state = states.freefallland;
            FMODevent_oneshot("event:/Sfx/Player/slam", x, y);
        }
        
        buffers.step--;
        
        if (buffers.step <= 0)
        {
            buffers.step = 5;
            create_particleStatic(spr_cloudeffect, x + irandom_range(42, -42), y + irandom_range(42, -42), 1, 1);
        }
    }
    else
    {
        image_speed = 0.67;
        vsp = 0;
        hsp = 0;
        
        if (move != 0)
            xscale = move;
        
        if (animation_end())
        {
            create_particleStatic(spr_crazyrunothereffect, x, y, xscale, 1);
            create_particleStatic(spr_grabcloud, x, y, xscale, 1);
            movespeed = 12;
            state = states.mach3;
            jumpstop = true;
            vsp = -5;
            sprite_index = spr_player_superjumpcancel;
            image_index = 6;
        }
    }
}
