function scr_player_crouch()
{
    get_input();
    hsp = movespeed * xscale;
    var move = key_right + key_left;
    
    if (!key_down && !scr_solid(x, y - 16) && grounded)
    {
        image_index = 0;
        sprite_index = spr_player_idle;
        state = states.normal;
    }
    
    if (animation_end() && sprite_index == spr_player_crouchstart)
    {
        sprite_index = spr_player_crouch;
        image_index = 0;
    }
    
    if (animation_end() && sprite_index == spr_player_crouchhop)
    {
        sprite_index = spr_player_crouchfall;
        image_index = 0;
    }
    
    if (jumpstop == false && !key_jump && vsp < grav)
    {
        jumpstop = true;
        vsp /= 20;
    }
    
    if (grounded && (sprite_index == spr_player_crouchhop || sprite_index == spr_player_crouchfall))
    {
        sprite_index = spr_player_crouchstart;
        image_index = 2;
        create_particleStatic(spr_landeffect, x, y, 1, 1);
    }
    
    if (move != 0)
    {
        if (sprite_index == spr_player_crouch)
        {
            image_index = 0;
            sprite_index = spr_player_crouchmove;
        }
        
        xscale = move;
        movespeed = approach(movespeed, 4, 0.5);
        buffers.step--;
        
        if (sprite_index == spr_player_crouchmove)
        {
            image_speed = movespeed / 15;
            
            if (floor(image_index) == 2 && buffers.step <= 0)
            {
                FMODevent_oneshot("event:/Sfx/Player/step", x, y);
                buffers.step = 12;
                create_particleStatic(spr_cloudeffect, x, y + 42, 1, 1);
            }
        }
    }
    else
    {
        movespeed = 0;
        image_speed = 0.35;
        
        if (sprite_index == spr_player_crouchmove)
        {
            image_index = 0;
            sprite_index = spr_player_crouch;
        }
    }
    
    if (!grounded && sprite_index != spr_player_crouchhop)
    {
        image_index = 0;
        sprite_index = spr_player_crouchfall;
    }
    
    if (jumpBuffer && grounded)
    {
        jumpBuffer = false;
        create_particleStatic(spr_jumpeffect, x, y, 1, 1);
        image_speed = 0.35;
        image_index = 0;
        sprite_index = spr_player_crouchhop;
        vsp = -8;
        jumpstop = false;
        FMODevent_oneshot("event:/Sfx/Player/jump", x, y);
    }
}
