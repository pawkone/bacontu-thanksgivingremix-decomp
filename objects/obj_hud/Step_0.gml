visible = hudVisible();

with (kettle)
{
    kx = lerp(kx, 124 + wave(2, -2, 15, 10), 0.2);
    ky = lerp(ky, 74 + wave(5, -5, 10, 11), 0.05);
    rankScale = approach(rankScale, 1, 0.2);
    cloudIndex += 0.15;
}

with (tv)
{
    var isSecret = string_pos("secret", string_letters(room_get_name(room))) > 0;
    var _idleSprite = spr_tv_idle;
    
    if (isSecret)
        _idleSprite = spr_tv_idle;
    
    if (global.escape.active && !isSecret)
        _idleSprite = spr_tv_escape;
    
    if (obj_player.state == states.ski)
        _idleSprite = spr_tv_ski;
    
    if (!other.visible)
    {
        state = states.normal;
        sprite_index = spr_tv_off;
    }
    
    image_index += image_speed;
    
    switch (state)
    {
        case states.normal:
            switch (sprite_index)
            {
                case spr_tv_off:
                    image_index = 0;
                    sprite_index = spr_tv_turnon;
                    break;
                
                case spr_tv_turnon:
                    if (image_index >= sprite_get_number(sprite_index))
                    {
                        image_index = 0;
                        sprite_index = _idleSprite;
                    }
                    
                    break;
                
                case spr_tv_happy:
                    expressionTimer--;
                    
                    if (expressionTimer <= 0)
                        tv_anim(_idleSprite);
                    
                    break;
                
                case spr_tv_crazyrun:
                case spr_tv_mach:
                    if (obj_player.state != states.mach3 && obj_player.state != states.climbwall && obj_player.state != states.buzzsaw)
                        tv_anim(_idleSprite);
                    
                    if (obj_player.mach4mode && expressionSprite == spr_tv_mach)
                        tv_anim(spr_tv_crazyrun);
                    
                    if (!obj_player.mach4mode && expressionSprite == spr_tv_crazyrun)
                        tv_anim(spr_tv_mach);
                    
                    break;
                
                case spr_tv_doodle:
                case spr_tv_escape:
                case spr_tv_idle:
                case spr_tv_ski:
                    var roomname = room_get_name(room);
                    roomname = string_letters(roomname);
                    isSecret = string_pos("secret", roomname) > 0;
                    
                    if (expressionSprite != _idleSprite)
                        tv_anim(_idleSprite);
                    
                    if (obj_player.state == states.mach3)
                        tv_anim(spr_tv_mach);
                    
                    break;
            }
            
            break;
        
        case states.move:
            switchindex = approach(switchindex, sprite_get_number(spr_tv_switch) - 1, 0.35);
            
            if (switchindex >= (sprite_get_number(spr_tv_switch) - 1))
            {
                sprite_index = expressionSprite;
                switchindex = 0;
                state = states.normal;
                image_speed = 0.35;
            }
            
            break;
    }
}

if (!ds_list_empty(collectVis))
{
    for (var i = 0; i < ds_list_size(collectVis); i++)
    {
        var q = ds_list_find_value(collectVis, i);
        
        with (q)
        {
            var targetxx = other.kettle.x;
            var targetyy = other.kettle.y;
            var point = point_direction(x, y, targetxx, targetyy);
            hsp = lengthdir_x(24, point);
            vsp = lengthdir_y(24, point);
            x += hsp;
            y += vsp;
            
            if (point_distance(x, y, targetxx, targetyy) <= 25)
            {
                with (other)
                {
                    kettle.ky = 90;
                    q = undefined;
                    ds_list_delete(collectVis, i);
                    i--;
                }
            }
        }
    }
}

global.Arank = global.Srank / 2;
global.Brank = global.Arank / 1.5;
global.Crank = global.Brank / 1.3;
