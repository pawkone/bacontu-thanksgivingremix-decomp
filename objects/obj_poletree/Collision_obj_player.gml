if (other.poletreeID == -4 && launchbuffer <= 0)
{
    with (other)
    {
        sprite_index = spr_poletree_launch;
        image_index = 0;
        poletreeID = other.id;
    }
}
