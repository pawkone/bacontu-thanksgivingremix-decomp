function scr_player_parry()
{
    grav = 0.5;
    get_input();
    image_speed = 0.4;
    hsp = movespeed * xscale;
    movespeed = approach(movespeed, 0, 0.5);
    
    if (animation_end())
    {
        state = states.normal;
        sprite_index = spr_player_idle;
        image_index = 0;
    }
}
