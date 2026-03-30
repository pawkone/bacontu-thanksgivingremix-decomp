function scr_player_machslide()
{
    get_input();
    hsp = movespeed * xscale;
    movespeed = approach(movespeed, 0, 0.4);
    image_speed = 0.35;
    buffers.afterimageBlur = approach(buffers.afterimageBlur, 0, 1);
    
    if (buffers.afterimageBlur == 0)
    {
        buffers.afterimageBlur = 3;
        create_blur_effect(sprite_index, image_index, x, y, xscale);
    }
    
    if (animation_end() && sprite_index == spr_player_machslidestart)
    {
        sprite_index = spr_player_machslide;
        image_index = 0;
    }
    
    if (movespeed == 0 && sprite_index != spr_player_machslideend)
    {
        sprite_index = spr_player_machslideend;
        image_index = 0;
        state = states.normal;
    }
    
    if (place_meeting(x + sign(hsp), y, obj_solid))
    {
        FMODevent_oneshot("event:/Sfx/Player/bump", x, y);
        state = states.hitwall;
        sprite_index = spr_player_wallsplat;
        image_index = 0;
    }
    
    buffers.dashcloud--;
    
    if (buffers.dashcloud <= 0 && grounded)
    {
        buffers.dashcloud = 12;
        create_particleStatic(spr_dashcloud1, x, y, xscale, 1);
    }
}
