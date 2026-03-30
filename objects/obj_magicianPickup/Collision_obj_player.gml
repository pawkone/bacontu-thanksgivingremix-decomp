instance_create_depth(x, y, depth, obj_magician);
FMODevent_oneshot("event:/Sfx/General/Level/Gerome/collect", x, y);
instance_destroy();
ds_list_add(global.saveroom, id);
