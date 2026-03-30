event_inherited();
tv_anim(spr_tv_happy, 180);
global.combo.timer = 60;

with (obj_player)
{
    if (chance(0.25))
        fmod_studio_event_instance_start(soundsLaugh);
}

spr_idle = spr_magician_idle;
spr_walk = spr_magician_move;
spr_panicidle = spr_magician_idle;
spr_intro = spr_potablebean_intro;
spr_taunt = spr_magician_taunt;
