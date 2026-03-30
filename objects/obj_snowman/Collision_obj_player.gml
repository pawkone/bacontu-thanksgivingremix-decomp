instance_create_depth(x, y, depth, obj_baddiedead).sprite_index = sprite_index;
scr_transfotip(lang_get_phrase("tip_ski"));

with (obj_player)
{
    movespeed = 10;
    state = states.ski;
}

instance_destroy();
