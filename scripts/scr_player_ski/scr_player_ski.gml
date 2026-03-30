function scr_player_ski()
{
    static snowbuffer = 5;
    
    get_input();
    hsp = movespeed * xscale;
    
    if (poletreeID == -4)
    {
        if (grounded && vsp >= 0)
        {
            if (animation_end() && sprite_index == spr_player_ski_getup)
                sprite_index = spr_player_ski;
            else if (sprite_index != spr_player_ski_getup)
                sprite_index = spr_player_ski;
            
            if (movespeed < 10)
                movespeed = approach(movespeed, 10, 0.3);
            
            if (movespeed < 17)
            {
                slope_momentum(0.2);
                movespeed += 0.015;
            }
            
            if (grounded)
            {
                if (snowbuffer > 0)
                {
                    snowbuffer--;
                }
                else
                {
                    create_particleDebri(spr_snowparticle, irandom_range(0, 3), x, y + 50, 1);
                    snowbuffer = 5;
                }
            }
            
            if (jumpBuffer)
            {
                jumpBuffer = false;
                vsp = -12;
                jumpstop = false;
                state = states.skibounce;
                FMODevent_oneshot("event:/Sfx/Player/jump", x, y);
                image_index = 0;
                sprite_index = spr_player_ski_bounce;
            }
            
            if (slapBuffer)
            {
                slapBuffer = false;
                movespeed = 17;
                state = states.skirow;
                image_index = 0;
                sprite_index = spr_player_ski_row;
            }
        }
        
        if (!grounded)
        {
            if (sprite_index != spr_player_ski_bump)
            {
                if (movespeed > 10)
                    movespeed -= 0.05;
                
                sprite_index = spr_player_ski_fall;
            }
            
            if (jumpstop == false && !key_jump && vsp < grav)
                vsp = grav;
        }
        
        image_speed = (sprite_index != spr_player_ski_getup) ? 0.4 : 0.5;
    }
    else
    {
        image_speed = 0.35;
        movespeed = 0;
        
        if (animation_end())
        {
            poletreeID.launchbuffer = 10;
            xscale = -poletreeID.image_xscale;
            movespeed = 14;
            poletreeID = -4;
        }
    }
}

function scr_player_skibounce()
{
    get_input();
    var move = key_right + key_left;
    hsp = movespeed * xscale;
    
    if (move == -xscale)
        movespeed -= 0.1;
    
    if (jumpstop == false && !key_jump && vsp < grav)
        vsp = grav;
    
    if (vsp >= 2)
        vsp += 0.25;
    
    if (grounded && vsp >= 0)
    {
        state = states.ski;
        sprite_index = spr_player_ski_getup;
        image_index = 0;
    }
    
    image_speed = 0.6;
}

function scr_player_skirow()
{
    hsp = movespeed * xscale;
    movespeed = approach(movespeed, 11, 0.2);
    
    if (animation_end())
    {
        state = states.ski;
        image_index = 0;
        sprite_index = spr_player_ski_getup;
    }
    
    if (!grounded)
    {
        state = states.ski;
        sprite_index = spr_player_ski_fall;
    }
}
