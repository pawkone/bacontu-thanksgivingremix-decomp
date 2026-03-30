function scr_enemy_turn()
{
    hsp = 0;
    
    if (animation_end())
    {
        xscale *= -1;
        sprite_index = spr_move;
        image_index = 0;
        state = states.move;
        hsp = movespeed * xscale;
    }
}
