switch (state)
{
    case states.normal:
        image_speed = 0.35;
        
        if (sprite_index != spr_intro)
        {
            event_inherited();
            
            if (og_x != x || og_y != y)
            {
                sprite_index = spr_walk;
                og_x = x;
                og_y = y;
            }
            else
            {
                sprite_index = global.escape.active ? spr_panicidle : spr_idle;
            }
            
            if (obj_player.state == states.taunt)
            {
                sprite_index = spr_taunt;
                image_index = irandom_range(0, image_number);
                state = states.taunt;
            }
        }
        else if (animation_end())
        {
            sprite_index = spr_idle;
        }
        
        break;
    
    case states.taunt:
        image_speed = 0;
        
        if (obj_player.state != states.taunt)
            state = states.normal;
        
        break;
}
