function scr_player_buzzsaw()
{
    get_input();
    image_speed = 0.7;
    hsp = movespeed * xscale;
    
    if (movespeed > 14)
        movespeed = 14;
    
    var move = key_right + key_left;
    buffers.afterimageBlur = approach(buffers.afterimageBlur, 0, 1);
    
    if (buffers.afterimageBlur == 0)
    {
        buffers.afterimageBlur = 3;
        create_buzzsawAfterimage(sprite_index, image_index, x, y, xscale);
    }
    
    if (key_down2)
    {
        if (vsp < 15)
            vsp = 15;
        
        sprite_index = spr_player_buzzsawFastFall;
    }
    
    if (vsp >= -5)
        vsp += 0.15;
    
    if ((place_meeting(x + sign(hsp), y, obj_solid) && !grounded && (!place_meeting(x + sign(hsp), y, obj_metalblock) && !place_meeting(x + sign(hsp), y, obj_secretmetalblock))) || (scr_slope(x, y + 4) && place_meeting(x + sign(hsp), y - 4, obj_solid) && !place_meeting(x + hsp, y, obj_destructibles)))
    {
        if (vsp < 10)
            vsp = 10;
        
        movespeed /= 2;
        xscale *= -1;
        create_particleStatic(spr_bangeffect, x, y, 1, 1);
        FMODevent_oneshot("event:/Sfx/Player/airbump", x, y);
        image_index = 0;
        sprite_index = spr_player_buzzsawBump;
    }
    
    if (animation_end() && sprite_index == spr_player_buzzsawBump)
        sprite_index = spr_player_buzzsaw;
    
    if (grounded)
    {
        if (movespeed < 12)
            movespeed = 12;
        
        state = states.mach2;
        sprite_index = spr_player_rollgetup;
        image_index = 0;
    }
    
    doTaunt();
    
    if (slapBuffer > 8 || place_meeting(x + xscale, y, obj_metalblock))
    {
        slapBuffer = false;
        
        if (move != 0)
            xscale = move;
        
        create_particleStatic(spr_crazyrunothereffect, x, y, xscale, 1);
        create_particleStatic(spr_grabcloud, x, y, xscale, 1);
        
        if (movespeed < 13)
            movespeed = 13;
        
        state = states.mach3;
        jumpstop = true;
        vsp = -7;
        sprite_index = spr_player_buzzsawCancel;
        image_index = 0;
    }
}
