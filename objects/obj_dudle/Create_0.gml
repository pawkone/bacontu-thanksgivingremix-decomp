image_speed = 0.067;
depth = 50;
cutscene = false;
facing = sign(image_xscale);
image_xscale = 1;

if (ds_list_find_index(global.saveroom, id) != -1 && obj_player.door == "DOODLE")
{
    obj_player.x = x;
    obj_player.y = y;
    instance_destroy();
    
    if (obj_player.state == -4)
        instance_create_depth(x, y, depth, obj_dudleEnter).facing = facing;
}
