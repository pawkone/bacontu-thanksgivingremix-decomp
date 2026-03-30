if (obj_player.state != states.taunt)
    instance_destroy();

image_xscale = obj_player.xscale;
x = obj_player.x;
y = obj_player.y;

if (place_meeting(x, y, obj_forkbox))
{
    with (instance_place(x, y, obj_forkbox))
    {
        with (enemy_inst)
        {
            hitHsp = 25 * obj_player.xscale;
            hitVsp = 0;
            state = states.thrown;
        }
    }
    
    with (obj_player)
    {
        state = states.parry;
        sprite_index = asset_get_index("spr_player_parry1");
        FMODevent_oneshot("event:/Sfx/Player/parry", x, y);
        image_index = 0;
        movespeed = -6;
        flash = true;
    }
    
    shake_camera(25);
}

if (place_meeting(x, y, obj_dart))
{
    with (instance_place(x, y, obj_dart))
        instance_destroy();
    
    with (obj_player)
    {
        state = states.parry;
        sprite_index = asset_get_index("spr_player_parry1");
        FMODevent_oneshot("event:/Sfx/Player/parry", x, y);
        image_index = 0;
        movespeed = -6;
        flash = true;
    }
    
    shake_camera(25);
}
