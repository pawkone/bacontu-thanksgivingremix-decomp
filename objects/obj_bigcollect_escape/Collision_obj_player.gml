if (global.escape.active)
{
    var __val = super ? 200 : 100;
    global.collect += __val;
    global.combo.timer = 60;
    create_smalltext(__val);
    create_collect(sprite_index, x, y);
    ds_list_add(global.escaperoom, id);
    instance_destroy();
    FMODevent_oneshot("event:/Sfx/General/Collects/escapecollectBig", x, y);
    tv_anim(spr_tv_happy, 180);
    
    with (obj_player)
    {
        if (chance(0.25))
            fmod_studio_event_instance_start(soundsLaugh);
    }
}
