if (active == false)
{
    sprite_index = asset_get_index(string("spr_lover{0}_wait", lover));
    
    if (place_meeting(x, y, obj_player))
    {
        global.secretCount++;
        ds_list_add(global.saveroom, id);
        active = true;
        sprite_index = asset_get_index(string("spr_lover{0}_trans", lover));
        alarm[0] = 1;
        create_smalltext(100);
        ds_list_add(global.saveroom, id);
        FMODevent_oneshot("event:/Sfx/General/Collects/bigcollect", x, y);
        FMODevent_oneshot("event:/Sfx/General/Level/Doodles/iloveyou", x, y);
        tv_anim(spr_tv_happy, 180);
        
        with (obj_player)
        {
            if (chance(0.25))
                fmod_studio_event_instance_start(soundsLaugh);
        }
        
        scr_transfotip(lang_get_phrase("secret_get"));
    }
}

if (animation_end() && sprite_index == asset_get_index(string("spr_lover{0}_trans", lover)))
    sprite_index = asset_get_index(string("spr_lover{0}_chocolate", lover));
