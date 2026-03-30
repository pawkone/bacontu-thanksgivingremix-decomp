function hurt_player(_obj = -4)
{
    with (obj_player)
    {
        FMODevent_oneshot("event:/Sfx/Player/hurt", x, y);
        global.collect -= 100;
        
        if (global.collect < 0)
            global.collect = 0;
        
        global.combo.timer -= 25;
        global.combo.timer = clamp(global.combo.timer, 0, 60);
        i_frame = 100;
        var sameFace = true;
        
        if (_obj != -4)
        {
            var facing = sign(x - _obj.x);
            sameFace = xscale == facing;
            
            if (facing != 0)
                xscale = facing;
        }
        
        hsp = 8 * xscale;
        sprite_index = !sameFace ? spr_player_hurt : spr_player_hurt2;
        flash = true;
        state = states.hurt;
        vsp = -12;
        
        repeat (8)
        {
            create_particleDebri(spr_baddie_gibs, irandom_range(0, sprite_get_number(spr_baddie_gibs)), x, y, 1, -5);
            create_particleDebri(spr_slapstar, irandom_range(0, sprite_get_number(spr_slapstar)), x, y, 1, -5);
        }
    }
}

function doBump(_height)
{
    var o_y = y;
    var rep = 0;
    
    while (place_meeting(x + xscale, y, obj_solid))
    {
        y--;
        rep++;
        
        if (rep > _height)
        {
            y = o_y;
            return true;
        }
    }
    
    return false;
}

function generalReset()
{
    instance_destroy(obj_comboTitle);
    ds_list_clear(global.saveroom);
    ds_list_clear(global.escaperoom);
    ds_list_clear(global.followers);
    global.level_timer = 0;
    global.collect = 0;
    global.secretCount = 0;
    global.hasFlag = false;
    obj_player.door = "A";
    obj_player.visible = true;
    obj_player.hallway = false;
    obj_player.super = false;
    obj_player.xs = 1;
    obj_player.ys = 1;
    
    with (obj_hud)
    {
        tv.sprite_index = spr_tv_off;
        combometer.y = 237;
        combometer.caty = combometer.y - 3;
        combometer.state = -1;
    }
    
    global.escape = 
    {
        active: false,
        timer: 7200,
        party: false
    };
    global.pumpkins = 
    {
        count: 0,
        amount: 12,
        activeStein: false
    };
    global.combo = 
    {
        dropped: false,
        amt: 0,
        timer: 60,
        previouscombo: 0,
        savecombo: 0
    };
}

function playerSounds()
{
    if (state == states.tumble || state == states.buzzsaw)
    {
        fmod_studio_event_instance_set_paused(soundsRoll, false);
        
        if (!FMODevent_isplaying(soundsRoll))
            fmod_studio_event_instance_start(soundsRoll);
        
        FMODSet3dPos(soundsRoll, x, y);
    }
    else
    {
        fmod_studio_event_instance_stop(soundsRoll, states.crouch);
    }
    
    if (state == states.groundpoundstart || state == states.groundpound)
    {
        fmod_studio_event_instance_set_paused(soundsGroundpound, false);
        
        if (!FMODevent_isplaying(soundsGroundpound))
            fmod_studio_event_instance_start(soundsGroundpound);
        
        FMODSet3dPos(soundsGroundpound, x, y);
    }
    else
    {
        fmod_studio_event_instance_stop(soundsGroundpound, states.crouch);
    }
    
    if (state == states.superjumpprep)
    {
        fmod_studio_event_instance_set_paused(soundsSuperjump, false);
        
        if (!FMODevent_isplaying(soundsSuperjump))
            fmod_studio_event_instance_start(soundsSuperjump);
        
        FMODSet3dPos(soundsSuperjump, x, y);
    }
    else
    {
        fmod_studio_event_instance_stop(soundsSuperjump, states.crouch);
    }
    
    if (state == states.mach2 || state == states.mach3 || state == states.climbwall)
    {
        fmod_studio_event_instance_set_paused(soundsMach, false);
        
        if (!FMODevent_isplaying(soundsMach))
            fmod_studio_event_instance_start(soundsMach);
        
        var s = 0;
        
        if (state == states.mach2 && sprite_index == spr_player_mach1 && grounded)
            s = 0;
        else if (state == states.mach2 && sprite_index != spr_player_mach1)
            s = 1;
        else if (state == states.mach3 && sprite_index != spr_player_crazyrun)
            s = 2;
        else if (sprite_index == spr_player_crazyrun)
            s = 3;
        
        FMODSet3dPos(soundsMach, x, y);
        
        if (fmod_studio_event_instance_get_parameter_by_name(soundsMach, "state") != s)
            fmod_studio_event_instance_set_parameter_by_name(soundsMach, "state", s);
    }
    else
    {
        fmod_studio_event_instance_stop(soundsMach, states.crouch);
    }
}

function doGrab()
{
    if (slapBuffer > 0)
    {
        if (!key_up)
        {
            fmod_studio_event_instance_start(soundGrab);
            FMODSet3dPos(soundGrab, x, y);
            slapBuffer = false;
            state = states.grab;
            sprite_index = spr_player_grab;
            image_index = 0;
            create_particleStatic(spr_grabcloud, x, y, xscale, 1);
            
            if (movespeed < 8)
                movespeed = 8;
        }
        else
        {
            FMODevent_oneshot("event:/Sfx/Player/uppercut", x, y);
            slapBuffer = false;
            state = states.uppercut;
            
            if (coyote_time)
                vsp = -17;
            else
                vsp = -12;
            
            sprite_index = spr_player_uppercut;
            image_index = 0;
            create_particleStatic(spr_jumpeffect, x, y, 1, 1);
        }
    }
}

function slope_momentum(_accel = 0.1, _deccel = 0)
{
    if (scr_slope(x, y + 1))
    {
        var _obj = scr_slope_get();
        
        if (instance_exists(_obj))
        {
            if (sign(_obj.image_xscale) != xscale)
            {
                if (movespeed < 20)
                    movespeed += _accel;
            }
            else
            {
                movespeed -= _deccel;
            }
        }
    }
}

function doTaunt()
{
    if (key_taunt2)
    {
        tauntVars = 
        {
            sprite_index: sprite_index,
            image_index: image_index,
            state: state,
            vsp: vsp,
            hsp: hsp,
            movespeed: movespeed,
            image_speed: image_speed
        };
        tauntTimer = 15;
        state = states.taunt;
        image_speed = 0;
        sprite_index = spr_player_taunt;
        image_index = irandom_range(0, image_number);
        instance_create_depth(x, y, depth + 2, obj_taunteffect);
        instance_create_depth(x, y, 2, obj_parryhitbox);
        FMODevent_oneshot("event:/Sfx/Player/taunt", x, y);
        
        if (instance_exists(obj_server))
        {
            with (obj_server)
                instance_create_online(other.x, other.y, other.depth + 2, obj_onlineTaunteffect);
        }
    }
}
