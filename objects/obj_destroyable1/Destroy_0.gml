if (ds_list_find_index(global.saveroom, id) == -1)
{
    ds_list_add(global.saveroom, id);
    
    repeat (8)
        create_particleDebri(spr_destroyablecrate_debri, random_range(0, sprite_get_number(spr_destroyablecrate_debri)), x + 16, y + 16, 1, -1);
    
    FMODevent_oneshot("event:/Sfx/General/Level/breakblock", x, y);
}
