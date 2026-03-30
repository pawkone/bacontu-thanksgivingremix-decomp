function scr_player_machturn()
{
    image_speed = 0.35;
    get_input();
    hsp = movespeed * xscale;
    var move = key_right + key_left;
    movespeed = approach(movespeed, 0, 0.4);
    buffers.afterimageBlur = approach(buffers.afterimageBlur, 0, 1);
    buffers.dashcloud--;
    
    if (buffers.dashcloud <= 0 && grounded)
    {
        buffers.dashcloud = 12;
        create_particleStatic(spr_dashcloud1, x, y, xscale, 1);
    }
    
    if (buffers.afterimageBlur == 0)
    {
        buffers.afterimageBlur = 3;
        create_blur_effect(sprite_index, image_index, x, y, xscale);
    }
    
    if (animation_end() && sprite_index == spr_player_mach2turn)
        sprite_index = spr_player_mach2turnfall;
    
    if (animation_end() && sprite_index == spr_player_mach3turn)
        sprite_index = spr_player_mach3turnfall;
    
    if (grounded && animation_end())
    {
        if (sprite_index == spr_player_mach2turn)
        {
            xscale *= -1;
            movespeed = 8;
            state = states.mach2;
            sprite_index = spr_player_mach2;
            image_index = 0;
        }
        else if (sprite_index == spr_player_mach3turn)
        {
            xscale *= -1;
            movespeed = 12;
            state = states.mach3;
            sprite_index = spr_player_mach3;
            image_index = 0;
        }
    }
    
    if (grounded)
    {
        if (sprite_index == spr_player_mach2turnfall)
        {
            xscale *= -1;
            movespeed = 8;
            state = states.mach2;
            sprite_index = spr_player_mach2;
            image_index = 0;
        }
        else if (sprite_index == spr_player_mach3turnfall)
        {
            xscale *= -1;
            movespeed = 12;
            state = states.mach3;
            sprite_index = spr_player_mach3;
            image_index = 0;
        }
    }
}
