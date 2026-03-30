global.Fmod3dDefaults = 
{
    position: 
    {
        x: 0,
        y: 0,
        z: 0
    },
    velocity: 
    {
        x: 0,
        y: 0,
        z: 0
    },
    forward: 
    {
        x: 0,
        y: 0,
        z: 1
    },
    up: 
    {
        x: 0,
        y: 1,
        z: 0
    }
};
global.FMOD_existingEvents = [];

function FMODcreate_event(_event_string)
{
    var _desc = fmod_studio_system_get_event(_event_string);
    var _inst = fmod_studio_event_description_create_instance(_desc);
    array_push(global.FMOD_existingEvents, _inst);
    return _inst;
}

function FMODget_eventLength(_event_string)
{
    var _desc = fmod_studio_system_get_event(_event_string);
    return fmod_studio_event_description_get_length(_desc);
}

function FMODevent_oneshot(_event_string, _x, _y)
{
    var _inst = FMODcreate_event(_event_string);
    fmod_studio_event_instance_start(_inst);
    
    if (!is_undefined(_x) && !is_undefined(_y))
        FMODSet3dPos(_inst, _x, _y);
    
    fmod_studio_event_instance_release(_inst);
    return _inst;
}

function FMODSet3dPos(_event_ref, _x, _y)
{
    var _att = global.Fmod3dDefaults;
    _att.position = 
    {
        x: _x,
        y: _y,
        z: 0
    };
    fmod_studio_event_instance_set_3d_attributes(_event_ref, _att);
}

function FMODsetPauseAll(arg0)
{
    for (var i = 0; i < array_length(global.FMOD_existingEvents); i++)
    {
        if (fmod_studio_event_instance_is_valid(global.FMOD_existingEvents[i]))
            fmod_studio_event_instance_set_paused(global.FMOD_existingEvents[i], arg0);
    }
}

function FMODstopAll()
{
    for (var i = 0; i < array_length(global.FMOD_existingEvents); i++)
    {
        if (fmod_studio_event_instance_is_valid(global.FMOD_existingEvents[i]))
            fmod_studio_event_instance_stop(global.FMOD_existingEvents[i], states.normal);
    }
}

function FMODevent_isplaying(_event_ref)
{
    return fmod_studio_event_instance_get_playback_state(_event_ref) == states.normal;
}

function FMODevent_isstarting(_event_ref)
{
    return fmod_studio_event_instance_get_playback_state(_event_ref) == states.mach2;
}

function FMODget_path(_event_ref)
{
    var _des = fmod_studio_event_instance_get_description(_event_ref);
    return fmod_studio_event_description_get_path(_des);
}
