if (ds_list_find_index(global.saveroom, id) == -1)
{
    ds_list_add(global.saveroom, id);
    scr_transfotip(lang_get_phrase("buddy_release"));
    FMODevent_oneshot("event:/Sfx/General/Buddy/laugh", x, y);
    var i = 0;
    
    repeat (sprite_get_number(spr_buddyDebri))
    {
        create_particleDebri(spr_buddyDebri, i, x + 16, y + 16, 1, -1);
        i++;
    }
}
