surface_reset_target();
draw_clear(c_black);
gpu_set_blendenable(false);
draw_sprite_tiled(spr_letterbox, 0, 0, 0);
draw_rectangle_color(-1, -1, obj_screensizer.displayWidth + 1, obj_screensizer.displayHeight + 1, c_black, c_black, c_black, c_black, false);
draw_surface_stretched(gameSurface, 0 + ((obj_screensizer.displayWidth / 2) * (1 - size)), 0 + ((obj_screensizer.displayHeight / 2) * (1 - size)), obj_screensizer.displayWidth * size, obj_screensizer.displayHeight * size);
gpu_set_blendenable(true);
gameframe_draw();
var devWindow = [];
array_push(devWindow, "POWERED BY AVOCADO ENGINE");
array_push(devWindow, "PROPERTY OF THE SALTSHAKERS");
array_push(devWindow, "exe");
array_push(devWindow, date_datetime_string(date_current_datetime()));
draw_set_font(font_caption);
draw_set_halign(fa_left);
draw_set_alpha(0.35);
draw_set_color(c_black);
var _width = 0;
var _height = 0;

for (var i = 0; i < array_length(devWindow); i++)
{
    if (string_width(devWindow[i]) > _width)
        _width = string_width(devWindow[i]);
    
    _height += string_height(devWindow[i]);
}

var _x = x;
var _y = y;
draw_set_alpha(1);
draw_set_color(c_white);

if (global.debug)
{
    draw_set_font(font_dialogPlaceholder);
    draw_set_halign(fa_left);
    var _vars = [];
    
    if (instance_exists(obj_player))
    {
        if (obj_player.x < 0 || obj_player.x > room_width || obj_player.y < 0 || obj_player.y > room_height)
        {
            _x = obj_player.x - camera_get_view_x(view_camera[0]);
            _x = clamp(_x, 32, obj_screensizer.displayWidth - 32);
            _y = obj_player.y - camera_get_view_y(view_camera[0]);
            _y = clamp(_y, 32, obj_screensizer.displayHeight - 32);
            draw_sprite(obj_player.sprite_index, obj_player.image_index, _x, _y);
        }
        
        array_push(_vars, string("X: {0}", obj_player.x));
        array_push(_vars, string("Y: {0}", obj_player.y));
        array_push(_vars, string("VSP: {0}", obj_player.vsp));
        array_push(_vars, string("HSP: {0}", obj_player.hsp));
        array_push(_vars, string("MOVESPEED: {0}", obj_player.movespeed));
        array_push(_vars, string("HUB X: {0}", obj_player.backtohubX));
        array_push(_vars, string("HUB Y: {0}", obj_player.backtohubY));
    }
    
    if (instance_exists(obj_camera))
    {
        array_push(_vars, string("CAMERA X: {0}", obj_camera.camera.x));
        array_push(_vars, string("CAMERA Y: {0}", obj_camera.camera.y));
    }
    
    array_push(_vars, string("FPS: {0}", fps));
    array_push(_vars, string("REAL FPS: {0}", fps_real));
    
    if (instance_exists(obj_server))
    {
        array_push(_vars, ds_list_size(obj_server.connections));
        array_push(_vars, instance_number(obj_onlinePlayer));
    }
    
    for (var i = 0; i < array_length(_vars); i++)
        draw_text(32, 100 + (32 * i), _vars[i]);
}
