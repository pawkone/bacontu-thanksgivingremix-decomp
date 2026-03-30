if (ds_list_find_index(global.saveroom, id) == -1)
{
    ds_list_add(global.saveroom, id);
    shake_camera(40);
    
    repeat (8)
        create_particleDebri(spr_metalblock_debri, random_range(0, sprite_get_number(spr_metalblock_debri)), x + 16, y + 16, 1, -1);
    
    FMODevent_oneshot("event:/Sfx/General/Level/metalbreak", x, y);
    create_particleStatic(spr_bangeffect, x + 16, y + 16, 1, 1);
    create_particleStatic(spr_genericpoofeffect, x + 16, y + 16, 1, 2);
}
