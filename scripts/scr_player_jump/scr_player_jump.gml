function scr_player_jump()
{
    get_input();
    hsp = movespeed * xscale;
    var move = key_right + key_left;
    image_speed = 0.35;
    
    if (jumpstop == false && !key_jump && vsp < grav)
    {
        jumpstop = true;
        vsp /= 20;
    }
    
    if (move != 0)
    {
        xscale = move;
        
        if (!place_meeting(x + xscale, y, obj_solid))
            movespeed = approach(movespeed, 6, 0.5);
        else
            movespeed = approach(movespeed, 0, 0.67);
    }
    else
    {
        movespeed = approach(movespeed, 0, 0.67);
    }
    
    if (animation_end() && sprite_index == spr_player_jump)
    {
        image_index = 0;
        sprite_index = spr_player_fall;
    }
    
    if (animation_end() && sprite_index == spr_player_grabcancel)
    {
        image_index = 0;
        sprite_index = spr_player_fall;
    }
    
    if (((key_down2 && global.dirGround) || (key_groundpound2 && !global.dirGround)) && !grounded)
    {
        vsp = -6;
        sprite_index = spr_player_groundpoundstart;
        image_index = 0;
        state = states.groundpoundstart;
    }
    
    if (grounded)
    {
        create_particleStatic(spr_landeffect, x, y, 1, 1);
        image_index = 0;
        sprite_index = (move != 0) ? spr_player_land2 : spr_player_land;
        state = states.normal;
        FMODevent_oneshot("event:/Sfx/Player/step", x, y);
    }
    
    doTaunt();
    
    if (sprite_index != spr_player_grabbump)
        doGrab();
}
