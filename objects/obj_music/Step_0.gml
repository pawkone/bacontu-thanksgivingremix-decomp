if (func != -4)
    func();

if (global.escape.active == false)
{
    panicStart = true;
    
    if (FMODevent_isplaying(escapeInst))
        fmod_studio_event_instance_stop(escapeInst, states.normal);
}
else if (panicStart == true)
{
    panicStart = false;
    
    if (!FMODevent_isplaying(escapeInst))
        fmod_studio_event_instance_start(escapeInst);
}
else
{
    if (fmod_studio_event_instance_get_paused(musicInst) == false)
        fmod_studio_event_instance_set_paused(musicInst, true);
    
    if (global.escape.party)
    {
        fmod_studio_event_instance_set_parameter_by_name(escapeInst, "state", 2);
        fmod_studio_event_instance_set_callback(escapeInst, FMOD_STUDIO_EVENT_CALLBACK.TIMELINE_BEAT);
    }
    else
    {
        fmod_studio_event_instance_set_parameter_by_name(escapeInst, "state", 0);
    }
}

if (instance_exists(obj_monolith))
{
    if (!FMODevent_isplaying(monolith) && !FMODevent_isstarting(monolith))
        fmod_studio_event_instance_start(monolith);
    
    fmod_studio_event_instance_set_paused(monolith, false);
    var _cam;
    
    with (obj_monolith)
        _cam = in_camera();
    
    pillar = approach(pillar, _cam, 0.016666666666666666);
}
else
{
    if (FMODevent_isplaying(monolith))
        fmod_studio_event_instance_stop(monolith, states.normal);
    
    pillar = 0;
}

fmod_studio_event_instance_set_parameter_by_name(monolith, "flitzani", pillar, true);
fmod_studio_system_set_parameter_by_name("singer", voices, true);
roomname = string_letters(room_get_name(room));
var _isSecret = string_pos("secret", roomname) > 0;

if (isSecret != _isSecret)
{
    isSecret = _isSecret;
    
    if (isSecret)
    {
        var _timelineMusic = fmod_studio_event_instance_get_timeline_position(musicInst);
        var _length = _timelineMusic / FMODget_eventLength(music.regular);
        var _pos = _length * FMODget_eventLength(music.secret);
        fmod_studio_event_instance_set_timeline_position(secretInst, _pos);
    }
}

var q = 0;

if (musicInst != -4)
    q = fmod_studio_event_instance_get_timeline_position(musicInst);

if (isSecret && secretInst != -4)
    q = fmod_studio_event_instance_get_timeline_position(secretInst);

global.songCurInf.pos = q;
var s = -4;

if (musicInst != -4)
    s = FMODget_path(musicInst);

if (isSecret && secretInst != -4)
    s = FMODget_path(secretInst);

currentMusic = s;
fmod_studio_event_instance_set_paused(escapeInst, isSecret);

if (musicInst != -4)
    fmod_studio_event_instance_set_paused(musicInst, isSecret || FMODevent_isplaying(escapeInst) || pauseMusic);

if (ambienceInst != -4)
    fmod_studio_event_instance_set_paused(ambienceInst, isSecret || FMODevent_isplaying(escapeInst) || pauseMusic);

if (secretInst != -4)
    fmod_studio_event_instance_set_paused(secretInst, !isSecret || pauseMusic);
