function scr_player_hurt()
{
    image_speed = 0.35;
    
    if (grounded && vsp >= 0)
    {
        movespeed = 0;
        sprite_index = spr_player_land;
        state = states.normal;
    }
}
