if (ds_list_find_index(global.saveroom, id) == -1)
{
    ds_list_add(global.saveroom, id);
    FMODevent_oneshot("event:/Sfx/General/Level/breakblock", x, y);
}

for (var _y = 0; _y < abs(sprite_height / 32); _y++)
{
    for (var _x = 0; _x < abs(sprite_width / 32); _x++)
        tile_delete(x + (_x * 32), y + (_y * 32));
}

scr_cutoff();
