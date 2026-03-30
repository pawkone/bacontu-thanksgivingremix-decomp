if (obj_player.state == states.enterdoor && !instance_exists(obj_fadeout) && obj_player.x == (x + (sprite_width / 2)))
{
    FMODevent_oneshot("event:/Sfx/General/Level/Progression/door");
    instance_create_depth(x, y, -1, obj_fadeout);
}
