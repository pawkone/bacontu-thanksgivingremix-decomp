if (ds_list_find_index(global.saveroom, id) == -1)
{
    ds_list_add(global.saveroom, id);
    FMODevent_oneshot("event:/Sfx/General/Level/breakblock", x, y);
    var __val = 10;
    global.collect += __val;
    global.combo.timer += 10;
    global.combo.timer = clamp(global.combo.timer, 0, 60);
    create_smalltext(__val);
    ds_list_add(global.saveroom, id);
    instance_destroy();
    FMODevent_oneshot("event:/Sfx/General/Collects/collect", x, y);
    create_particleStatic(spr_destroyabledonut_smallDead, x + 16, y + 16, 1, depth);
}
