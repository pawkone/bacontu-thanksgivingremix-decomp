if (global.escape.active)
{
    var __val = super ? 20 : 10;
    global.collect += __val;
    global.combo.timer += 10;
    global.combo.timer = clamp(global.combo.timer, 0, 60);
    create_smalltext(__val);
    create_collect(sprite_index, x, y);
    ds_list_add(global.escaperoom, id);
    instance_destroy();
    FMODevent_oneshot("event:/Sfx/General/Collects/escapecollect", x, y);
}
