scr_collision();
mask_index = spr_player_mask;

if (y > (room_height + 100) || y < -100)
    instance_destroy();

if ((x > (room_width + 100) || x < -100 || y < -100) && state == states.thrown)
    instance_destroy();

if (escape && !global.escape.active)
    instance_deactivate_object(self);

with (obj_player)
{
    if (place_meeting(x + hsp, y + vsp, other) && hitstun.is == false && other.state != states.hit)
    {
        var _baddie = other;
        
        if (state == states.mach2 || state == states.tumble)
        {
            with (_baddie)
            {
                FMODevent_oneshot("event:/Sfx/Player/bump", x, y);
                xs = 3;
                ys = 0.5;
                vsp = -5;
                xscale = obj_player.xscale;
                scared = 120;
                state = states.stun;
                movespeed = abs(8 + (other.movespeed / 2));
                sprite_index = spr_stun;
            }
        }
        
        if (state == states.grab)
        {
            state = states.hauling;
            sprite_index = spr_player_haulingland;
            image_index = 0;
            enemyID = _baddie;
            
            if (!grounded)
            {
                jumpstop = true;
                vsp = -6;
            }
            
            with (_baddie)
            {
                playerID = other;
                xs = 3;
                ys = 0.5;
                sprite_index = spr_stun;
                state = states.grab;
            }
        }
        
        if (instakill)
        {
            FMODevent_oneshot("event:/Sfx/Player/punch", x, y);
            
            if (state == states.mach3)
            {
                sprite_index = spr_player_mach3hit;
                image_index = 0;
            }
            
            hitstun.x = x;
            hitstun.y = y;
            hitstun.time = 5;
            hitstun.is = true;
            create_particleStatic(spr_kungfueffect, x, y, 1, -5);
            
            with (_baddie)
            {
                xs = 3;
                ys = 0.5;
                hitstun.x = x;
                hitstun.y = y;
                hitstun.time = 5;
                hitstun.is = true;
                sprite_index = spr_stun;
                state = states.hit;
            }
        }
    }
}
