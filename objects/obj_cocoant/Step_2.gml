if (hitstun.is == false)
{
    event_inherited();
    
    switch (state)
    {
        case states.stun:
            scr_enemy_stun();
            break;
        
        case states.hit:
            scr_enemy_hit();
            break;
        
        case states.turn:
            scr_enemy_turn();
            break;
        
        case states.move:
            attackTimer--;
            image_speed = 0.35;
            hsp = movespeed * xscale;
            movespeed = 1;
            
            if (buffers.step <= 0)
            {
                buffers.step = 45;
                create_particleStatic(spr_cloudeffect, x, y + 42, 1, 1);
            }
            
            buffers.step--;
            sprite_index = spr_move;
            
            if (place_meeting(x + xscale, y, obj_solid) || place_meeting(x + xscale, y, obj_hallway) || (!(place_meeting(x + (xscale * 15), y + 31, obj_solid) || place_meeting(x + (xscale * 15), y + 31, obj_slope) || place_meeting(x + (xscale * 15), y + 31, obj_platform)) && grounded))
            {
                image_speed = 0.35;
                xscale *= -1;
            }
            
            if (point_distance(x, 0, obj_player.x, 0) <= 320 && point_distance(0, y, 0, obj_player.y) <= 160 && (obj_player.state == states.mach3 || obj_player.state == states.buzzsaw))
            {
                vsp = -5;
                
                if (obj_player.x != x)
                    xscale = sign(obj_player.x - x);
                
                sprite_index = spr_scared;
                scared = 120;
                state = states.stun;
            }
            
            break;
        
        case states.grab:
            scr_enemy_grabbed();
            break;
        
        case states.thrown:
            scr_enemy_thrown();
            break;
        
        case states.uppercut:
            image_speed = 0.35;
            
            if (animation_end() && sprite_index == spr_cocoant_shootprep)
            {
                if (obj_player.x != x)
                    xscale = sign(obj_player.x - x);
                
                sprite_index = spr_cocoant_shoot;
                image_index = 0;
                vsp = -4;
                hsp = -4 * xscale;
                
                with (instance_create_depth(x, y, depth, obj_dart))
                    image_xscale = other.xscale;
                
                FMODevent_oneshot("event:/Sfx/General/Enemy/dart", x, y);
            }
            
            if (animation_end() && sprite_index == spr_cocoant_shoot)
            {
                image_index = 0;
                sprite_index = spr_move;
                state = states.move;
            }
            
            movespeed = 0;
            break;
    }
    
    if (attackTimer <= 0 && point_distance(x, 0, obj_player.x, 0) <= 320 && point_distance(0, y, 0, obj_player.y) <= 42 && state == states.move)
    {
        attackTimer = 120;
        state = states.uppercut;
        sprite_index = spr_cocoant_shootprep;
        image_index = 0;
        
        if (obj_player.x != x)
            xscale = sign(obj_player.x - x);
    }
}
else if (hitstun.time >= 0)
{
    image_speed = 0;
    x = hitstun.x + irandom_range(-5, 5);
    y = hitstun.y + irandom_range(-5, 5);
    hitstun.time--;
}
else
{
    x = hitstun.x;
    y = hitstun.y;
    hitstun.is = false;
}
