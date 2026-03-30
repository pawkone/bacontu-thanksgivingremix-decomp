if (other.grounded && other.key_up && other.state != states.enterdoor && other.state != states.walkfront)
{
    with (other)
    {
        targetRoom = other.targetRoom;
        door = other.targetDoor;
        hallway = false;
        movespeed = 0;
        vsp = 0;
        hsp = 0;
        state = states.enterdoor;
        sprite_index = spr_player_lookdoor;
        image_index = 0;
    }
}
