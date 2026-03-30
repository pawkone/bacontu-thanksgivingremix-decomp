if (ds_list_find_index(global.saveroom, id) == -1)
{
    ds_list_add(global.saveroom, id);
    FMODevent_oneshot("event:/Sfx/General/Enemy/Monolith/cupdead", x, y);
    
    with (instance_create_depth(x + (sprite_width / 2), y + (sprite_height / 2), -5, obj_baddiedead))
    {
        sprite_index = spr_mugmonolith_dead;
        hsp = random_range(5, 7) * sign(x - obj_player.x);
        image_xscale = other.image_xscale;
    }
    
    repeat (8)
    {
        create_particleDebri(spr_baddie_gibs, irandom_range(0, sprite_get_number(spr_baddie_gibs)), x, y, 1, -5);
        create_particleDebri(spr_slapstar, irandom_range(0, sprite_get_number(spr_slapstar)), x, y, 1, -5);
    }
    
    instance_create_depth(x, y, -4, obj_goodmourning);
    instance_create_depth(x, y, -300, obj_whiteflash);
    global.escape.active = true;
    obj_camera.camera.zoom = 2;
}
