event_inherited();
global.collect += 1000;
global.combo.timer = 60;
create_smalltext(1000);
FMODevent_oneshot("event:/Sfx/General/Collects/toppinget", x, y);
tv_anim(spr_tv_happy, 180);

with (obj_player)
{
    if (chance(0.25))
        fmod_studio_event_instance_start(soundsLaugh);
}
