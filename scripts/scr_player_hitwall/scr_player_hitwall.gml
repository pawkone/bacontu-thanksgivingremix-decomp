function scr_player_hitwall()
{
    image_speed = 0.35;
    hsp = movespeed * xscale;
    
    if (grounded)
        movespeed = 0;
    
    if (sprite_index == spr_player_wallsplat)
    {
        movespeed = 0;
        hsp = 0;
        vsp = 0;
    }
    
    if (animation_end())
    {
        image_index = 0;
        sprite_index = spr_player_land;
        state = states.normal;
    }
}
