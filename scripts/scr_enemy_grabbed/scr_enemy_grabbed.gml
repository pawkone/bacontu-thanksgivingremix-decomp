function scr_enemy_grabbed()
{
    image_speed = 0.35;
    hsp = 0;
    vsp = 0;
    movespeed = 0;
    xscale = playerID.xscale;
    
    if (playerID.state == states.hauling)
    {
        x = playerID.x - (15 * xscale);
        y = playerID.y - 42;
    }
    else if (playerID.state == states.groundpound || playerID.state == states.groundpoundstart)
    {
        x = playerID.x + (45 * xscale);
        y = playerID.y - 25;
    }
    else
    {
        x = playerID.x + (50 * xscale);
        y = playerID.y - 5;
    }
    
    if (playerID.state != states.hauling && playerID.state != states.finishingblow && playerID.state != states.groundpoundstart && playerID.state != states.groundpound)
    {
        xscale = obj_player.xscale;
        scared = 120;
        state = states.stun;
        x = playerID.x;
        y = playerID.y;
    }
}

function scr_enemy_thrown()
{
    image_speed = 0.35;
    sprite_index = spr_stun;
    
    if (hsp != 0)
        xscale = sign(-hsp);
    
    hsp = hitHsp;
    vsp = hitVsp;
    
    if (place_meeting(x + hsp, y + vsp, obj_solid))
        instance_destroy();
    
    if (place_meeting(x + hsp, y + vsp, obj_baddie))
    {
        with (instance_place(x + hsp, y + vsp, obj_baddie))
            instance_destroy();
    }
    
    with (obj_destructibles)
    {
        with (other)
        {
            if (place_meeting(x + (hsp * 2) + xscale, y + (vsp * 2), other))
            {
                var _destroy = true;
                
                if (_destroy)
                    instance_destroy(other);
            }
        }
    }
}
