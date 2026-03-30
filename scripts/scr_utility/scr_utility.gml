function animation_end()
{
    return (image_index + (image_speed * sprite_get_speed(sprite_index))) >= image_number;
}

function shake_camera(_intensity)
{
    obj_camera.cameraShake = _intensity;
}

function tv_anim(_sprite, _time = 0)
{
    with (obj_hud.tv)
    {
        if (expressionSprite != _sprite)
        {
            switchindex = 0;
            state = states.move;
            expressionSprite = _sprite;
            expressionTimer = _time;
        }
    }
}

function scr_cutoff()
{
    for (var _x = 0; _x < abs(sprite_width / 32); _x++)
    {
        instance_create_depth(x + (_x * 32) + 32, y, -5, obj_cutoff, 
        {
            image_angle: 180
        });
        instance_create_depth(x + (_x * 32), y + sprite_height, -5, obj_cutoff);
    }
    
    for (var _y = 0; _y < abs(sprite_height / 32); _y++)
    {
        instance_create_depth(x + sprite_width, y + (_y * 32) + 32, -5, obj_cutoff, 
        {
            image_angle: 90
        });
        instance_create_depth(x, y + (_y * 32), -5, obj_cutoff, 
        {
            image_angle: -90
        });
    }
}

function add_saveVariable(_section, _key, _value, _ini = working_directory + "options.ini")
{
    var q = 
    {
        ini: _ini,
        section: _section,
        key: _key,
        val: _value
    };
    if (!array_contains(obj_savesystem.saveVariables, string("{0}{1}", _section, _key)))
        array_push(obj_savesystem.saveVariables, string("{0}{1}", _section, _key));
    ds_map_set(obj_savesystem.saveVariablesList, string("{0}{1}", _section, _key), q);
}

function push_saveVariables()
{
    with (obj_savesystem)
    {
        if (array_length(saveVariables) != 0)
        {
            for (var i = 0; i < array_length(saveVariables); i++)
            {
                var q = ds_map_find_value(saveVariablesList, saveVariables[i]);
                ini_open(q.ini);
                
                if (is_string(q.val))
                    ini_write_string(q.section, q.key, q.val);
                else
                    ini_write_real(q.section, q.key, q.val);
                
                ini_close();
            }
            
            ds_map_clear(saveVariablesList);
            saveiconTimer = 10 * array_length(saveVariables);
            saveVariables = [];
        }
    }
}

function create_smalltext(_text, _x = x, _y = y)
{
    instance_create_depth(_x, _y, depth, obj_smalltext).text = _text;
}

function in_camera(_left = bbox_left, _right = bbox_right, _bottom = bbox_bottom, _top = bbox_top)
{
    var camx = camera_get_view_x(view_camera[0]);
    var camy = camera_get_view_y(view_camera[0]);
    var camw = camera_get_view_width(view_camera[0]);
    var camh = camera_get_view_height(view_camera[0]);
    return _left < (camx + camw) && _right > camx && _top < (camy + camh) && _bottom > camy;
}

function tile_delete(_x, _y)
{
    var layers = layer_get_all();
    for (var i = 0; i < array_length(layers); i++)
    {
        var lay = layers[i];
        var layer_name = layer_get_name(lay);
        if (layer_name != "Tiles_BG1" && layer_name != "Tiles_BG" && layer_name != "Tiles_BG2" && layer_name != "Tiles_BG3")
        {
            var ID = layer_get_id(layer_name);
            var tilemapID = layer_tilemap_get_id(ID);
            var tiledata = tilemap_get_at_pixel(tilemapID, _x, _y);
            tile_set_empty(tiledata);
            tilemap_set_at_pixel(tilemapID, 0, _x, _y);
        }
    }
}

function escape_background(_old, _new)
{
    var layers = layer_get_all();
    
    for (var i = 0; i < array_length(layers); i++)
    {
        var lay = layers[i];
        var layer_name = layer_get_name(lay);
        var ID = layer_get_id(layer_name);
        var BGID = layer_background_get_id(ID);
        var BGSPR = layer_background_get_sprite(BGID);
        
        if (BGSPR == _old && global.escape.active)
            layer_background_sprite(BGID, _new);
        else if (BGSPR == _new && !global.escape.active)
            layer_background_sprite(BGID, _old);
    }
}

function scr_transfotip(_text)
{
    if (instance_exists(obj_transfotip))
        instance_destroy(obj_transfotip);
    
    var q = instance_create_depth(x, y, -10, obj_transfotip);
    
    with (q)
        text = _text;
    
    return q;
}

function calculateTime(_time)
{
    var _ms = round(wrap(_time, 0, 59));
    
    if (_ms < 10)
        _ms = string_concat("0", _ms);
    
    var _s = round(wrap(_time / 60, 0, 59));
    
    if (_s < 10)
        _s = string_concat("0", _s);
    
    var _m = round(wrap(_time / 3600, 0, 59));
    
    if (_m < 10)
        _m = string_concat("0", _m);
    
    var _h = round(_time / 216000);
    
    if (_h < 10)
        _h = string_concat("0", _h);
    
    return string("{0}:{1}:{2}.{3}", _h, _m, _s, _ms);
}
