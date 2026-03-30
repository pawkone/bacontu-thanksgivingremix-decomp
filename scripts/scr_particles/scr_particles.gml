function create_particleStatic(_sprite, _x, _y, _xscale, _depth = 1)
{
    var par = 
    {
        type: 0,
        sprite_index: _sprite,
        image_index: 0,
        image_angle: 0,
        x: _x,
        y: _y,
        image_xscale: _xscale,
        depth: _depth,
        hsp: 0,
        vsp: 0,
        grav: 0,
        image_speed: 0.35
    };
    ds_list_add(obj_particleSystem.particles, par);
    return par;
}

function create_particleDebri(_sprite, _frame, _x, _y, _xscale, _depth = 1, _angle = random_range(0, 360), _hsp = random_range(-5, 5), _vsp = random_range(10, -10))
{
    var par = create_particleStatic(_sprite, _x, _y, _xscale, _depth);
    
    with (par)
    {
        hsp = _hsp;
        vsp = _vsp;
        grav = 0.4;
        image_index = _frame;
        image_angle = _angle;
        image_speed = 0;
    }
    
    return par;
}

function create_collect(_sprite, _x, _y, _accurate_to_cam = false)
{
    if (_accurate_to_cam == false)
    {
        _x -= camera_get_view_x(view_camera[0]);
        _y -= camera_get_view_y(view_camera[0]);
    }
    
    var par = 
    {
        sprite_index: _sprite,
        x: _x,
        y: _y,
        hsp: 0,
        vsp: 0,
        Hmvsp: 0,
        Vmvsp: 0
    };
    ds_list_add(obj_hud.collectVis, par);
    return par;
}

function create_afterimage(_sprite, _frame, _x, _y, _xscale, _alpha = 1)
{
    var aft = 
    {
        sprite_index: _sprite,
        image_index: _frame,
        x: _x,
        y: _y,
        image_xscale: _xscale,
        image_blend: choose(255, 16711680),
        alarm: [15, 5, -2],
        type: states.normal,
        alpha: _alpha,
        image_alpha: 1
    };
    ds_list_add(obj_afterimageSystem.afterimages, aft);
    return aft;
}

function create_buzzsawAfterimage(_sprite, _frame, _x, _y, _xscale, _unknown = 1)
{
    var q = create_afterimage(_sprite, _frame, _x, _y, _xscale, 0.8);
    q.image_blend = c_white;
    q.type = states.mach3;
    return q;
}

function create_blur_effect(_sprite, _frame, _x, _y, _xscale)
{
    var q = create_afterimage(_sprite, _frame, _x, _y, _xscale, 0.8);
    q.image_blend = c_white;
    q.type = states.crouch;
    return q;
}
