var pos = ds_list_find_index(global.followers, id) + 1;
var xx = obj_player.x;
var yy = obj_player.y;
var xscale = obj_player.xscale;
ds_queue_enqueue(followqueue, xx);
ds_queue_enqueue(followqueue, yy);
ds_queue_enqueue(followqueue, xscale);

if (ds_queue_size(followqueue) > (lag * pos))
{
    gx = ds_queue_dequeue(followqueue);
    gy = ds_queue_dequeue(followqueue);
    image_xscale = ds_queue_dequeue(followqueue);
}

var targetX = gx - (32 * image_xscale * pos);

if (!obj_player.hitstun.is)
{
    var point = point_direction(x, y, targetX, gy);
    var lx = lengthdir_x(movespeed, point);
    var ly = lengthdir_y(movespeed, point);
    x = approach(x, targetX, abs(lx));
    y = approach(y, gy, abs(ly));
}

if (ds_list_find_index(global.followers, id) == -1)
    instance_destroy();
