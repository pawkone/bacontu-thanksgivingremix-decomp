if (global.escape.active == true)
{
    instance_destroy();
    
    with (obj_player)
    {
        vsp = 0;
        state = -4;
        sprite_index = spr_player_lookdoor;
        image_index = 0;
        FMODstopAll();
        instance_create_depth(0, 0, 1, obj_rank);
    }
}
