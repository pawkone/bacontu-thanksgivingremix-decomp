image_index = global.combo.dropped;
grav = 1;
i2 = 0;
vsp = -8;
image_speed = 0;
dontdraw = false;
particles = ds_list_create();
hspeed = -5;

particleStatic = function(arg0, arg1, arg2, arg3, arg4 = 1)
{
    var par = 
    {
        type: 0,
        sprite_index: arg0,
        image_index: 0,
        image_angle: 0,
        x: arg1,
        y: arg2,
        image_xscale: arg3,
        depth: arg4,
        hsp: 0,
        vsp: 0,
        grav: 0,
        image_speed: 0.35
    };
    ds_list_add(particles, par);
    return par;
};

particleDebri = function(arg0, arg1, arg2, arg3, arg4, arg5 = 1, arg6 = random_range(0, 360), arg7 = random_range(-5, 5), arg8 = random_range(10, -10))
{
    var par = particleStatic(arg0, arg2, arg3, arg4, arg5);
    
    with (par)
    {
        hsp = arg8;
        vsp = arg7;
        grav = 0.4;
        image_index = arg1;
        image_angle = arg6;
        image_speed = 0;
    }
    
    return par;
};
