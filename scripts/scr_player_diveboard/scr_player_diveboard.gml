function scr_player_diveboard()
{
    vsp = 0;
    hsp = 0;
    image_speed = 0.35;
    sprite_index = spr_player_divingboard;
    
    if (animation_end())
    {
        movespeed = diveboardSaved.movespeed;
        state = diveboardSaved.state;
        sprite_index = diveboardSaved.sprite_index;
        image_index = diveboardSaved.image_index;
        y = diveboardSaved.y - 3;
        vsp = -14;
    }
}
