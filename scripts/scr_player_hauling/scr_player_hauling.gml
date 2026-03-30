function scr_player_hauling()
{
    get_input();
    hsp = movespeed * xscale;
    var move = key_right + key_left;
    
    if (animation_end() && sprite_index == spr_player_haulingland)
    {
        sprite_index = spr_player_haulingidle;
        image_index = 0;
    }
    
    if (animation_end() && sprite_index == spr_player_haulingjump)
    {
        sprite_index = spr_player_haulingfall;
        image_index = 0;
    }
    
    if (jumpstop == false && !key_jump && vsp < grav)
    {
        jumpstop = true;
        vsp /= 20;
    }
    
    if (grounded && (sprite_index == spr_player_haulingfall || sprite_index == spr_player_haulingjump))
    {
        sprite_index = spr_player_haulingidle;
        image_index = 0;
        create_particleStatic(spr_landeffect, x, y, 1, 1);
    }
    
    if (move != 0)
    {
        if (sprite_index == spr_player_haulingidle)
        {
            image_index = 0;
            sprite_index = spr_player_haulingwalk;
        }
        
        xscale = move;
        movespeed = approach(movespeed, 6, 0.5);
        buffers.step--;
        
        if (sprite_index == spr_player_haulingwalk)
        {
            image_speed = movespeed / 15;
            
            if ((floor(image_index) == 3 || floor(image_index) == 8) && buffers.step <= 0)
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
        
        if (sprite_index == spr_player_haulingwalk)
        {
            image_index = 0;
            sprite_index = spr_player_haulingidle;
        }
    }
    
    if (!grounded && sprite_index != spr_player_haulingjump && sprite_index != spr_player_haulingfall)
    {
        image_index = 0;
        sprite_index = spr_player_haulingfall;
    }
    
    if (jumpBuffer && grounded)
    {
        jumpBuffer = false;
        create_particleStatic(spr_jumpeffect, x, y, 1, 1);
        image_speed = 0.35;
        image_index = 0;
        sprite_index = spr_player_haulingjump;
        vsp = -12;
        jumpstop = false;
        FMODevent_oneshot("event:/Sfx/Player/jump", x, y);
    }
    
    if (slapBuffer)
    {
        slapBuffer = false;
        state = states.finishingblow;
        sprite_index = choose(spr_player_finisher1, spr_player_finisher2);
        image_index = 0;
    }
    
    if (key_down && grounded)
    {
        image_speed = 0.35;
        image_index = 0;
        sprite_index = spr_player_crouch;
        state = states.crouch;
    }
    
    if (key_down2 && !grounded)
    {
        vsp = -6;
        sprite_index = spr_player_piledriver;
        image_index = 0;
        state = states.groundpoundstart;
    }
    
    if (!instance_exists(enemyID))
    {
        state = states.normal;
        sprite_index = spr_player_idle;
    }
}

function scr_player_finishingblow()
{
    image_speed = 0.35;
    hsp = movespeed * xscale;
    
    if (instance_exists(enemyID) && floor(image_index) > 4 && enemyID.state == states.grab)
    {
        movespeed = -4;
        vsp = -4;
        FMODevent_oneshot("event:/Sfx/Player/punch", x, y);
        
        repeat (8)
        {
            create_particleDebri(spr_baddie_gibs, irandom_range(0, sprite_get_number(spr_baddie_gibs)), x, y, 1, -5);
            create_particleDebri(spr_slapstar, irandom_range(0, sprite_get_number(spr_slapstar)), x, y, 1, -5);
        }
        
        create_particleStatic(spr_kungfueffect, x, y, 1, 2);
        
        with (enemyID)
        {
            hitHsp = 25 * other.xscale;
            hitVsp = 0;
            state = states.thrown;
        }
        
        enemyID = -4;
    }
    
    if (animation_end())
    {
        slapBuffer = false;
        state = states.jump;
        sprite_index = spr_player_fall;
        movespeed = 0;
        hsp = 0;
    }
    
    buffers.afterimageMach = approach(buffers.afterimageMach, 0, 1);
    
    if (buffers.afterimageMach == 0)
    {
        buffers.afterimageMach = 4;
        create_afterimage(sprite_index, image_index, x, y, xscale, 1);
    }
}
