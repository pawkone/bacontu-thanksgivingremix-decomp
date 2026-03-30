fmod_studio_system_update();
var _x = camera_get_view_x(view_camera[0]) + (camera_get_view_width(view_camera[0]) / 2);
var _y = camera_get_view_y(view_camera[0]) + (camera_get_view_height(view_camera[0]) / 2);
var _att = global.Fmod3dDefaults;
_att.position = 
{
    x: _x,
    y: _y,
    z: 0
};
fmod_studio_system_set_listener_attributes(0, _att);
fmod_studio_system_update();
