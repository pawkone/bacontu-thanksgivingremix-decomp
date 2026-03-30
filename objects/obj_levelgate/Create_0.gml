image_speed = 0;
depth = 30;
gateinfo = ds_list_create();

function create_gate_layer(arg0, arg1, arg2, arg3, arg4, arg5, arg6 = false)
{
    var q = 
    {
        sprite_index: arg0,
        image_index: arg1,
        bgx: arg2,
        bgy: arg3,
        hsp: arg4,
        vsp: arg5,
        parallax: arg6
    };
    ds_list_add(gateinfo, q);
    return q;
}

create_gate_layer(spr_gate_entranceBG, 0, 0, 0, 0, 0);
create_gate_layer(spr_gate_entranceBG, 1, 0, 0, 0.35, 0);
create_gate_layer(spr_gate_entranceBG, 2, 0, 0, 0.25, 0);
bgalpha = 1;
visibleradius = 250;
textalpha = 0;
drawing = 0;
