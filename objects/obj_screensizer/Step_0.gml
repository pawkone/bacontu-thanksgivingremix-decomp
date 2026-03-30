gameframe_update();

if (gameframe_mouse_in_window())
{
    if (mouse_in_window == false)
    {
        mouse_in_window = true;
        gameframe_visible_time = 180;
        mouseX = window_mouse_get_x();
        mouseY = window_mouse_get_y();
    }
    
    if (window_mouse_get_x() != mouseX || window_mouse_get_y() != mouseY)
        mouse_in_window = false;
}
else if (mouse_in_window == true)
{
    mouse_in_window = false;
}

if (global.gameframe_alpha > 0)
    global.gameframe_default_cursor = -2;
else
    global.gameframe_default_cursor = -1;

if (gameframe_visible_time > 0)
{
    gameframe_visible_time--;
    global.gameframe_alpha = approach(global.gameframe_alpha, 1, 0.1);
}
else
{
    global.gameframe_alpha = approach(global.gameframe_alpha, 0, 0.1);
}

__display_set_gui_size_hook(displayWidth, displayHeight);
surface_resize(application_surface, displayWidth, displayHeight);
fmod_studio_system_set_parameter_by_name("SfxVolume", global.SfxVolume, true);
fmod_studio_system_set_parameter_by_name("AmbianceVolume", global.AmbianceVolume, true);

if (instance_exists(obj_monolith) && !obj_pause.active)
    fmod_studio_system_set_parameter_by_name("MusicVolume", (global.MusicVolume * 1) - obj_music.pillar, true);
else
    fmod_studio_system_set_parameter_by_name("MusicVolume", global.MusicVolume, true);

var _master = global.MasterVolume;

if (!window_has_focus() && global.unfocus_mute)
    _master = 0;

fmod_studio_system_set_parameter_by_name("MasterVolume", _master, true);
