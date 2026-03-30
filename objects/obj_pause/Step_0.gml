if (!instance_exists(obj_option))
    getMenu_input();

var _nopauseRooms = room == rm_intro || room == avocadoEngine || instance_exists(obj_fadeout) || instance_exists(obj_rank) || obj_shell.isOpen;

if (!active && key_start2 && !_nopauseRooms)
{
    doPause();
}
else if (active && !instance_exists(obj_option) && buffer == 0)
{
    graphBack.alpha = approach(graphBack.alpha, 0.55, 0.01);
    var move = key_down2 - key_up2;
    
    if (move != 0)
        selected += move;
    
    selected = clamp(selected, 0, array_length(options) - 1);
    
    if (key_slap2 || key_start2)
        doUnpause();
    
    if (key_jump2)
        options[selected].func();
    
    var _pos = fmod_studio_event_instance_get_timeline_position(pauseMusic) * 0.01;
    fmod_studio_event_instance_set_parameter_by_name(pauseMusic, "state", disc.side);
    disc.rotation = lerp(disc.rotation, -_pos, 0.1);
    
    if (key_taunt2 && abs(disc.xscale) == 1)
    {
        disc.side++;
        disc.side = wrap(disc.side, 0, 1);
        disc.facing *= -1;
    }
    
    disc.xscale = approach(disc.xscale, disc.facing, 0.1);
    
    if (disc.xscale == 0)
        disc.index = disc.side;
}

buffer = approach(buffer, 0, 1);
