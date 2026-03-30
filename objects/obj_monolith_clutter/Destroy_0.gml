if (ds_list_find_index(global.saveroom, id) == -1)
{
    ds_list_add(global.saveroom, id);
    
    with (instance_create_depth(x, y, -5, obj_baddiedead))
    {
        sprite_index = other.sprite_index;
        image_speed = 0;
        image_index = other.image_index;
    }
    
    FMODevent_oneshot("event:/Sfx/General/Level/breakblock", x, y);
}
