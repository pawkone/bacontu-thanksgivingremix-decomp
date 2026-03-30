if (other.grounded && other.key_up && other.state != states.enterdoor && other.state != states.walkfront && global.escape.active)
{
    with (other)
    {
        vsp = 0;
        state = -4;
        sprite_index = spr_player_lookdoor;
        image_index = 0;
        FMODstopAll();
        instance_create_depth(0, 0, 1, obj_rank);
    }
}
