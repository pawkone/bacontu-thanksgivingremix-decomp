function scr_player_groundpoundstart()
{
    get_input();
    var move = key_right + key_left;
    hsp = approach(hsp, movespeed * move, (movespeed > 7) ? 0.05 : 0.25);
    
    if (move != 0)
    {
        movespeed = 7;
    }
    else
    {
        movespeed = 0;
        hsp = 0;
    }
    
    move = key_right + key_left;
    image_speed = 0.35;
    
    if (vsp < 0)
        freefallsmash = -7;
    
    if (vsp > 0)
    {
        state = states.groundpound;
        create_particleStatic(spr_cloudeffect, x, y, 1, 1);
        buffers.crazyothereffect = 0;
    }
    
    buffers.afterimageBlur = approach(buffers.afterimageBlur, 0, 1);
    
    if (buffers.afterimageBlur == 0)
    {
        buffers.afterimageBlur = 4;
        create_blur_effect(sprite_index, image_index, x, y, xscale);
    }
}

function scr_player_groundpound()
{
    get_input();
    var move = key_right + key_left;
    hsp = approach(hsp, movespeed * move, (abs(hsp) > 7) ? 0.05 : 1);
    
    if (move != 0 && move == xscale)
    {
        movespeed = 7;
    }
    else
    {
        movespeed = 0;
        hsp = 0;
    }
    
    if (move != 0)
        xscale = move;
    
    image_speed = 0.35;
    
    if (vsp < 0)
        freefallsmash = -7;
    
    vsp += 0.7;
    buffers.afterimageBlur = approach(buffers.afterimageBlur, 0, 1);
    
    if (buffers.afterimageBlur == 0)
    {
        buffers.afterimageBlur = 4;
        create_blur_effect(sprite_index, image_index, x, y, xscale);
    }
    
    if (vsp > 0)
        freefallsmash++;
    
    if (freefallsmash >= 10)
    {
        if (!instance_exists(chargeeffect))
            chargeeffect = instance_create_depth(x, y, -2, obj_chargeeffect);
        
        buffers.afterimageMach = approach(buffers.afterimageMach, 0, 1);
        
        if (buffers.afterimageMach == 0)
        {
            buffers.afterimageMach = 4;
            create_afterimage(sprite_index, image_index, x, y, xscale, 1);
        }
        
        buffers.crazyothereffect--;
        
        if (buffers.crazyothereffect <= 0)
        {
            buffers.crazyothereffect = 9;
            
            with (create_particleStatic(spr_crazyrunothereffect, x, y, 1, 1))
            {
                image_angle = -90;
                image_speed = 0.5;
            }
        }
    }
    
    if (sprite_index == spr_player_groundpoundstart && animation_end())
        sprite_index = spr_player_groundpound;
    
    if (grounded && vsp > 0 && (!place_meeting(x, y + 1, obj_destructibles) || (!place_meeting(x, y + 1, obj_metalblock) && vsp > 15)))
    {
        if (scr_slope(x, y + 1) && sprite_index != spr_player_piledriver)
        {
            var slope = instance_place(x, y + 1, obj_slope);
            xscale = -sign(slope.image_xscale);
            movespeed = (freefallsmash >= 10) ? 12 : 8;
            state = states.tumble;
            sprite_index = spr_player_rolling;
            FMODevent_oneshot("event:/Sfx/Player/crouchslide", x, y);
            create_particleStatic(spr_superdashcloud, x, y, xscale, 1);
        }
        else
        {
            if (sprite_index == spr_player_piledriver)
            {
                sprite_index = spr_player_piledriverend;
                
                if (instance_exists(enemyID) && enemyID.state == states.grab)
                {
                    FMODevent_oneshot("event:/Sfx/Player/punch", x, y);
                    
                    repeat (8)
                    {
                        create_particleDebri(spr_baddie_gibs, irandom_range(0, sprite_get_number(spr_baddie_gibs)), x, y, 1, -5);
                        create_particleDebri(spr_slapstar, irandom_range(0, sprite_get_number(spr_slapstar)), x, y, 1, -5);
                    }
                    
                    create_particleStatic(spr_kungfueffect, x, y, 1, 2);
                    
                    with (enemyID)
                        instance_destroy();
                    
                    enemyID = -4;
                }
            }
            else if (sprite_index == spr_player_divebomb)
            {
                sprite_index = spr_player_divebombland;
            }
            else
            {
                sprite_index = spr_player_groundpoundland;
            }
            
            image_index = 0;
            vsp = 0;
            hsp = 0;
            state = states.freefallland;
            movespeed = abs(hsp);
            
            if (freefallsmash >= 10)
                shake_camera(25);
            else
                shake_camera(10);
            
            FMODevent_oneshot("event:/Sfx/Player/slam", x, y);
            create_particleStatic(spr_groundpoundeffect, x, y, 1, -2);
        }
    }
}
