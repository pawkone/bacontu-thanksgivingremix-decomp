if (ds_map_exists(musicDetails, room))
{
    var _map = ds_map_find_value(musicDetails, room);
    
    if (music.regular != _map.music)
    {
        if (musicInst != -4)
        {
            fmod_studio_event_instance_stop(musicInst, states.normal);
            fmod_studio_event_instance_release(musicInst);
            musicInst = -4;
        }
        
        if (_map.music != -4)
        {
            music.regular = _map.music;
            musicInst = FMODcreate_event(_map.music);
            fmod_studio_event_instance_start(musicInst);
        }
    }
    
    if (music.ambience != _map.ambience)
    {
        if (ambienceInst != -4)
        {
            fmod_studio_event_instance_stop(ambienceInst, states.normal);
            fmod_studio_event_instance_release(ambienceInst);
            ambienceInst = -4;
        }
        
        if (_map.ambience != -4)
        {
            music.ambience = _map.ambience;
            ambienceInst = FMODcreate_event(_map.ambience);
            fmod_studio_event_instance_start(ambienceInst);
        }
    }
    
    if (music.secret != _map.secret)
    {
        if (secretInst != -4)
        {
            fmod_studio_event_instance_stop(secretInst, states.normal);
            fmod_studio_event_instance_release(secretInst);
            secretInst = -4;
        }
        
        if (_map.secret != -4)
        {
            music.secret = _map.secret;
            secretInst = FMODcreate_event(_map.secret);
            fmod_studio_event_instance_start(secretInst);
        }
    }
    
    func = _map.func;
}

fmod_studio_event_instance_set_paused(escapeInst, isSecret);

if (musicInst != -4)
    fmod_studio_event_instance_set_paused(musicInst, isSecret || FMODevent_isplaying(escapeInst));

if (ambienceInst != -4)
    fmod_studio_event_instance_set_paused(ambienceInst, isSecret || FMODevent_isplaying(ambienceInst));

if (secretInst != -4)
    fmod_studio_event_instance_set_paused(secretInst, !isSecret);
